<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#SetDVDVideoDecoderFilter(java.lang.String)'>Configuration.SetDVDVideoDecoderFilter</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="filterName" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object filterNameAttr = jspContext.getAttribute("filterName");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetDVDVideoDecoderFilter", new Object[] {filterNameAttr});
}
else
{
    sage.SageTV.api("SetDVDVideoDecoderFilter", new Object[] {filterNameAttr});
}
%>
