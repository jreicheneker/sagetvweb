<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#Wait(long)'>Utility.Wait</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="time" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object timeAttr = jspContext.getAttribute("time");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "Wait", new Object[] {timeAttr});
}
else
{
    sage.SageTV.api("Wait", new Object[] {timeAttr});
}
%>
