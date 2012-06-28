<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#SetScrollPosition(float, float)'>Utility.SetScrollPosition</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="relativeX" required="true" type="java.lang.Float" %>
<%@ attribute name="relativeY" required="true" type="java.lang.Float" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object relativeXAttr = jspContext.getAttribute("relativeX");
Object relativeYAttr = jspContext.getAttribute("relativeY");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetScrollPosition", new Object[] {relativeXAttr, relativeYAttr});
}
else
{
    sage.SageTV.api("SetScrollPosition", new Object[] {relativeXAttr, relativeYAttr});
}
%>
