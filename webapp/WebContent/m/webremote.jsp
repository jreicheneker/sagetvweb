<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
	   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	    <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
	    <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
	    <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
		<title>SageTV Web Remote</title>

        <script language="JavaScript">

            function updateOrientation() {
//                window.alert('change');
                var orientation = window.orientation;
                switch(orientation) {
                    case 90: case -90:
                        orientation = 'landscape';
                        break;
                    default:
                        orientation = 'portrait';
                }

                // set the class on the HTML element (i.e. )
                document.body.parentNode.setAttribute('class', orientation);
                //window.alert(document.body.parentNode.getAttribute('class'));
            }

            // event triggered every 90 degrees of rotation
            window.addEventListener('orientationchange', updateOrientation, false);

            // initialize the orientation
            window.addEventListener('load', updateOrientation, false);
//            updateOrientation();
//            window.addEventListener('DOMContentLoaded', updateOrientation, false);

        </script>
	</head>

	<body> 
	   	<c:set var="context" value="${param.context}"/>
	    <c:set var="contextName" value="<%= sagex.webserver.UiContextProperties.getProperty(pageContext.getAttribute("context").toString(), "name") %>"/> 
	    
 	   	<jsp:include page="/WEB-INF/jspf/m/header.jspf">
	      <jsp:param name="pageTitle" value="${contextName} Web Remote" />
	   	</jsp:include>
	
	<%-- START OF WEB REMOTE CODE --%>

		<div class="content">
			<c:set var="formId" value="webRemote"/>
     		<form id="${formId}" method="post" action="${cp}/m/Command">
				<input type="hidden" name="context" value="${context}"/>
				<table align="center">
					<tr>
						<!-- 
						<td>
							<button type="submit" name="command" value="Power">Power</button>
						</td>
						-->
						<td>
							<button type="submit" name="command" value="Home">Home</button>
						</td>
						<td>
							<button type="submit" name="command" value="TV">TV</button>
						</td>	
						<td>
							<button type="submit" name="command" value="Guide">Guide</button>
						</td>
						<td>
							<button type="submit" name="command" value="Options">Options</button>
						</td>	
					</tr>
					<tr>
						<td>
							<button type="submit" name="command" value="Back">Back</button>
						</td>
						<td colspan="2">
							<button type="submit" name="command" value="Up"><img src="${cp}/m/images/webremote/up_arrow.gif" /></button>
						</td>
						<td>
							<button type="submit" name="command" value="Info">Info</button>
						</td>
					</tr>
					<tr>
						<td>
							<button type="submit" name="command" value="Left"><img src="${cp}/m/images/webremote/left_arrow.gif" /></button>
						</td>
						<td colspan="2">
							<button type="submit" name="command" value="Select"><img src="${cp}/m/images/webremote/ok.gif" /></button>
						</td>
						<td>
							<button type="submit" name="command" value="Right"><img src="${cp}/m/images/webremote/right_arrow.gif" /></button>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>
							<button type="submit" name="command" value="Watched">Watched</button>
						</td>
						<td colspan="2">
							<button type="submit" name="command" value="Down"><img src="${cp}/m/images/webremote/down_arrow.gif" /></button>
						</td>
						<td>
							<button type="submit" name="command" value="Favorite">Fav.</button>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="submit" name="command" value="Channel Up/Page Up">Ch/Pg Up</button>
						</td>
						<td colspan="2">
							<button type="submit" name="command" value="Channel Down/Page Down">Ch/Pg Down</button>
						</td>
					</tr>
					<tr>
						<td>
							<button type="submit" name="command" value="Play">Play</button>
						</td>
						<td>
							<button type="submit" name="command" value="Pause">Pause</button>
						</td>
						<td>
							<button type="submit" name="command" value="Stop">Stop</button>
						</td>
						<td>
							<button type="submit" name="command" value="Delete">Del</button>
						</td>						
					</tr>
					<tr>
						<td colspan="2">
							<button type="submit" name="command" value="Skip Bkwd/Page Left">Skip Back</button>
						</td>

						<td colspan="2">
							<button type="submit" name="command" value="Skip Fwd/Page Right">Skip Fwd</button>
						</td>
					</tr>										
				</table>
			</form>
    		<script language="JavaScript">
      			$('#${formId}').ajaxForm();
      		</script>
		</div>
		<%-- content --%>

		<%@ include file="/WEB-INF/jspf/m/footer.jspf" %>		
	</body>
</html>