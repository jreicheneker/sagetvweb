<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#LinkIRCodeToSageCommand(long, java.lang.String)'>Configuration.LinkIRCodeToSageCommand</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="iRCode" required="true" type="java.lang.Long" %>
<%@ attribute name="sageCommand" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object iRCodeAttr = jspContext.getAttribute("iRCode");
Object sageCommandAttr = jspContext.getAttribute("sageCommand");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "LinkIRCodeToSageCommand", new Object[] {iRCodeAttr, sageCommandAttr});
}
else
{
    sage.SageTV.api("LinkIRCodeToSageCommand", new Object[] {iRCodeAttr, sageCommandAttr});
}
%>
