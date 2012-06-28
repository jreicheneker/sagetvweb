<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#GetVideoOffsetY(java.lang.String)'>Configuration.GetVideoOffsetY</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="aspectRatioMode" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object aspectRatioModeAttr = jspContext.getAttribute("aspectRatioMode");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetVideoOffsetY", new Object[] {aspectRatioModeAttr});
}
else
{
    returnVal = sage.SageTV.api("GetVideoOffsetY", new Object[] {aspectRatioModeAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
