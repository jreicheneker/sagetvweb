<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaPlayerAPI.html#GetBluRayTitleDescription(int)'>MediaPlayerAPI.GetBluRayTitleDescription</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="titleNum" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object titleNumAttr = jspContext.getAttribute("titleNum");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetBluRayTitleDescription", new Object[] {titleNumAttr});
}
else
{
    returnVal = sage.SageTV.api("GetBluRayTitleDescription", new Object[] {titleNumAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
