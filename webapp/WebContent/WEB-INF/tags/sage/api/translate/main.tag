<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Translate.html#main(java.lang.String[])'>Translate.main</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="args" required="true" type="java.lang.String[]" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object argsAttr = jspContext.getAttribute("args");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "main", new Object[] {argsAttr});
}
else
{
    sage.SageTV.api("main", new Object[] {argsAttr});
}
%>
