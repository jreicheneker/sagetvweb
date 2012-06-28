<%@ tag body-content="empty"%>
<%@ tag import="java.text.DecimalFormat" %>
<%@ tag import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="format" required="true" %>
<%@ attribute name="value" required="true" type="java.lang.Double" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
String format = (String) jspContext.getAttribute("format");
Double value = (Double) jspContext.getAttribute("value");
DecimalFormat fmt = new DecimalFormat(format); 
String formattedValue = fmt.format(value);
%>

<c:set var="varLocal" value="<%= formattedValue %>"/>
