<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Database.html#DataUnion(java.lang.Object, java.lang.Object)'>Database.DataUnion</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="dataSet1" required="true" type="java.lang.Object" %>
<%@ attribute name="dataSet2" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object dataSet1Attr = jspContext.getAttribute("dataSet1");
Object dataSet2Attr = jspContext.getAttribute("dataSet2");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "DataUnion", new Object[] {dataSet1Attr, dataSet2Attr});
}
else
{
    returnVal = sage.SageTV.api("DataUnion", new Object[] {dataSet1Attr, dataSet2Attr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
