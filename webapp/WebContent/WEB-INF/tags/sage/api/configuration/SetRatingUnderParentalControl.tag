<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#SetRatingUnderParentalControl(java.lang.String, boolean)'>Configuration.SetRatingUnderParentalControl</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="rating" required="true" type="java.lang.String" %>
<%@ attribute name="restricted" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object ratingAttr = jspContext.getAttribute("rating");
Object restrictedAttr = jspContext.getAttribute("restricted");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetRatingUnderParentalControl", new Object[] {ratingAttr, restrictedAttr});
}
else
{
    sage.SageTV.api("SetRatingUnderParentalControl", new Object[] {ratingAttr, restrictedAttr});
}
%>
