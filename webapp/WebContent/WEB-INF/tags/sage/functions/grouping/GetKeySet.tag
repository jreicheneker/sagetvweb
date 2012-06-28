<%@ tag body-content="empty"%>
<%@ tag import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="groups" required="true" type="java.lang.Object" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Map groups = (Map) jspContext.getAttribute("groups");
%>

<c:set var="varLocal" value="<%= groups.keySet() %>"/>
