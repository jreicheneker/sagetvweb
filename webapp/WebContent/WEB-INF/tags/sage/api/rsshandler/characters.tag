<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/RSSHandler.html#characters(char[], int, int)'>RSSHandler.characters</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="ch" required="true" type="char[]" %>
<%@ attribute name="start" required="true" type="java.lang.Integer" %>
<%@ attribute name="length" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object chAttr = jspContext.getAttribute("ch");
Object startAttr = jspContext.getAttribute("start");
Object lengthAttr = jspContext.getAttribute("length");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "characters", new Object[] {chAttr, startAttr, lengthAttr});
}
else
{
    sage.SageTV.api("characters", new Object[] {chAttr, startAttr, lengthAttr});
}
%>
