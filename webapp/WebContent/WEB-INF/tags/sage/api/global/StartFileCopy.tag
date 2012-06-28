<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#StartFileCopy(java.lang.String, java.lang.String, java.io.File)'>Global.StartFileCopy</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="filename" required="true" type="java.lang.String" %>
<%@ attribute name="sourceDirectory" required="true" type="java.lang.String" %>
<%@ attribute name="destDirectory" required="true" type="java.io.File" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object filenameAttr = jspContext.getAttribute("filename");
Object sourceDirectoryAttr = jspContext.getAttribute("sourceDirectory");
Object destDirectoryAttr = jspContext.getAttribute("destDirectory");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "StartFileCopy", new Object[] {filenameAttr, sourceDirectoryAttr, destDirectoryAttr});
}
else
{
    returnVal = sage.SageTV.api("StartFileCopy", new Object[] {filenameAttr, sourceDirectoryAttr, destDirectoryAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
