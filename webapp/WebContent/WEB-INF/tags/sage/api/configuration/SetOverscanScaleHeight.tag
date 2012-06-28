<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#SetOverscanScaleHeight(float)'>Configuration.SetOverscanScaleHeight</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="amount" required="true" type="java.lang.Float" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object amountAttr = jspContext.getAttribute("amount");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetOverscanScaleHeight", new Object[] {amountAttr});
}
else
{
    sage.SageTV.api("SetOverscanScaleHeight", new Object[] {amountAttr});
}
%>
