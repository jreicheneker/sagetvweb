<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#SaveImageToFile(sage.MetaImage, java.io.File, int, int)'>Utility.SaveImageToFile</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="metaImage" required="true" type="java.lang.Object" %>
<%@ attribute name="file" required="true" type="java.io.File" %>
<%@ attribute name="width" required="true" type="java.lang.Integer" %>
<%@ attribute name="height" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object metaImageAttr = jspContext.getAttribute("metaImage");
Object fileAttr = jspContext.getAttribute("file");
Object widthAttr = jspContext.getAttribute("width");
Object heightAttr = jspContext.getAttribute("height");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "SaveImageToFile", new Object[] {metaImageAttr, fileAttr, widthAttr, heightAttr});
}
else
{
    returnVal = sage.SageTV.api("SaveImageToFile", new Object[] {metaImageAttr, fileAttr, widthAttr, heightAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
