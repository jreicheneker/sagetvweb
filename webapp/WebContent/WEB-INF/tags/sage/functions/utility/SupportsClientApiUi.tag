<%@ tag body-content="empty"%>
<%@ tag import="java.lang.reflect.InvocationTargetException" %>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%-- Sage 7 supports the client API UI but there aren't any related APIs
  -- to use to determine the support.  Call another Sage 7 API instead.
  --%>
<%
Boolean supportsClientApiUi = true;

try
{
   SageTV.api("GetInstalledPlugins", null);
}
catch (InvocationTargetException e)
{
    supportsClientApiUi = false;
}
%>

<c:set var="varLocal" value="<%= supportsClientApiUi %>"/>
