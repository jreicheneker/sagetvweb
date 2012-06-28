<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/AiringAPI.html#GetManualRecordProperty(sage.Airing, java.lang.String)'>AiringAPI.GetManualRecordProperty</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="airing" required="true" type="java.lang.Object" %>
<%@ attribute name="propertyName" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object airingAttr = jspContext.getAttribute("airing");
Object propertyNameAttr = jspContext.getAttribute("propertyName");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetManualRecordProperty", new Object[] {airingAttr, propertyNameAttr});
}
else
{
    returnVal = sage.SageTV.api("GetManualRecordProperty", new Object[] {airingAttr, propertyNameAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
