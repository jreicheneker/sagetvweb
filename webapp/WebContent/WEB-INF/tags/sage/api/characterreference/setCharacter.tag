<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/CharacterReference.html#setCharacter(int)'>CharacterReference.setCharacter</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="character" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object characterAttr = jspContext.getAttribute("character");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "setCharacter", new Object[] {characterAttr});
}
else
{
    sage.SageTV.api("setCharacter", new Object[] {characterAttr});
}
%>
