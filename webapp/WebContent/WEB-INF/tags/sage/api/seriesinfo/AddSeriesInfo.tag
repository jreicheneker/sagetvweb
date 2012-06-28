<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/SeriesInfoAPI.html#AddSeriesInfo(int, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String[], java.lang.String[])'>SeriesInfoAPI.AddSeriesInfo</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="seriesID" required="true" type="java.lang.Integer" %>
<%@ attribute name="title" required="true" type="java.lang.String" %>
<%@ attribute name="network" required="true" type="java.lang.String" %>
<%@ attribute name="description" required="true" type="java.lang.String" %>
<%@ attribute name="history" required="true" type="java.lang.String" %>
<%@ attribute name="premiereDate" required="true" type="java.lang.String" %>
<%@ attribute name="finaleDate" required="true" type="java.lang.String" %>
<%@ attribute name="airDOW" required="true" type="java.lang.String" %>
<%@ attribute name="airHrMin" required="true" type="java.lang.String" %>
<%@ attribute name="imageURL" required="true" type="java.lang.String" %>
<%@ attribute name="people" required="true" type="java.lang.String[]" %>
<%@ attribute name="characters" required="true" type="java.lang.String[]" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object seriesIDAttr = jspContext.getAttribute("seriesID");
Object titleAttr = jspContext.getAttribute("title");
Object networkAttr = jspContext.getAttribute("network");
Object descriptionAttr = jspContext.getAttribute("description");
Object historyAttr = jspContext.getAttribute("history");
Object premiereDateAttr = jspContext.getAttribute("premiereDate");
Object finaleDateAttr = jspContext.getAttribute("finaleDate");
Object airDOWAttr = jspContext.getAttribute("airDOW");
Object airHrMinAttr = jspContext.getAttribute("airHrMin");
Object imageURLAttr = jspContext.getAttribute("imageURL");
Object peopleAttr = jspContext.getAttribute("people");
Object charactersAttr = jspContext.getAttribute("characters");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AddSeriesInfo", new Object[] {seriesIDAttr, titleAttr, networkAttr, descriptionAttr, historyAttr, premiereDateAttr, finaleDateAttr, airDOWAttr, airHrMinAttr, imageURLAttr, peopleAttr, charactersAttr});
}
else
{
    returnVal = sage.SageTV.api("AddSeriesInfo", new Object[] {seriesIDAttr, titleAttr, networkAttr, descriptionAttr, historyAttr, premiereDateAttr, finaleDateAttr, airDOWAttr, airHrMinAttr, imageURLAttr, peopleAttr, charactersAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
