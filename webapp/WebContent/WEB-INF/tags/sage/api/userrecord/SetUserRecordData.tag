<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/UserRecordAPI.html#SetUserRecordData(sage.UserRecord, java.lang.String, java.lang.String)'>UserRecordAPI.SetUserRecordData</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="userRecord" required="true" type="java.lang.Object" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object userRecordAttr = jspContext.getAttribute("userRecord");
Object nameAttr = jspContext.getAttribute("name");
Object valueAttr = jspContext.getAttribute("value");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetUserRecordData", new Object[] {userRecordAttr, nameAttr, valueAttr});
}
else
{
    sage.SageTV.api("SetUserRecordData", new Object[] {userRecordAttr, nameAttr, valueAttr});
}
%>
