<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Security.html#SetPermission(java.lang.String, java.lang.String, boolean)'>Security.SetPermission</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="permission" required="true" type="java.lang.String" %>
<%@ attribute name="profile" required="true" type="java.lang.String" %>
<%@ attribute name="allowed" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object permissionAttr = jspContext.getAttribute("permission");
Object profileAttr = jspContext.getAttribute("profile");
Object allowedAttr = jspContext.getAttribute("allowed");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetPermission", new Object[] {permissionAttr, profileAttr, allowedAttr});
}
else
{
    sage.SageTV.api("SetPermission", new Object[] {permissionAttr, profileAttr, allowedAttr});
}
%>
