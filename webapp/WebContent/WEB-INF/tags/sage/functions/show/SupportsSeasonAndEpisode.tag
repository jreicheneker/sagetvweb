<%@ tag body-content="empty"%>
<%@ tag import="java.lang.reflect.InvocationTargetException" %>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="show" required="true" type="java.lang.Object" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Object show = jspContext.getAttribute("show");

Boolean supportsSeasonAndEpisode = true;

try
{
   SageTV.api("GetShowSeasonNumber", new Object[] {show});
}
catch (InvocationTargetException e)
{
    supportsSeasonAndEpisode = false;
}
%>

<c:set var="varLocal" value="<%= supportsSeasonAndEpisode %>"/>
