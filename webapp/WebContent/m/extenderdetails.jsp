<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sageglbl" tagdir="/WEB-INF/tags/sage/api/global" %> 
<%@ taglib prefix="sageutilfn" tagdir="/WEB-INF/tags/sage/functions/utility" %> 

<sageglbl:IsClient var="isSageClient" context="${param.context}"/>
<c:if test="${isSageClient}">
   <c:set var="pageTitle" value="Client Details"></c:set>
</c:if>
<c:if test="${not isSageClient}">
   <c:set var="pageTitle" value="Extender Details"></c:set>
</c:if>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <title>${pageTitle}</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="${pageTitle}" />
   </jsp:include>

   <div class="content">
      <div class="details">

      <c:set var="formId" value="RenameUiContextForm"/>
      <form id="${formId}" method="post" action="${cp}/m/Command">
         <input type="hidden"/>
<%-- TODO show popup on extender --%>

<%--

Object parentWidget = sage.SageTV.apiUI("00085c53c79e", "GetCurrentMenuWidget", new Object[] {});
Object panel = sage.SageTV.apiUI("00085c53c79e", "AddWidget", new Object[] {"Panel"});
Object text = sage.SageTV.apiUI("00085c53c79e", "AddWidget", new Object[] {"Text"});
sage.SageTV.apiUI("00085c53c79e", "AddWidgetChild", new Object[] {panel, text});
Object result = sage.SageTV.apiUI("00085c53c79e", "ExecuteWidgetChain", new Object[] {panel});
return result;

--%>
         <div class="label">Id</div>
         <div class="value">
            ${param.context}
         </div>
<%-- GetLogo --%>
         <div class="label">Name</div>
         <div class="value">
            <input type="text" name="name" value="<%= sagex.webserver.UiContextProperties.getProperty(request.getParameter("context"), "name") %>" />
            <input type="hidden" name="context" value="${param.context}"/>
            <input type="hidden" name="returnto" value="${cp}/m/extenderdetails.jsp?${pageContext.request.queryString}"/><br/>
            <button type="submit" name="command" value="RenameUiContext">Rename</button> 
         </div>

         <sageglbl:GetRemoteUIType var="uiType" context="${param.context}"/>
         <div class="label">Type</div>
         <div class="value">
            ${uiType}
         </div>

<%--
         // No API for GetOS that takes context as a parameter
         <sageglbl:GetOS var="platform" context="${param.context}"/>
         <div class="label">Platform</div>
         <div class="value">
            ${platform}
         </div>
 --%>

         <sageglbl:GetRemoteClientVersion var="uiVersion" context="${param.context}"/>
         <div class="label">Version</div>
         <div class="value">
            ${uiVersion}
         </div>

         <sageglbl:IsFullScreen var="isFullScreen" context="${param.context}"/>
         <sageutilfn:BoolToYesNo var="isFullScreen" value="${isFullScreen}"/>
         <div class="label">Full Screen</div>
         <div class="value">
            ${isFullScreen}
         </div>

         <sageglbl:GetFullUIWidth var="width" context="${param.context}"/>
         <sageglbl:GetFullUIHeight var="height" context="${param.context}"/>
         <div class="label">Window Size</div>
         <div class="value">
            ${width}x${height}
         </div>

         <sageglbl:GetDisplayResolution var="uiResolution" context="${param.context}"/>
         <div class="label">Display Resolution</div>
         <div class="value">
            ${uiResolution}
         </div>

         <sageglbl:GetDisplayResolutionOptions var="uiResolutionOptions" context="${param.context}"/>
         <c:if test="${!empty uiResolutionOptions}">
            <div class="label">Display Resolution Options</div>
            <div class="value">
               <c:forEach var="uiResolutionOption" items="${uiResolutionOptions}">
                  <p>${uiResolutionOption}</p>
               </c:forEach>
            </div>
         </c:if>

         <%--sageglbl:GetAvailableUpdate var="availableUpdate" context="${param.context}"/>
         <div class="label">Available Update</div>
         <div class="value">
            ${availableUpdate}
         </div--%>

         <sageglbl:IsAsleep var="isAsleep" context="${param.context}"/>
         <sageutilfn:BoolToYesNo var="isAsleep" value="${isAsleep}"/>
         <div class="label">Asleep</div>
         <div class="value">
            ${isAsleep}
         </div>

      </form>
      <script language="JavaScript">
      <!--
         $('#${formId}').ajaxForm();
      //-->
      </script>
   </div>
   </div>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
