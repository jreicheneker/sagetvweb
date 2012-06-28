<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#SetVideoOffsetY(java.lang.String, int)'>Configuration.SetVideoOffsetY</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="aspectRatioMode" required="true" type="java.lang.String" %>
<%@ attribute name="pixelOffset" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object aspectRatioModeAttr = jspContext.getAttribute("aspectRatioMode");
Object pixelOffsetAttr = jspContext.getAttribute("pixelOffset");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetVideoOffsetY", new Object[] {aspectRatioModeAttr, pixelOffsetAttr});
}
else
{
    sage.SageTV.api("SetVideoOffsetY", new Object[] {aspectRatioModeAttr, pixelOffsetAttr});
}
%>
