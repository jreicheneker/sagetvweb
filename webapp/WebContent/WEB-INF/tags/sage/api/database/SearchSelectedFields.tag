<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Database.html#SearchSelectedFields(java.lang.String, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean)'>Database.SearchSelectedFields</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="searchString" required="true" type="java.lang.String" %>
<%@ attribute name="caseSensitive" required="true" type="java.lang.Boolean" %>
<%@ attribute name="titles" required="true" type="java.lang.Boolean" %>
<%@ attribute name="episode" required="true" type="java.lang.Boolean" %>
<%@ attribute name="description" required="true" type="java.lang.Boolean" %>
<%@ attribute name="people" required="true" type="java.lang.Boolean" %>
<%@ attribute name="category" required="true" type="java.lang.Boolean" %>
<%@ attribute name="rated" required="true" type="java.lang.Boolean" %>
<%@ attribute name="extendedRatings" required="true" type="java.lang.Boolean" %>
<%@ attribute name="year" required="true" type="java.lang.Boolean" %>
<%@ attribute name="misc" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object searchStringAttr = jspContext.getAttribute("searchString");
Object caseSensitiveAttr = jspContext.getAttribute("caseSensitive");
Object titlesAttr = jspContext.getAttribute("titles");
Object episodeAttr = jspContext.getAttribute("episode");
Object descriptionAttr = jspContext.getAttribute("description");
Object peopleAttr = jspContext.getAttribute("people");
Object categoryAttr = jspContext.getAttribute("category");
Object ratedAttr = jspContext.getAttribute("rated");
Object extendedRatingsAttr = jspContext.getAttribute("extendedRatings");
Object yearAttr = jspContext.getAttribute("year");
Object miscAttr = jspContext.getAttribute("misc");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "SearchSelectedFields", new Object[] {searchStringAttr, caseSensitiveAttr, titlesAttr, episodeAttr, descriptionAttr, peopleAttr, categoryAttr, ratedAttr, extendedRatingsAttr, yearAttr, miscAttr});
}
else
{
    returnVal = sage.SageTV.api("SearchSelectedFields", new Object[] {searchStringAttr, caseSensitiveAttr, titlesAttr, episodeAttr, descriptionAttr, peopleAttr, categoryAttr, ratedAttr, extendedRatingsAttr, yearAttr, miscAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
