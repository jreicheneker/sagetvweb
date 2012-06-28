#!/bin/bash

# Builds the following components:
# libfaac
# libfaad2
# xvidcore
# libx264

# then builds FFmpeg and MPlayer

# everything is built in "build" and installed to "stage" so it doesn't clutter up your system

# necessary environment variables
#export ROOT_DIR=${ROOT_DIR:-`cd ..;pwd`}
export ROOT_DIR=${ROOT_DIR:-`pwd`}
export CODEC_DIR=${CODEC_DIR:-${ROOT_DIR}/codecs}
export FAAC_DIR=${FAAC_DIR:-${CODEC_DIR}/faac}
export FAAD2_DIR=${FAAD2_DIR:-${CODEC_DIR}/faad2}
export XVID_DIR=${XVID_DIR:-${CODEC_DIR}/xvidcore}
export X264_DIR=${X264_DIR:-${CODEC_DIR}/x264}
#export FFMPEG_DIR=${FFMPEG_DIR:-${ROOT_DIR}/mplayerhq/ffmpeg}
export FFMPEG_DIR=${FFMPEG_DIR:-${CODEC_DIR}/ffmpeg}

# place to store incoming tarballs
export TARBALL_DIR=${TARBALL_DIR:-`pwd`/packages}

# where we'll stage everything
export STAGE_DIR=${STAGE:-`pwd`/stage}
export STAGE_BIN=${STAGE_BIN:-${STAGE_DIR}/bin}
export STAGE_INC=${STAGE_INC:-${STAGE_DIR}/include}
export STAGE_LIB=${STAGE_LIB:-${STAGE_DIR}/lib}


# temporary build path
export BUILD_DIR=${BUILD_DIR:-`pwd`/build}


# toolchain path
export BIN_DIR=${BIN_DIR:-/opt/mingw/bin}


# native tools for host
export CC_FOR_BUILD=gcc
export NATIVE_HOST=${NATIVE_HOST:-`./config.guess`}

require_dir () {
	if test ! -d "$1"; then
		echo "Directory missing: \"$1\""
		exit 0
	fi
}

# test source paths to make sure everything exists
require_dir "${ROOT_DIR}"
require_dir "${CODEC_DIR}"
require_dir "${FAAC_DIR}"
require_dir "${FAAD2_DIR}"
require_dir "${XVID_DIR}"
require_dir "${X264_DIR}"
require_dir "${FFMPEG_DIR}"

# cross-compile toolchain commands
TARGET=i686-pc-mingw32
CC=${TARGET}-gcc
CXX=${TARGET}-g++
LD=${TARGET}-ld
NM=${TARGET}-nm
AS=${TARGET}-as
RANLIB=${TARGET}-ranlib
AR=${TARGET}-ar
DLLTOOL=${TARGET}-dlltool
STRIP=${TARGET}-strip
WINDRES=${TARGET}-windres

test -d "${STAGE_DIR}" || mkdir "${STAGE_DIR}"
test -d "${BUILD_DIR}" || mkdir "${BUILD_DIR}"
test -d "${TARBALL_DIR}" || mkdir "${TARBALL_DIR}"

# make sure our toolchain is in the PATH
echo $PATH | grep -q "${BIN_DIR}" || export PATH=$PATH:"${BIN_DIR}"

# libfaac
if test ! -f "${FAAC_DIR}/configure" ; then
	pushd "${FAAC_DIR}"
	sh bootstrap
	popd
fi
mkdir -p "${BUILD_DIR}/faac"
pushd "${BUILD_DIR}/faac"
	test -f Makefile || \
		"${FAAC_DIR}"/configure --prefix="${STAGE_DIR}" \
			CC=${CC} CXX=${CXX} CFLAGS="-fno-common" \
			--enable-static --disable-shared --without-mp4v2 \
			--build=${NATIVE_HOST} --host=${TARGET} \
		|| exit $?
	test -f libfaac/.libs/libfaac.a || \
		make ${MAKE_JOBS} -C libfaac || exit $?
	test -f "${STAGE_INC}"/faac.h || \
		make -C include install || exit $?
	test libfaac/.libs/libfaac.a -nt "${STAGE_LIB}"/libfaac.a && \
		make -C libfaac install
popd

# libfaad
if test ! -f "${FAAD2_DIR}/configure" ; then
	pushd "${FAAD2_DIR}"
	sh bootstrap
	popd
