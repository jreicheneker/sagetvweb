<%@ tag body-content="empty"%>
<%@ tag import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="list" required="true" type="java.lang.Object" %>
<%@ attribute name="value" required="true" type="java.lang.Object" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
List list = (List) jspContext.getAttribute("list");
Object value = jspContext.getAttribute("value");
%>
<c:set var="varLocal" value="<%= (list == null) ? false : list.contains(value) %>"/>
