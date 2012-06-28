<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#GetScaledImageAsBufferedImage(java.lang.Object, int, int)'>Utility.GetScaledImageAsBufferedImage</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="resource" required="true" type="java.lang.Object" %>
<%@ attribute name="width" required="true" type="java.lang.Integer" %>
<%@ attribute name="height" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object resourceAttr = jspContext.getAttribute("resource");
Object widthAttr = jspContext.getAttribute("width");
Object heightAttr = jspContext.getAttribute("height");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetScaledImageAsBufferedImage", new Object[] {resourceAttr, widthAttr, heightAttr});
}
else
{
    returnVal = sage.SageTV.api("GetScaledImageAsBufferedImage", new Object[] {resourceAttr, widthAttr, heightAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
