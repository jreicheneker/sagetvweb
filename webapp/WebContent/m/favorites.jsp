<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sagefav" tagdir="/WEB-INF/tags/sage/api/favorite" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <title>SageTV Favorites</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Favorites" />
   </jsp:include>

   <div class="content">
      <sagefav:GetFavorites var="favorites" />
      <sagedb:Sort var="favorites" data="${favorites}" descending="false" sortTechnique="FavoritePriority" />

      <div class="subheader">New by:
         <a href="favoritedetails.jsp?AddTitle=">[Title]</a>
         <a href="favoritedetails.jsp?AddPerson=">[Actor]</a>
         <a href="favoritedetails.jsp?AddCategory=">[Category]</a>
         <a href="favoritedetails.jsp?AddKeyword=">[Keyword]</a>
      </div>

      <c:set var="airingList" scope="request" value="${favorites}"/>
      <jsp:include page="/WEB-INF/jspf/m/airinglist.jspf"/>
   </div>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
