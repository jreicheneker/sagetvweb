<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
String[] PARENTAL_RATINGS = new String[] {
    "TVY", "TVY7", "TVG", "TVPG", "TV14", "TVM"
};
%>

<c:set var="varLocal" value="<%= PARENTAL_RATINGS %>"/>
