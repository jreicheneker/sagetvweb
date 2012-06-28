<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="sagex.api.PluginAPI"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <meta http-equiv="Cache-Control" content="no-cache"/> 
   <meta http-equiv="Pragma" content="no-cache"/> 
   <meta http-equiv="Expires" content="0"/> 
   <title>SageTV Media Streaming Services</title>
   <link rel="stylesheet" type="text/css" href="mediastreaming.css"/>
   <link rel="Shortcut Icon" href="favicon.ico" type="image/x-icon"/>
   <%-- iphone headers --%>
   <meta name="viewport" content="user-scalable=no, width=device-width" /> <%-- iDevices --%>
   <%--link rel="apple-touch-icon" href="${cp}/images/SageIcon64.png" /> <!-- iPhone home screen icon -->
   <link rel="apple-touch-startup-image" href="${cp}/images/SageStartupLogo256-mgopenmodata13.png" /> <!-- iPhone startup graphic -->
   <meta name="apple-mobile-web-app-capable" content="yes" />
   <meta name="apple-mobile-web-app-status-bar-style" content="black" /--%>
</head>
<body>

   <div class="header">
      <div class="titlebar"><img class="logo" src="SageLogo256smaller.png" alt="SageTV" title="SageTV"/></div>
      <div class="title">Media Streaming Services</div>
   </div>

   <div class="content">
      <p>   
      The Media Streaming Services Plugin provides video streaming services to other applications
      such as the Mobile Web Interface, it is not an end-user web application.
      </p>
   
      <c:if test="${!empty header.Referer}">
         <p>
            <a href="${header.Referer}">Return to previous page</a>
         </p>
      </c:if>
   </div>

   <div class="footer">
      <p>Page Generated <%= new Date() %></p>
      <%
      Object plugin = PluginAPI.GetAvailablePluginForID("mediastreaming");
      %>
      <p>SageTV Media Streaming Services Version <%= PluginAPI.GetPluginVersion(plugin) %></p>
   </div>

</body>
</html>
