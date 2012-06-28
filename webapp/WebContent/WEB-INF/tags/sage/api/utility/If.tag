<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#If(boolean, java.lang.Object, java.lang.Object)'>Utility.If</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="condition" required="true" type="java.lang.Boolean" %>
<%@ attribute name="trueValue" required="true" type="java.lang.Object" %>
<%@ attribute name="falseValue" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object conditionAttr = jspContext.getAttribute("condition");
Object trueValueAttr = jspContext.getAttribute("trueValue");
Object falseValueAttr = jspContext.getAttribute("falseValue");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "If", new Object[] {conditionAttr, trueValueAttr, falseValueAttr});
}
else
{
    returnVal = sage.SageTV.api("If", new Object[] {conditionAttr, trueValueAttr, falseValueAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
