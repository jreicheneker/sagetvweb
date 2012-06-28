<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#ChangeVideoDirectory(java.io.File, java.io.File, java.lang.String, long)'>Configuration.ChangeVideoDirectory</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="oldDirectory" required="true" type="java.io.File" %>
<%@ attribute name="newDirectory" required="true" type="java.io.File" %>
<%@ attribute name="newRule" required="true" type="java.lang.String" %>
<%@ attribute name="newSize" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object oldDirectoryAttr = jspContext.getAttribute("oldDirectory");
Object newDirectoryAttr = jspContext.getAttribute("newDirectory");
Object newRuleAttr = jspContext.getAttribute("newRule");
Object newSizeAttr = jspContext.getAttribute("newSize");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "ChangeVideoDirectory", new Object[] {oldDirectoryAttr, newDirectoryAttr, newRuleAttr, newSizeAttr});
}
else
{
    sage.SageTV.api("ChangeVideoDirectory", new Object[] {oldDirectoryAttr, newDirectoryAttr, newRuleAttr, newSizeAttr});
}
%>
