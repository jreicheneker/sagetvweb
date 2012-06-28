<%@ tag body-content="empty"%>
<%@ tag import="java.util.Calendar" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="dateMillis" required="true" type="java.lang.Long" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Boolean isToday = false;
Calendar today = Calendar.getInstance();
Long dateMillis = (Long) jspContext.getAttribute("dateMillis");
Calendar cal = Calendar.getInstance();
cal.setTimeInMillis(dateMillis);

if ((today.get(Calendar.YEAR) == cal.get(Calendar.YEAR)) &&
    (today.get(Calendar.MONTH) == cal.get(Calendar.MONTH)) &&
    (today.get(Calendar.DAY_OF_MONTH) == cal.get(Calendar.DAY_OF_MONTH)))
{
   isToday = true;
}
%>

<c:set var="varLocal" value="<%= isToday %>"/>
