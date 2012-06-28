<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <title>Credits</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Credits" />
   </jsp:include>

   <div class="content">
      <div class="details">

         <p>The SageTV Mobile Web Interface was created by jreichen.  Other contributions:</p>
         <ul>
            <li>Mobile Web Remote: PiX64 and kricker</li>
         </ul>
      
         <p>Various components from original web server:</p>
         <ul>
            <li>nielm, jreichen and emok</li>
         </ul>

         <p>Auto-generation of SageTV API wrappers:</p>
         <ul>
            <li>stuckless and gkusnick</li>
         </ul>

         <p>Web server engine: <a href="http://www.mortbay.org/">Jetty</a> from Mortbay Consulting</p>

      </div>
   </div>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
