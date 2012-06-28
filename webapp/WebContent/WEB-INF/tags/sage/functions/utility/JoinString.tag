<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="token" required="false" %>
<%@ attribute name="value" required="true" type="java.lang.Object" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Object value = jspContext.getAttribute("value");
String valueJoined = "";
if (value instanceof String)
{
    valueJoined = (String) value;
}
else
{
   String token = (String) jspContext.getAttribute("token");
   String[] valueArray = (String[]) jspContext.getAttribute("value");

   if ((token == null) || (token.trim().length() == 0))
   {
      token = ", ";
   }

   for (int i = 0; i < valueArray.length; i++)
   {
      valueJoined += valueArray[i];
      if (i < valueArray.length - 1)
      {
         valueJoined += token;
      }
   }
}
%>

<c:set var="varLocal" value="<%= valueJoined %>"/>
