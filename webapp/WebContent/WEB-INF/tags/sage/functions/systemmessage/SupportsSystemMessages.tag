<%@ tag body-content="empty"%>
<%@ tag import="java.lang.reflect.InvocationTargetException" %>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Boolean supportsSystemMessages = true;

try
{
   SageTV.api("GetSystemAlertLevel", null);
}
catch (InvocationTargetException e)
{
   supportsSystemMessages = false;
}
%>

<c:set var="varLocal" value="<%= supportsSystemMessages %>"/>
