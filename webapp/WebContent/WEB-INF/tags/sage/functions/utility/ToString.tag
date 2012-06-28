<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="value" required="true" type="java.lang.Object" %>

<%
Object value = jspContext.getAttribute("value");

String retVal = null;

if (value != null)
{
    retVal = value.toString();
}
%>

<c:set var="varLocal" value="<%= retVal %>"/>
