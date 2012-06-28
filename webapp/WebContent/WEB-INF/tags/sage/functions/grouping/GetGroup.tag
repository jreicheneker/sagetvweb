<%@ tag body-content="empty"%>
<%@ tag import="java.util.Map" %>
<%@ tag import="java.util.Vector" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="groups" required="true" type="java.lang.Object" %>
<%@ attribute name="groupKey" required="true" type="java.lang.String" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
String groupKey = (String) jspContext.getAttribute("groupKey");
Map groups = (Map) jspContext.getAttribute("groups");
Vector group = (Vector) groups.get(groupKey);
%>

<c:set var="varLocal" value="<%= group %>"/>
