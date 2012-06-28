<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#SetVariableForUIComponent(java.lang.Object, java.lang.String, java.lang.Object)'>Global.SetVariableForUIComponent</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="uIComponent" required="true" type="java.lang.Object" %>
<%@ attribute name="varName" required="true" type="java.lang.String" %>
<%@ attribute name="varValue" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object uIComponentAttr = jspContext.getAttribute("uIComponent");
Object varNameAttr = jspContext.getAttribute("varName");
Object varValueAttr = jspContext.getAttribute("varValue");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetVariableForUIComponent", new Object[] {uIComponentAttr, varNameAttr, varValueAttr});
}
else
{
    sage.SageTV.api("SetVariableForUIComponent", new Object[] {uIComponentAttr, varNameAttr, varValueAttr});
}
%>
