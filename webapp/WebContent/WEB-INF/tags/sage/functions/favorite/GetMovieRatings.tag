<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
String[] MOVIE_RATINGS = new String[] {
    "G", "PG", "PG-13", "R", "NC-17", "AO", "NR"
};
%>

<c:set var="varLocal" value="<%= MOVIE_RATINGS %>"/>
