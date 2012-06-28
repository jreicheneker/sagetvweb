<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Translate.html#encode(java.io.InputStream, java.io.PrintStream)'>Translate.encode</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="in" required="true" type="java.io.InputStream" %>
<%@ attribute name="out" required="true" type="java.io.Prjava.lang.IntegerStream" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object inAttr = jspContext.getAttribute("in");
Object outAttr = jspContext.getAttribute("out");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "encode", new Object[] {inAttr, outAttr});
}
else
{
    sage.SageTV.api("encode", new Object[] {inAttr, outAttr});
}
%>
