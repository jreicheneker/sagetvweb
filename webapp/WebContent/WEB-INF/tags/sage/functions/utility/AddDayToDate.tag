<%@ tag body-content="empty"%>
<%@ tag import="java.util.Calendar" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="java.util.GregorianCalendar" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="days" required="false" type="java.lang.Integer"%>
<%@ attribute name="date" required="true" type="java.util.Date"%>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Date date = (Date) jspContext.getAttribute("date");
Integer days = (Integer) jspContext.getAttribute("days");
GregorianCalendar cal = new GregorianCalendar();

cal.setTime(date);
cal.add(Calendar.DAY_OF_YEAR, days);
%>

<c:set var="varLocal" value="<%= cal.getTime() %>"/>
