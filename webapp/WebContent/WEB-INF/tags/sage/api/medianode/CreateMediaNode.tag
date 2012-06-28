<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaNodeAPI.html#CreateMediaNode(java.lang.String, java.lang.String, java.lang.Object, java.lang.Object, java.lang.Object)'>MediaNodeAPI.CreateMediaNode</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="primaryLabel" required="true" type="java.lang.String" %>
<%@ attribute name="secondaryLabel" required="true" type="java.lang.String" %>
<%@ attribute name="thumbnail" required="true" type="java.lang.Object" %>
<%@ attribute name="icon" required="true" type="java.lang.Object" %>
<%@ attribute name="dataObject" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object primaryLabelAttr = jspContext.getAttribute("primaryLabel");
Object secondaryLabelAttr = jspContext.getAttribute("secondaryLabel");
Object thumbnailAttr = jspContext.getAttribute("thumbnail");
Object iconAttr = jspContext.getAttribute("icon");
Object dataObjectAttr = jspContext.getAttribute("dataObject");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "CreateMediaNode", new Object[] {primaryLabelAttr, secondaryLabelAttr, thumbnailAttr, iconAttr, dataObjectAttr});
}
else
{
    returnVal = sage.SageTV.api("CreateMediaNode", new Object[] {primaryLabelAttr, secondaryLabelAttr, thumbnailAttr, iconAttr, dataObjectAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
