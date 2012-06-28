<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/WidgetAPI.html#SaveWidgetsAsXML(java.io.File, boolean)'>WidgetAPI.SaveWidgetsAsXML</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="file" required="true" type="java.io.File" %>
<%@ attribute name="overwrite" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object fileAttr = jspContext.getAttribute("file");
Object overwriteAttr = jspContext.getAttribute("overwrite");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "SaveWidgetsAsXML", new Object[] {fileAttr, overwriteAttr});
}
else
{
    returnVal = sage.SageTV.api("SaveWidgetsAsXML", new Object[] {fileAttr, overwriteAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
