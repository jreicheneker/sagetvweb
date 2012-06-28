<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/TranscodeAPI.html#AddTranscodeFormat(java.lang.String, java.lang.String)'>TranscodeAPI.AddTranscodeFormat</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="formatName" required="true" type="java.lang.String" %>
<%@ attribute name="formatDetails" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object formatNameAttr = jspContext.getAttribute("formatName");
Object formatDetailsAttr = jspContext.getAttribute("formatDetails");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AddTranscodeFormat", new Object[] {formatNameAttr, formatDetailsAttr});
}
else
{
    returnVal = sage.SageTV.api("AddTranscodeFormat", new Object[] {formatNameAttr, formatDetailsAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