fi
mkdir -p "${BUILD_DIR}/faad2"
pushd "${BUILD_DIR}/faad2"
	test -f Makefile || \
		"${FAAD2_DIR}"/configure --prefix="${STAGE_DIR}" \
			CC=${CC} CXX=${CXX} CFLAGS="-fno-common" \
			--without-xmms --without-mpeg4ip --without-drm \
			--build=${NATIVE_HOST} --host=${TARGET} \
		|| exit $?
	make ${MAKE_JOBS} -C libfaad
	test libfaad/.libs/libfaad.a -nt "${STAGE_LIB}"/libfaad.a && \
		make -C libfaad install
popd

# xvidcore
mkdir -p "${BUILD_DIR}/xvidcore"
pushd "${BUILD_DIR}/xvidcore"
if test ! -f configure ; then
	rsync -av --cvs-exclude "${XVID_DIR}"/build/generic/* . || exit $?
	cp sources.inc{,.bak}
	CLEAN_DIR=`echo ${XVID_DIR} | sed -e 's/ /\\\ /g'`
	cat sources.inc.bak | sed -e "s|SRC_DIR =.*|SRC_DIR = ${CLEAN_DIR}/src|g" > sources.inc
	sh bootstrap.sh || exit $?
	# stupid libtoolize deletes config.{guess,sub}
	automake -c --add-missing >/dev/null 2>&1
	# now fix the pthread detection so it actually uses pthreads
#	cp configure{,.bak}
#	cat configure.bak | sed -e "s/-lpthread/-lpthreadGC2 -lws2_32/g" > configure
fi
if test ! -f platform.inc ; then
	./configure --prefix="${STAGE_DIR}" \
		CFLAGS="-fno-common" \
		--build=${NATIVE_HOST} --host=${TARGET} \
	|| exit $?
fi
test -f \=build/xvidcore.a || \
	make ${MAKE_JOBS}
if test \=build/xvidcore.a -nt "${STAGE_LIB}"/libxvidcore.a; then
	make install || exit $?
	rm -f "${STAGE_LIB}"/xvidcore.dll
	test -f "${STAGE_LIB}"/xvidcore.a && mv "${STAGE_LIB}"/{,lib}xvidcore.a
fi
popd

# libx264
mkdir -p "${BUILD_DIR}"/x264
pushd "${BUILD_DIR}"/x264
if test ! -f configure ; then
	rsync -av --cvs-exclude "${X264_DIR}"/* .
	cp configure{,.bak}
	cat configure.bak | sed -e 's|DEVNULL="NUL"|DEVNULL="/dev/null"|g'  > configure
fi
test -f config.mak || \
	CC=${CC} AR=${AR} RANLIB=${RANLIB} STRIP=${STRIP} ./configure --prefix="${STAGE_DIR}" \
		--extra-cflags="-fasm -fno-common -D_FILE_OFFSET_BITS=64" \
		--disable-avis-input --disable-mp4-output --enable-pthread \
		--host=${TARGET} \
	|| exit $?
test -f libx264.a || \
	make ${MAKE_JOBS} libx264.a || exit $?
# install libx64.a and x264.h manually
test libx264.a -nt "${STAGE_LIB}"/libx264.a && install libx264.a "${STAGE_LIB}"
test x264.h -nt "${STAGE_LIB}"/x264.h && install x264.h "${STAGE_INC}"
popd


# ffmpeg
mkdir -p "${BUILD_DIR}"/ffmpeg
pushd "${BUILD_DIR}"/ffmpeg
test -f config.mak || \
	${FFMPEG_DIR}/configure --target-os=mingw32 \
			--prefix="${STAGE_DIR}" \
			--disable-ffplay --disable-ffserver \
			--enable-gpl --enable-nonfree \
			--disable-encoder=aac \
			--disable-demuxer=ea --disable-devices \
			--enable-libxvid --enable-libx264 \
			--enable-libfaac \
			--enable-static --disable-shared \
			--enable-pthreads \
			--disable-debug \
			--enable-memalign-hack --arch=x86 \
			--extra-cflags="-fno-common -march=i686 -mtune=i686 -DWIN32 -I${STAGE_INC}" \
			--extra-ldflags="-L${STAGE_LIB}" \
			--enable-cross-compile --cross-prefix=${TARGET}- \
	|| exit $?
make ${MAKE_JOBS} || exit $?
 # installing here ensures the libavXXX.a libraries are available for building MPlayer too
make install
popd

exit 0
