<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#SetAutodialForInternet(boolean)'>Configuration.SetAutodialForInternet</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="autodial" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object autodialAttr = jspContext.getAttribute("autodial");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetAutodialForInternet", new Object[] {autodialAttr});
}
else
{
    sage.SageTV.api("SetAutodialForInternet", new Object[] {autodialAttr});
}
%>
