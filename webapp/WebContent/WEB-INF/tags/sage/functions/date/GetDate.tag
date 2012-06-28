<%@ tag body-content="empty"%>
<%@ tag import="java.util.Calendar" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="java.util.GregorianCalendar" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="year" required="false" type="java.lang.Integer" %>
<%@ attribute name="month" required="false" type="java.lang.Integer" %>
<%@ attribute name="day" required="false" type="java.lang.Integer" %>
<%@ attribute name="hour" required="false" type="java.lang.Integer" %>
<%@ attribute name="minute" required="false" type="java.lang.Integer" %>
<%@ attribute name="second" required="false" type="java.lang.Integer" %>
<%@ attribute name="millisecond" required="false" type="java.lang.Integer" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Integer year        = (Integer) jspContext.getAttribute("year");
Integer month       = (Integer) jspContext.getAttribute("month");
Integer day         = (Integer) jspContext.getAttribute("day");
Integer hour        = (Integer) jspContext.getAttribute("hour");
Integer minute      = (Integer) jspContext.getAttribute("minute");
Integer second      = (Integer) jspContext.getAttribute("second");
Integer millisecond = (Integer) jspContext.getAttribute("millisecond");

GregorianCalendar cal = new GregorianCalendar();

if (year != null)
{
    cal.set(Calendar.YEAR, year);
}

if (month != null)
{
    cal.set(Calendar.MONTH, month);
}

if (day != null)
{
    cal.set(Calendar.DAY_OF_MONTH, day);
}

if (hour != null)
{
    cal.set(Calendar.HOUR_OF_DAY, hour);
}

if (minute != null)
{
    cal.set(Calendar.MINUTE, minute);
}

if (second != null)
{
    cal.set(Calendar.SECOND, second);
}

if (millisecond != null)
{
    cal.set(Calendar.MILLISECOND, millisecond);
}
%>

<c:set var="varLocal" value="<%= cal.getTime() %>"/>
