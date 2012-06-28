<%@ tag body-content="empty"%>
<%@ tag import="java.util.Calendar" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="java.util.GregorianCalendar" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="date" required="true" type="java.util.Date" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Integer dayOfYear = 0;
Date date = (Date) jspContext.getAttribute("date");
GregorianCalendar cal = new GregorianCalendar();
cal.setTime(date);
dayOfYear = cal.get(Calendar.DAY_OF_YEAR);
%>

<c:set var="varLocal" value="<%= dayOfYear %>"/>
