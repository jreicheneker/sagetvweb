<%@ tag body-content="empty"%>
<%@ tag import="java.util.Arrays" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="array" required="true" type="java.lang.Object" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Object[] array = (Object[]) jspContext.getAttribute("array");
%>
<%
List list = null;
if (array == null)
{
    list = new ArrayList();
}
else
{
	list = Arrays.asList(array);
}
%>

<c:set var="varLocal" value="<%= list %>"/>
