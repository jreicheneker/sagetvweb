<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/SeriesInfoAPI.html#SetSeriesInfoProperty(sage.SeriesInfo, java.lang.String, java.lang.String)'>SeriesInfoAPI.SetSeriesInfoProperty</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="seriesInfo" required="true" type="java.lang.Object" %>
<%@ attribute name="propertyName" required="true" type="java.lang.String" %>
<%@ attribute name="propertyValue" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object seriesInfoAttr = jspContext.getAttribute("seriesInfo");
Object propertyNameAttr = jspContext.getAttribute("propertyName");
Object propertyValueAttr = jspContext.getAttribute("propertyValue");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetSeriesInfoProperty", new Object[] {seriesInfoAttr, propertyNameAttr, propertyValueAttr});
}
else
{
    sage.SageTV.api("SetSeriesInfoProperty", new Object[] {seriesInfoAttr, propertyNameAttr, propertyValueAttr});
}
%>
