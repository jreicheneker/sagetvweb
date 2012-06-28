<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#ExecuteProcess(java.lang.String, java.lang.Object, java.io.File, boolean)'>Utility.ExecuteProcess</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="commandString" required="true" type="java.lang.String" %>
<%@ attribute name="arguments" required="true" type="java.lang.Object" %>
<%@ attribute name="workingDirectory" required="true" type="java.io.File" %>
<%@ attribute name="consoleApp" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object commandStringAttr = jspContext.getAttribute("commandString");
Object argumentsAttr = jspContext.getAttribute("arguments");
Object workingDirectoryAttr = jspContext.getAttribute("workingDirectory");
Object consoleAppAttr = jspContext.getAttribute("consoleApp");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "ExecuteProcess", new Object[] {commandStringAttr, argumentsAttr, workingDirectoryAttr, consoleAppAttr});
}
else
{
    returnVal = sage.SageTV.api("ExecuteProcess", new Object[] {commandStringAttr, argumentsAttr, workingDirectoryAttr, consoleAppAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
