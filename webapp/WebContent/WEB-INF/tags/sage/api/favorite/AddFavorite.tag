<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/FavoriteAPI.html#AddFavorite(java.lang.String, boolean, boolean, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String)'>FavoriteAPI.AddFavorite</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="title" required="true" type="java.lang.String" %>
<%@ attribute name="firstRuns" required="true" type="java.lang.Boolean" %>
<%@ attribute name="reRuns" required="true" type="java.lang.Boolean" %>
<%@ attribute name="category" required="true" type="java.lang.String" %>
<%@ attribute name="subCategory" required="true" type="java.lang.String" %>
<%@ attribute name="person" required="true" type="java.lang.String" %>
<%@ attribute name="roleForPerson" required="true" type="java.lang.String" %>
<%@ attribute name="rated" required="true" type="java.lang.String" %>
<%@ attribute name="year" required="true" type="java.lang.String" %>
<%@ attribute name="parentalRating" required="true" type="java.lang.String" %>
<%@ attribute name="network" required="true" type="java.lang.String" %>
<%@ attribute name="channelCallSign" required="true" type="java.lang.String" %>
<%@ attribute name="timeslot" required="true" type="java.lang.String" %>
<%@ attribute name="keyword" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object titleAttr = jspContext.getAttribute("title");
Object firstRunsAttr = jspContext.getAttribute("firstRuns");
Object reRunsAttr = jspContext.getAttribute("reRuns");
Object categoryAttr = jspContext.getAttribute("category");
Object subCategoryAttr = jspContext.getAttribute("subCategory");
Object personAttr = jspContext.getAttribute("person");
Object roleForPersonAttr = jspContext.getAttribute("roleForPerson");
Object ratedAttr = jspContext.getAttribute("rated");
Object yearAttr = jspContext.getAttribute("year");
Object parentalRatingAttr = jspContext.getAttribute("parentalRating");
Object networkAttr = jspContext.getAttribute("network");
Object channelCallSignAttr = jspContext.getAttribute("channelCallSign");
Object timeslotAttr = jspContext.getAttribute("timeslot");
Object keywordAttr = jspContext.getAttribute("keyword");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AddFavorite", new Object[] {titleAttr, firstRunsAttr, reRunsAttr, categoryAttr, subCategoryAttr, personAttr, roleForPersonAttr, ratedAttr, yearAttr, parentalRatingAttr, networkAttr, channelCallSignAttr, timeslotAttr, keywordAttr});
}
else
{
    returnVal = sage.SageTV.api("AddFavorite", new Object[] {titleAttr, firstRunsAttr, reRunsAttr, categoryAttr, subCategoryAttr, personAttr, roleForPersonAttr, ratedAttr, yearAttr, parentalRatingAttr, networkAttr, channelCallSignAttr, timeslotAttr, keywordAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
