<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#SetEmbeddedPanelBounds(float, float, float, float)'>Global.SetEmbeddedPanelBounds</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="x" required="true" type="java.lang.Float" %>
<%@ attribute name="y" required="true" type="java.lang.Float" %>
<%@ attribute name="width" required="true" type="java.lang.Float" %>
<%@ attribute name="height" required="true" type="java.lang.Float" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object xAttr = jspContext.getAttribute("x");
Object yAttr = jspContext.getAttribute("y");
Object widthAttr = jspContext.getAttribute("width");
Object heightAttr = jspContext.getAttribute("height");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetEmbeddedPanelBounds", new Object[] {xAttr, yAttr, widthAttr, heightAttr});
}
else
{
    sage.SageTV.api("SetEmbeddedPanelBounds", new Object[] {xAttr, yAttr, widthAttr, heightAttr});
}
%>
