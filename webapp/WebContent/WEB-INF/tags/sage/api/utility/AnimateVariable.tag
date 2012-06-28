<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#AnimateVariable(java.lang.String, java.lang.String, java.lang.String, java.lang.Object, java.lang.String, long, long, boolean)'>Utility.AnimateVariable</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="widgetName" required="true" type="java.lang.String" %>
<%@ attribute name="layerName" required="true" type="java.lang.String" %>
<%@ attribute name="varName" required="true" type="java.lang.String" %>
<%@ attribute name="varValue" required="true" type="java.lang.Object" %>
<%@ attribute name="animationName" required="true" type="java.lang.String" %>
<%@ attribute name="duration" required="true" type="java.lang.Long" %>
<%@ attribute name="startDelay" required="true" type="java.lang.Long" %>
<%@ attribute name="interruptable" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object widgetNameAttr = jspContext.getAttribute("widgetName");
Object layerNameAttr = jspContext.getAttribute("layerName");
Object varNameAttr = jspContext.getAttribute("varName");
Object varValueAttr = jspContext.getAttribute("varValue");
Object animationNameAttr = jspContext.getAttribute("animationName");
Object durationAttr = jspContext.getAttribute("duration");
Object startDelayAttr = jspContext.getAttribute("startDelay");
Object interruptableAttr = jspContext.getAttribute("interruptable");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AnimateVariable", new Object[] {widgetNameAttr, layerNameAttr, varNameAttr, varValueAttr, animationNameAttr, durationAttr, startDelayAttr, interruptableAttr});
}
else
{
    returnVal = sage.SageTV.api("AnimateVariable", new Object[] {widgetNameAttr, layerNameAttr, varNameAttr, varValueAttr, animationNameAttr, durationAttr, startDelayAttr, interruptableAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
