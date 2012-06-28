<%@ tag body-content="empty"%>
<%@ tag import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="value" required="true" type="java.lang.Boolean" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Boolean bool = (Boolean) jspContext.getAttribute("value");

String yesNo = bool ? "Yes" : "No";
%>

<c:set var="varLocal" value="<%= yesNo %>"/>
