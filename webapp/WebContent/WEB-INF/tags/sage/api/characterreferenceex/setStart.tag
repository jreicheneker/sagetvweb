<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/CharacterReferenceEx.html#setStart(int)'>CharacterReferenceEx.setStart</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="start" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object startAttr = jspContext.getAttribute("start");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "setStart", new Object[] {startAttr});
}
else
{
    sage.SageTV.api("setStart", new Object[] {startAttr});
}
%>
