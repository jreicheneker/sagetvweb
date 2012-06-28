<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/ChannelAPI.html#AddChannel(java.lang.String, java.lang.String, java.lang.String, int)'>ChannelAPI.AddChannel</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="callSign" required="true" type="java.lang.String" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>
<%@ attribute name="network" required="true" type="java.lang.String" %>
<%@ attribute name="stationID" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object callSignAttr = jspContext.getAttribute("callSign");
Object nameAttr = jspContext.getAttribute("name");
Object networkAttr = jspContext.getAttribute("network");
Object stationIDAttr = jspContext.getAttribute("stationID");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AddChannel", new Object[] {callSignAttr, nameAttr, networkAttr, stationIDAttr});
}
else
{
    returnVal = sage.SageTV.api("AddChannel", new Object[] {callSignAttr, nameAttr, networkAttr, stationIDAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
