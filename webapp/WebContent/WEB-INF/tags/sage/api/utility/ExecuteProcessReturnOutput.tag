<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#ExecuteProcessReturnOutput(java.lang.String, java.lang.Object, java.io.File, boolean, boolean)'>Utility.ExecuteProcessReturnOutput</a>
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
<%@ attribute name="returnStdout" required="true" type="java.lang.Boolean" %>
<%@ attribute name="returnStderr" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object commandStringAttr = jspContext.getAttribute("commandString");
Object argumentsAttr = jspContext.getAttribute("arguments");
Object workingDirectoryAttr = jspContext.getAttribute("workingDirectory");
Object returnStdoutAttr = jspContext.getAttribute("returnStdout");
Object returnStderrAttr = jspContext.getAttribute("returnStderr");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "ExecuteProcessReturnOutput", new Object[] {commandStringAttr, argumentsAttr, workingDirectoryAttr, returnStdoutAttr, returnStderrAttr});
}
else
{
    returnVal = sage.SageTV.api("ExecuteProcessReturnOutput", new Object[] {commandStringAttr, argumentsAttr, workingDirectoryAttr, returnStdoutAttr, returnStderrAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
