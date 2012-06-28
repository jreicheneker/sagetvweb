/**
 * Wrapper class for the HTML 5 video element with Sage-specific features
 * @return
 */
function SageVideo(videoElementId, sageAiringId/*, callback*/)
{
	this.videoElementId = videoElementId;
	this.airingId = sageAiringId;
	this.init();
}

SageVideo.prototype.init = function()
{
	this.videoElement = this.getVideoElement();

	if (this.videoElement != null)
	{
		this.videoElement.addEventListener('touchstart', this, false);
		this.videoElement.addEventListener('touchend', this, false);
		this.videoElement.addEventListener('canplaythrough', this, false);
		this.videoElement.addEventListener('canplay', this, false);
		this.videoElement.addEventListener('loadstart', this, false);
		this.videoElement.addEventListener('loadeddata', this, false);
		this.videoElement.addEventListener('loadedmetadata', this, false);
		this.videoElement.addEventListener('error', this, false);
		this.videoElement.addEventListener('pause', this, false);
		this.videoElement.addEventListener('play', this, false);
		this.videoElement.addEventListener('playing', this, false);
		this.videoElement.addEventListener('progress', this, false);
		this.videoElement.addEventListener('timeupdate', this, false);
		this.videoElement.addEventListener('durationchange', this, false);
		this.videoElement.addEventListener('ended', this, false);

		this.videoElement.addEventListener('ratechange', this, false);
		this.videoElement.addEventListener('seeked', this, false);
		this.videoElement.addEventListener('seeking', this, false);
		this.videoElement.addEventListener('stalled', this, false);
		this.videoElement.addEventListener('suspend', this, false);
		this.videoElement.addEventListener('waiting', this, false);
	}
}

SageVideo.prototype.handleEvent = function(event)
{
    log('event.type = ' + event.type);

    if (typeof(this[event.type]) === 'function')
	{
		return this[event.type](event);
	}
};

SageVideo.prototype.getVideoElement = function()
{
	videoElement = document.getElementById(this.videoElementId);
	return videoElement;
};

SageVideo.prototype.touchstart = function(event)
{
	this.videoElement = this.getVideoElement();
	this.videoElement.className = 'tapButton highlighted';
};

SageVideo.prototype.touchend = function(event)
{
	this.videoElement = this.getVideoElement();
	this.videoElement.className = 'tapButton';
};

/*SageVideo.prototype.setLatestWatchedTime = function(time)
{
	this.latestWatchedTime = time / 1000;
};*/

// canplaythrough - can play, won't have to buffer anymore
SageVideo.prototype.canplaythrough = function(event)
{
//	this.setLatestWatchedTime(500000);
//	this.videoElement.currentTime = this.latestWatchedTime;
//    this.statusElement = document.getElementById("status");
//	this.statusElement.className = "progress hidden";
	this.printElementCurrentTime();
};

// canplay - can play, but will eventually have to buffer
SageVideo.prototype.canplay = function(event)
{
//	this.setLatestWatchedTime(500000);
//	this.videoElement.currentTime = this.latestWatchedTime;
//    this.statusElement = document.getElementById("status");
//	this.statusElement.className = "progress hidden";
	this.printElementCurrentTime();
};

SageVideo.prototype.play = function(event)
{
	log("onPlay");
	this.videoElement = this.getVideoElement();
	if ((this.videoElement.seekable != null) &&
        (this.videoElement.seekable.length > 0))
	{
		// doesn't work on iPhone 4 because seekable TimeRanges "Array" is empty
	    this.videoElement.currentTime = this.currentTime;
	    this.postClearWatched();
	}
	this.printElementCurrentTime();
};

SageVideo.prototype.playing = function(event)
{
	this.printElementCurrentTime();
};

// progress - fetching media
SageVideo.prototype.progress = function(event)
{
//	this.setLatestWatchedTime(500000);
//	this.videoElement.currentTime = this.latestWatchedTime;
	this.printElementCurrentTime();
};

// loadeddata - can render media data at current playback position
SageVideo.prototype.loadeddata = function(event)
{
//	this.setLatestWatchedTime(500000);
//	this.videoElement.currentTime = this.latestWatchedTime;
	this.printElementCurrentTime();
};

// loadedmetadata - now we know duration, height, width, and more
SageVideo.prototype.loadedmetadata = function(event)
{
//	this.setLatestWatchedTime(500000);
	this.videoElement = this.getVideoElement();
	if ((this.videoElement.seekable != null) &&
        (this.videoElement.seekable.length > 0))
	{
		// doesn't work on iPhone 4 because seekable TimeRanges "Array" is empty
	    this.videoElement.currentTime = this.currentTime;
	    this.postClearWatched();
	}
	this.printElementCurrentTime();
};

