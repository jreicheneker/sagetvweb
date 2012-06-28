<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaFileAPI.html#GenerateThumbnail(sage.MediaFile, float, int, int, java.io.File)'>MediaFileAPI.GenerateThumbnail</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="mediaFile" required="true" type="java.lang.Object" %>
<%@ attribute name="time" required="true" type="java.lang.Float" %>
<%@ attribute name="width" required="true" type="java.lang.Integer" %>
<%@ attribute name="height" required="true" type="java.lang.Integer" %>
<%@ attribute name="file" required="true" type="java.io.File" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object mediaFileAttr = jspContext.getAttribute("mediaFile");
Object timeAttr = jspContext.getAttribute("time");
Object widthAttr = jspContext.getAttribute("width");
Object heightAttr = jspContext.getAttribute("height");
Object fileAttr = jspContext.getAttribute("file");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GenerateThumbnail", new Object[] {mediaFileAttr, timeAttr, widthAttr, heightAttr, fileAttr});
}
else
{
    returnVal = sage.SageTV.api("GenerateThumbnail", new Object[] {mediaFileAttr, timeAttr, widthAttr, heightAttr, fileAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
