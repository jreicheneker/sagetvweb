<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileReader"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URISyntaxException"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="org.json.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sageglbl" tagdir="/WEB-INF/tags/sage/api/global" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf"%>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <title>SageTV Mobile Web Menu</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>
   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Menu" />
   </jsp:include>

   <div class="content">
<%
// use user's custom menu if it exists, otherwise use default menu
URL defaultFileUrl = getServletContext().getResource("/WEB-INF/mobile_menu.json");
// jump through hoops to deal with spaces in the path (mainly for Windows Programs Files directory) 
// http://weblogs.java.net/blog/2007/04/25/how-convert-javaneturl-javaiofile
File defaultFile;
try
{
    // convert %20 to a space
    defaultFile = new File(defaultFileUrl.toURI());
}
catch (URISyntaxException e)
{
    defaultFile = new File(defaultFileUrl.getPath());
}
File userFile = new File("jetty/user" + request.getContextPath() + "/mobile_menu.json");
FileReader reader = null;
if (userFile.exists())
{
   reader = new FileReader(userFile);
}
else
{
   reader = new FileReader(defaultFile);
}
JSONTokener tokener = new JSONTokener(reader);
JSONArray menus = new JSONArray(tokener);
reader.close();

for (int i = 0; i < menus.length(); i++)
{
   JSONObject menu = menus.getJSONObject(i);
   Object menuName = menu.get("title");
   boolean menuVisible = menu.optBoolean("visible", true);
   Object defaultItemImage = menu.opt("defaultItemImage");

   request.setAttribute("defaultItemImage", JSONObject.NULL.equals(defaultItemImage) ? null : defaultItemImage);

   if (!menuVisible)
   {
      continue;
   }

   %>
   <div class="menu section"><%= menuName.toString() %></div> 
   <%
//************Custom code for web remote sub menus*************
   if ("Web Remote".equals(menuName)){%>
      <sageglbl:GetUIContextNames var="contexts"/>
      <sageglbl:GetConnectedClients var="connectedClients"/>
      <c:if test="${empty contexts and empty connectedClients}">
         <table cellpadding="0" cellspacing="0">
            <tr>
               <td class="menuimage"><div></div></td>
               <td class="menuitem">
                  <div>No clients, placeshifters or extenders connected</div>
               </td>
            </tr>
         </table>
      </c:if>
      <c:if test="${!empty contexts or !empty connectedClients}">
         <table cellpadding="0" cellspacing="0">
            <c:forEach var="context" items="${contexts}">
               <c:set var="contextName" value="<%= sagex.webserver.UiContextProperties.getProperty(pageContext.getAttribute("context").toString(), "name") %>"/>
               <tr>
                  <td class="menuimage"><div><c:if test="${!empty defaultItemImage}"><img src="${defaultItemImage}"/></c:if></div></td>
                  <td class="menuitem">
                     <div><a href="webremote.jsp?context=${context}">${contextName}</a></div>
                  </td>
               </tr>
            </c:forEach>
            <c:forEach var="client" items="${connectedClients}">
               <tr>
                  <c:set var="clientName" value= "<%= sagex.webserver.UiContextProperties.getProperty(pageContext.getAttribute("client").toString(), "name") %>"/>
                  <td class="menuimage"><div><c:if test="${!empty defaultItemImage}"><img src="${defaultItemImage}"/></c:if></div></td>
                  <td class="menuitem">
                     <div><a href="webremote.jsp?context=${client}">${clientName}</a></div>
                  </td>
               </tr>
            </c:forEach>
         </table>
      </c:if>
   <%}
//************End custom code for web remote sub menus******************* 
JSONArray items = menu.optJSONArray("items");
   //if (menu.length() >= 4)
   if (!JSONObject.NULL.equals(items) && items.length() > 0)
   {
      %>
      <table cellpadding="0" cellspacing="0" width="100%">
      <%
      // menu items
      for (int j = 0; j < items.length(); j++)
      {
         JSONObject menuItem = items.getJSONObject(j);
         Object menuItemName  = menuItem.get("title");
         Object menuItemLink  = menuItem.opt("link");
         Object menuItemImage = menuItem.opt("image");
         boolean menuItemVisible = menuItem.optBoolean("visible", true);

         if (menuItemVisible)
         {
            // sub menu item array
            /*JSONArray menuItems = menuItem.optJSONArray("items");
            if (!JSONObject.NULL.equals(menuItems))
            {
               menuItemLink = URLEncoder.encode(menuItemName.toString(), "UTF-8");
               menuItemLink = "usermenu_new.jsp?menu=" + menuItemLink;
            }*/
            
            request.setAttribute("menuItemName",  menuItemName);
            request.setAttribute("menuItemLink",  JSONObject.NULL.equals(menuItemLink)  ? null : menuItemLink);
            request.setAttribute("menuItemImage", JSONObject.NULL.equals(menuItemImage) ? defaultItemImage : menuItemImage);
            %>
            <tr>
               <td class="menuimage"><div><c:if test="${!empty menuItemImage}"><img src="${menuItemImage}"/></c:if></div></td>
               <td class="menuitem"><div><c:if test="${!empty menuItemLink}"><a href="${menuItemLink}"></c:if>${menuItemName}<c:if test="${!empty menuItemLink}"></a></c:if></div></td>
            </tr>
            <%
         }
      }
      %>
      </table>
      <%
   }
}
%>

   </div>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
