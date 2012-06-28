<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#AddVideoDirectory(java.lang.String, java.lang.String, long)'>Configuration.AddVideoDirectory</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="directory" required="true" type="java.lang.String" %>
<%@ attribute name="rule" required="true" type="java.lang.String" %>
<%@ attribute name="size" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object directoryAttr = jspContext.getAttribute("directory");
Object ruleAttr = jspContext.getAttribute("rule");
Object sizeAttr = jspContext.getAttribute("size");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "AddVideoDirectory", new Object[] {directoryAttr, ruleAttr, sizeAttr});
}
else
{
    sage.SageTV.api("AddVideoDirectory", new Object[] {directoryAttr, ruleAttr, sizeAttr});
}
%>
