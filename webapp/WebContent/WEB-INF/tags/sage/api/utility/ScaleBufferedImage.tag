<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#ScaleBufferedImage(java.awt.image.BufferedImage, int, int, boolean)'>Utility.ScaleBufferedImage</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="javaBufferedImage" required="true" type="java.awt.image.BufferedImage" %>
<%@ attribute name="width" required="true" type="java.lang.Integer" %>
<%@ attribute name="height" required="true" type="java.lang.Integer" %>
<%@ attribute name="alpha" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object javaBufferedImageAttr = jspContext.getAttribute("javaBufferedImage");
Object widthAttr = jspContext.getAttribute("width");
Object heightAttr = jspContext.getAttribute("height");
Object alphaAttr = jspContext.getAttribute("alpha");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "ScaleBufferedImage", new Object[] {javaBufferedImageAttr, widthAttr, heightAttr, alphaAttr});
}
else
{
    returnVal = sage.SageTV.api("ScaleBufferedImage", new Object[] {javaBufferedImageAttr, widthAttr, heightAttr, alphaAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