// durationchange - new info about the duration
SageVideo.prototype.durationchange = function(event)
{
//	this.setLatestWatchedTime(500000);
//	this.videoElement.currentTime = this.latestWatchedTime;
//	this.videoElement.currentTime = this.currentTime;
	this.printElementCurrentTime();
};

// loadstart - begin loading media data
SageVideo.prototype.loadstart = function(event)
{
//	this.setLatestWatchedTime(500000);
//	this.videoElement.currentTime = this.latestWatchedTime;
	this.printElementCurrentTime();
};

SageVideo.prototype.timeupdate = function(event)
{
//	this.setLatestWatchedTime(500000);
//	this.videoElement.currentTime = this.latestWatchedTime;
	this.currentTime = this.videoElement.currentTime;
	this.printElementCurrentTime();
};

SageVideo.prototype.pause = function(event)
{
//	this.setLatestWatchedTime(500000);
//	this.videoElement.currentTime = this.latestWatchedTime;
//	this.latestWatchedTime = time / 1000;

	this.printElementCurrentTime();
	
	this.postLatestWatchedTime();
};

SageVideo.prototype.ended = function(event)
{
	this.printElementCurrentTime();
};

SageVideo.prototype.ratechange = function(event)
{
	this.printElementCurrentTime();
};

SageVideo.prototype.seeked = function(event)
{
	this.printElementCurrentTime();
};

SageVideo.prototype.seeking = function(event)
{
	this.printElementCurrentTime();
};

SageVideo.prototype.stalled = function(event)
{
	this.printElementCurrentTime();
};

SageVideo.prototype.suspend = function(event)
{
	this.printElementCurrentTime();
};

SageVideo.prototype.waiting = function(event)
{
//	this.videoElement = this.getVideoElement();
//    this.statusElement = document.getElementById("status");
//	this.statusElement.style.left = (this.videoElement.style.width - this.statusElement.style.width) / 2 + this.videoElement.style.left;
//	this.statusElement.style.top = (this.videoElement.style.height - this.statusElement.style.height) / 2 + this.videoElement.style.top;
//	this.statusElement.className = "progress showing";
	this.printElementCurrentTime();
};

SageVideo.prototype.setCurrentTime = function(value)
{
    log('currentTime = ' + value);
	this.currentTime = value / 1000;
}

SageVideo.prototype.printElementCurrentTime = function()
{
	this.videoElement = this.getVideoElement();
    log('this.videoElement.currentTime = ' + this.videoElement.currentTime);
}

SageVideo.prototype.playPause = function()
{
	this.videoElement = this.getVideoElement();
    if (this.videoElement.paused)
    {
    	this.videoElement.play();
    }
    else
    {
    	this.videoElement.pause();
    }
    this.printElementCurrentTime();
}

SageVideo.prototype.postLatestWatchedTime = function()
{
	this.videoElement = this.getVideoElement();
	if (this.videoElement == null)
	{
		return;
	}
	
	// assumes the Command servlet is registered in web.xml at the same path as the current page
	var path = location.href.substring(0, location.href.lastIndexOf('/') + 1);
	
	$.ajax({
	    type: "POST",
	    url: path + "Command",
        data: "command=SetLatestWatchedTime&AiringId=" + this.airingId + "&LatestWatchedTime=" + this.videoElement.currentTime,
	    success: function(msg){
//	        alert( "Data Saved: " + msg );
	    },
        error: function(msg){
	        alert( "Data Not Saved: " + msg );
	    }
	});
}

SageVideo.prototype.postClearWatched = function()
{
	log("postClearWatched");
	
	// assumes the Command servlet is registered in web.xml at the same path as the current page
	var path = location.href.substring(0, location.href.lastIndexOf('/') + 1);
	
	log("Clearing watched status for AiringId " + this.airingId + ". " + path);
	
	$.ajax({
	    type: "POST",
	    url: path + "Command",
        data: "command=ClearWatched&AiringId=" + this.airingId,
	    success: function(msg){
//	        alert( "Data Saved: " + msg );
	    },
        error: function(msg){
	        alert( "Data Not Saved: " + msg );
	    }
	});
}

function log(msg)
{
/*	var logElem = document.getElementById("log");
	
	if (logElem != null)
	{
		var newElem2 = document.createElement("div");
	    newElem2.setAttribute('style', 'padding-bottom: 10px;');
    	newElem2.innerHTML = msg + "<br/>";
    	logElem.appendChild(newElem2);
	}
*/
}
