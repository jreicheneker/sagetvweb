<%@ tag body-content="empty"%>
<%@ tag import="java.text.SimpleDateFormat" %>
<%@ tag import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="format" required="true" %>
<%@ attribute name="date" required="true" type="java.util.Date" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
String format = (String) jspContext.getAttribute("format");
Date date = (Date) jspContext.getAttribute("date");
SimpleDateFormat fmt = new SimpleDateFormat(format); 
String formattedDate = fmt.format(date);
%>

<c:set var="varLocal" value="<%= formattedDate %>"/>
