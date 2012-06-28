<%@ tag body-content="empty"%>
<%@ tag import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="value" required="true" type="java.lang.Long" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Long value = (Long) jspContext.getAttribute("value");

Date date = new Date(value);
%>

<c:set var="varLocal" value="<%= date %>"/>
