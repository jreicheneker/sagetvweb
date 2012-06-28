<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/ShowAPI.html#AddShow(java.lang.String, boolean, java.lang.String, java.lang.String, long, java.lang.String, java.lang.String, java.lang.String[], java.lang.String[], java.lang.String, java.lang.String[], java.lang.String, java.lang.String, java.lang.String[], java.lang.String, java.lang.String, long)'>ShowAPI.AddShow</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="title" required="true" type="java.lang.String" %>
<%@ attribute name="isFirstRun" required="true" type="java.lang.Boolean" %>
<%@ attribute name="episode" required="true" type="java.lang.String" %>
<%@ attribute name="description" required="true" type="java.lang.String" %>
<%@ attribute name="duration" required="true" type="java.lang.Long" %>
<%@ attribute name="category" required="true" type="java.lang.String" %>
<%@ attribute name="subCategory" required="true" type="java.lang.String" %>
<%@ attribute name="peopleList" required="true" type="java.lang.String[]" %>
<%@ attribute name="rolesListForPeopleList" required="true" type="java.lang.String[]" %>
<%@ attribute name="rated" required="true" type="java.lang.String" %>
<%@ attribute name="expandedRatingsList" required="true" type="java.lang.String[]" %>
<%@ attribute name="year" required="true" type="java.lang.String" %>
<%@ attribute name="parentalRating" required="true" type="java.lang.String" %>
<%@ attribute name="miscList" required="true" type="java.lang.String[]" %>
<%@ attribute name="externalID" required="true" type="java.lang.String" %>
<%@ attribute name="language" required="true" type="java.lang.String" %>
<%@ attribute name="originalAirDate" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object titleAttr = jspContext.getAttribute("title");
Object isFirstRunAttr = jspContext.getAttribute("isFirstRun");
Object episodeAttr = jspContext.getAttribute("episode");
Object descriptionAttr = jspContext.getAttribute("description");
Object durationAttr = jspContext.getAttribute("duration");
Object categoryAttr = jspContext.getAttribute("category");
Object subCategoryAttr = jspContext.getAttribute("subCategory");
Object peopleListAttr = jspContext.getAttribute("peopleList");
Object rolesListForPeopleListAttr = jspContext.getAttribute("rolesListForPeopleList");
Object ratedAttr = jspContext.getAttribute("rated");
Object expandedRatingsListAttr = jspContext.getAttribute("expandedRatingsList");
Object yearAttr = jspContext.getAttribute("year");
Object parentalRatingAttr = jspContext.getAttribute("parentalRating");
Object miscListAttr = jspContext.getAttribute("miscList");
Object externalIDAttr = jspContext.getAttribute("externalID");
Object languageAttr = jspContext.getAttribute("language");
Object originalAirDateAttr = jspContext.getAttribute("originalAirDate");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AddShow", new Object[] {titleAttr, isFirstRunAttr, episodeAttr, descriptionAttr, durationAttr, categoryAttr, subCategoryAttr, peopleListAttr, rolesListForPeopleListAttr, ratedAttr, expandedRatingsListAttr, yearAttr, parentalRatingAttr, miscListAttr, externalIDAttr, languageAttr, originalAirDateAttr});
}
else
{
    returnVal = sage.SageTV.api("AddShow", new Object[] {titleAttr, isFirstRunAttr, episodeAttr, descriptionAttr, durationAttr, categoryAttr, subCategoryAttr, peopleListAttr, rolesListForPeopleListAttr, ratedAttr, expandedRatingsListAttr, yearAttr, parentalRatingAttr, miscListAttr, externalIDAttr, languageAttr, originalAirDateAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
