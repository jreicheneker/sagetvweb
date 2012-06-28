<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaFileAPI.html#SetMediaFileAiring(sage.MediaFile, sage.Airing)'>MediaFileAPI.SetMediaFileAiring</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="mediaFile" required="true" type="java.lang.Object" %>
<%@ attribute name="airing" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object mediaFileAttr = jspContext.getAttribute("mediaFile");
Object airingAttr = jspContext.getAttribute("airing");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "SetMediaFileAiring", new Object[] {mediaFileAttr, airingAttr});
}
else
{
    returnVal = sage.SageTV.api("SetMediaFileAiring", new Object[] {mediaFileAttr, airingAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
