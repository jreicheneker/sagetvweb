<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/AiringAPI.html#IsAiringAttributeSet(sage.Airing, java.lang.String)'>AiringAPI.IsAiringAttributeSet</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="airing" required="true" type="java.lang.Object" %>
<%@ attribute name="attribute" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object airingAttr = jspContext.getAttribute("airing");
Object attributeAttr = jspContext.getAttribute("attribute");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "IsAiringAttributeSet", new Object[] {airingAttr, attributeAttr});
}
else
{
    returnVal = sage.SageTV.api("IsAiringAttributeSet", new Object[] {airingAttr, attributeAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
