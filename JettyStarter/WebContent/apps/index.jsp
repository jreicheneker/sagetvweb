<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="org.mortbay.jetty.Handler" %>
<%@ page import="org.mortbay.jetty.handler.ContextHandler" %>
<%@ page import="org.mortbay.jetty.Server" %>
<%@ page import="org.mortbay.resource.Resource" %>
<%@ page import="sagex.api.PluginAPI"%>
<%@ page import="sagex.jetty.starter.JettyInstance" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <meta http-equiv="Cache-Control" content="no-cache"/> 
   <meta http-equiv="Pragma" content="no-cache"/> 
   <meta http-equiv="Expires" content="0"/> 
   <title>SageTV Web Applications</title>
   <link rel="stylesheet" type="text/css" href="apps.css"/>
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
      <div class="titlebar"><img class="logo" src="SageLogo256small.png" alt="SageTV" title="SageTV"/></div>
      <div class="title">Web Applications</div>
   </div>

   <div class="content">

      <%
      JettyInstance instance = JettyInstance.getInstance();
      Server server = instance.getServers().get(0);
      ContextHandler consoleContext = null;

      Handler[] handlerArray = (server == null) ? null : server.getChildHandlersByClass(ContextHandler.class);
      List<Handler> handlerList = new ArrayList<Handler>();

      if (handlerArray != null)
      {
         for (int i = 0; handlerArray != null && i < handlerArray.length; i++)
         {
             ContextHandler context = (ContextHandler)handlerArray[i];
             if (("/".equals(context.getContextPath())) ||
                 ("/apps".equals(context.getContextPath())))
             {
                continue;
             }
             if ("/console".equals(context.getContextPath()))
             {
                 consoleContext = context;
                 continue;
             }
             handlerList.add(context);
         }

         // Sort the applications by name
         Collections.sort(handlerList, new Comparator<Object>()
         {
            public int compare(Object handler1, Object handler2)
            {
               String handlerName1 = ((ContextHandler) handler1).getDisplayName();
               if (handlerName1 == null)
               {
                  handlerName1 = ((ContextHandler) handler1).getContextPath().substring(1);
               }
               String handlerName2 = ((ContextHandler) handler2).getDisplayName();
               if (handlerName2 == null)
               {
                  handlerName2 = ((ContextHandler) handler2).getContextPath().substring(1);
               }
               return handlerName1.compareToIgnoreCase(handlerName2);
            }
         });
      }
      %>

      <ul>
      <%
      if (handlerList.size() == 0)
      {
         out.write("<li class=\"appinfo\">No web applications are installed.</li>");
      }
      else
      {
         Object[] installedPlugins = PluginAPI.GetInstalledPlugins();

         for (int i = 0; i < handlerList.size(); i++)
         {
            ContextHandler context = (ContextHandler) handlerList.get(i);

            Object pluginIdAttribute = context.getAttribute("pluginid");
            String pluginId = (pluginIdAttribute == null) ? null : pluginIdAttribute.toString();
            Object webpageAttribute = context.getAttribute("webpage");
            String webpage = (webpageAttribute == null) ? null : webpageAttribute.toString();
            
            Resource faviconResource = context.getResource("/favicon.ico");
            String favIconPath = "/apps/favicon.ico";
            if (faviconResource != null)
            {
               java.io.File file = faviconResource.getFile();
               if (file != null)
               {
                  if (file.exists())
                  {
                     favIconPath = context.getContextPath() + "/favicon.ico";
                  }
               }
            }

            String installedPluginVersion = null;
            if (pluginId != null)
            {
                for (Object installedPlugin : installedPlugins)
                {
                    String installedPluginName = PluginAPI.GetPluginName(installedPlugin);
                    String installedPluginId = PluginAPI.GetPluginIdentifier(installedPlugin);
                    
                    if (pluginId.equals(installedPluginId))
                    {
                        installedPluginVersion = PluginAPI.GetPluginVersion(installedPlugin);
                        break;
                    }
                }
            }

            if (context.isRunning())
            {
               out.write("<li><a href=\"");
               out.write(context.getContextPath());
               if (context.getContextPath().length()>1 && context.getContextPath().endsWith("/"))
               {
                  out.write("/");
               }
               if (context.getAttribute("webpage") != null)
               {
                  out.write(context.getAttribute("webpage").toString());
               }
               out.write("\">");
               out.write("<div class=\"appimg\"><img class=\"app\" src=\"" + favIconPath + "\"/></div>");
               out.write("<div class=\"appinfo\">");
               if (context.getDisplayName() != null)
               {
                  out.write(context.getDisplayName());
               }
               else
               {
                  out.write(context.getContextPath().substring(1));
               }
               out.write("<div class=\"appdetails\">");
               if (installedPluginVersion != null)
               {
                   out.write("Version " + installedPluginVersion + "\n");
               }
               out.write("</div></div></a></li>\n");
            }
            else
            {
               out.write("<li>");
               out.write("<div class=\"appimg\"><img class=\"app\" src=\"" + favIconPath + "\"/></div>");
               out.write("<div class=\"appinfo\">");
               if (context.getDisplayName() != null)
               {
                  out.write(context.getDisplayName());
               }
               else
               {
                  out.write(context.getContextPath().substring(1));
               }
               out.write("<div class=\"appdetails\">");
               if (context.isFailed())
                  out.write("<br> [failed]");
               if (context.isStopped())
                  out.write("<br> [stopped]");
               if (installedPluginVersion != null)
               {
                   out.write("Version " + installedPluginVersion + "\n");
               }
               out.write("</div></div></li>\n");
            }
         }
      }
      %>
      </ul>
      
      <%
      if (consoleContext != null)
      {
      %>
      <ul>
         <li><a href="/console">
            <div class="appimg"><img class="app" src="/console/favicon.ico"/></div>
            <div class="appinfo">Settings
               <div class="appdetails">
               <%
               if (consoleContext.getAttribute("pluginid") != null)
               {
                  Object plugin = PluginAPI.GetAvailablePluginForID(consoleContext.getAttribute("pluginid").toString());
                  out.write("Version " + PluginAPI.GetPluginVersion(plugin));
               }
               %>
               </div>
            </div>
         </a></li>
      </ul>
      <%
      }
      %>

      <%      
         for (int i = 0; i < 10; i++)
         {
             // this comes from Jetty's DefaultHandler class
             out.write("\n<!-- Padding for IE                  -->");
         }
      %>
   </div>

   <div class="footer">
      <p>Page Generated <%= new Date() %></p>
      <p>Jetty Web Server Plugin Version <%= sagex.jetty.starter.JettyPlugin.class.getPackage().getImplementationVersion() %></p>
      <p>Jetty Web Server Version <%= Server.class.getPackage().getImplementationVersion() %></p>
   </div>

</body>
</html>
