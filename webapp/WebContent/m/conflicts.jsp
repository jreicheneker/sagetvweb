<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sageair" tagdir="/WEB-INF/tags/sage/api/airing" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sageglbl" tagdir="/WEB-INF/tags/sage/api/global" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <title>Recording Conflicts</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Recording Conflicts" />
   </jsp:include>

   <sageglbl:GetScheduledRecordings var="recordings"/>
   <sageglbl:GetAiringsThatWontBeRecorded var="unresolvedConflicts" onlyUnresolved="true"/>
   <sageglbl:GetAiringsThatWontBeRecorded var="allConflicts" onlyUnresolved="false"/>
   <sagedb:SortLexical var="allConflicts" data="${allConflicts}" descending="false" sortByMethod="GetAiringTitle"/>
   <sagedb:Sort var="conflictsList" data="${allConflicts}" descending="false" sortTechnique="GetAiringStartTime"/>

   <div class="subheader">
      <%@ include file="/WEB-INF/jspf/m/conflictstats.jspf" %>
   </div>

   <div class="content">
      <c:forEach items="${conflictsList}" var="airing" varStatus="status">
         <sageair:GetAiringTitle var="airingTitle" airing="${airing}"/>
         <%@ include file="/WEB-INF/jspf/m/airingcell.jspf" %>
      </c:forEach>
   </div>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>