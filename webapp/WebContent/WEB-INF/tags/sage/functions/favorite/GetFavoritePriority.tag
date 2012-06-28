<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="favorite" required="true" type="java.lang.Object" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
int priority = -1;
Object favorite = jspContext.getAttribute("favorite");
Object favoriteId = SageTV.api("GetFavoriteID", new Object[] {favorite});
Object favorites = SageTV.api("GetFavorites", null);
favorites = SageTV.api("Sort", new Object[] {favorites, Boolean.FALSE, "FavoritePriority"});
Integer favoritesSize = (Integer) SageTV.api("Size", new Object[] {favorites});

for (int i = 1; i <= favoritesSize; i++)
{
    Object currentFavorite = SageTV.api("GetElement", new Object[] {favorites, i - 1});
    Object currentFavoriteId = SageTV.api("GetFavoriteID", new Object[] {currentFavorite});
    if (favoriteId.equals(currentFavoriteId))
    {
        priority = i;
        break;
    }
}
%>

<c:set var="varLocal" value="<%= priority %>"/>
