<%@ tag body-content="empty"%>
<%@ tag import="java.util.Calendar" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="java.util.GregorianCalendar" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="hours" required="false" type="java.lang.Integer"%>
<%@ attribute name="date" required="true" type="java.util.Date"%>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Date date = (Date) jspContext.getAttribute("date");
Integer hours = (Integer) jspContext.getAttribute("hours");
GregorianCalendar cal = new GregorianCalendar();

cal.setTime(date);
cal.add(Calendar.HOUR_OF_DAY, hours);
%>

<c:set var="varLocal" value="<%= cal.getTime() %>"/>
