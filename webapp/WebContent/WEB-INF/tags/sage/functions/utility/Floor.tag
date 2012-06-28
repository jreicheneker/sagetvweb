<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="value" required="true" type="java.lang.Double" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Double value = (Double) jspContext.getAttribute("value");

Long lng = new Double(Math.floor(value)).longValue();
%>

<c:set var="varLocal" value="<%= lng %>"/>
