<%@ tag body-content="empty"%>
<%@ tag import="java.util.Calendar" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="dateMillis" required="true" type="java.lang.Long" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Boolean isTomorrow = false;
Calendar tomorrow = Calendar.getInstance();
tomorrow.add(Calendar.DAY_OF_YEAR, 1);
Long dateMillis = (Long) jspContext.getAttribute("dateMillis");
Calendar cal = Calendar.getInstance();
cal.setTimeInMillis(dateMillis);

if ((tomorrow.get(Calendar.YEAR) == cal.get(Calendar.YEAR)) &&
    (tomorrow.get(Calendar.MONTH) == cal.get(Calendar.MONTH)) &&
    (tomorrow.get(Calendar.DAY_OF_MONTH) == cal.get(Calendar.DAY_OF_MONTH)))
{
   isTomorrow = true;
}
%>

<c:set var="varLocal" value="<%= isTomorrow %>"/>
