<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaFileAPI.html#AddMediaFile(java.io.File, java.lang.String)'>MediaFileAPI.AddMediaFile</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="file" required="true" type="java.io.File" %>
<%@ attribute name="namePrefix" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object fileAttr = jspContext.getAttribute("file");
Object namePrefixAttr = jspContext.getAttribute("namePrefix");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AddMediaFile", new Object[] {fileAttr, namePrefixAttr});
}
else
{
    returnVal = sage.SageTV.api("AddMediaFile", new Object[] {fileAttr, namePrefixAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
