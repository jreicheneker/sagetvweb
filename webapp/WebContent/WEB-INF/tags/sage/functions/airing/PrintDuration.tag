<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="airing" required="true" type="java.lang.Object" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Object airing = jspContext.getAttribute("airing");
Long duration = (Long) SageTV.api("GetAiringDuration", new Object[] {airing});
String printedDuration = "";
if (duration != null)
{
   long mins = duration / 60000;

   if (duration > 3600000)
   {
      printedDuration = mins / 60 + " h " + mins % 60 + " m";   
   }
   else 
   {
       printedDuration = mins + " m";
   }
}
%>

<c:set var="varLocal" value="<%= printedDuration %>"/>
