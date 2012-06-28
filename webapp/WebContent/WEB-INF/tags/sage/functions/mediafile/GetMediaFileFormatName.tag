<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="mediafile" required="true" type="java.lang.Object" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Object mediaFile = jspContext.getAttribute("mediafile");
String description = (String) SageTV.api("GetMediaFileFormatDescription", new Object[] {mediaFile});
int i = description.indexOf("[");
// recording with empty files does not have extra format description in brackets
if (i >= 0)
{
	description = description.substring(0, i);
}
%>

<c:set var="varLocal" value="<%= description %>"/>
