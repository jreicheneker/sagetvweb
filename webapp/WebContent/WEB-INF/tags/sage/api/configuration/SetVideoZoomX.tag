<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#SetVideoZoomX(java.lang.String, float)'>Configuration.SetVideoZoomX</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="aspectRatioMode" required="true" type="java.lang.String" %>
<%@ attribute name="scaleFactor" required="true" type="java.lang.Float" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object aspectRatioModeAttr = jspContext.getAttribute("aspectRatioMode");
Object scaleFactorAttr = jspContext.getAttribute("scaleFactor");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetVideoZoomX", new Object[] {aspectRatioModeAttr, scaleFactorAttr});
}
else
{
    sage.SageTV.api("SetVideoZoomX", new Object[] {aspectRatioModeAttr, scaleFactorAttr});
}
%>
