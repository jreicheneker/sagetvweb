<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#AreAiringsSameShow(sage.Airing, sage.Airing)'>Global.AreAiringsSameShow</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="airing1" required="true" type="java.lang.Object" %>
<%@ attribute name="airing2" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object airing1Attr = jspContext.getAttribute("airing1");
Object airing2Attr = jspContext.getAttribute("airing2");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AreAiringsSameShow", new Object[] {airing1Attr, airing2Attr});
}
else
{
    returnVal = sage.SageTV.api("AreAiringsSameShow", new Object[] {airing1Attr, airing2Attr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
