<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#PlaySound(java.lang.String)'>Utility.PlaySound</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="soundFile" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object soundFileAttr = jspContext.getAttribute("soundFile");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "PlaySound", new Object[] {soundFileAttr});
}
else
{
    sage.SageTV.api("PlaySound", new Object[] {soundFileAttr});
}
%>
