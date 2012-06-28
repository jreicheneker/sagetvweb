<%@ tag body-content="empty"%>
<%@ tag import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="value" required="true" type="java.util.Date" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Date value = (Date) jspContext.getAttribute("value");

Long lng = value.getTime();
%>

<c:set var="varLocal" value="<%= lng %>"/>
