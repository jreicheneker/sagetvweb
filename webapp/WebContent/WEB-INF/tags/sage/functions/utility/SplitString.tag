<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="limit" required="false" %>
<%@ attribute name="token" required="false" %>
<%@ attribute name="value" required="true" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
String limit = (String) jspContext.getAttribute("limit");
String token = (String) jspContext.getAttribute("token");
String value = (String) jspContext.getAttribute("value");
String[] splitValue = null;

if ((token == null) || (token.trim().length() == 0))
{
    token = ", ";
}

if ((value == null) || (value.trim().length() == 0))
{
    splitValue = new String[0];
}
else if (limit == null)
{
	splitValue = value.split(token);
}
else
{
	splitValue = value.split(token, Integer.parseInt(limit));
}
%>

<c:set var="varLocal" value="<%= splitValue %>"/>
