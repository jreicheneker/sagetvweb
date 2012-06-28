<%@ tag body-content="empty"%>
<%@ tag import="java.util.Calendar" %>
<%@ tag import="java.util.GregorianCalendar" %>
<%@ tag import="java.util.regex.Matcher" %>
<%@ tag import="java.util.regex.Pattern" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="hour" required="false" type="java.lang.Integer"%>
<%@ attribute name="date" required="true" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
GregorianCalendar date = null;
String dateString = (String) jspContext.getAttribute("date");

if (dateString != null)
{
	Pattern p = Pattern.compile("([0-9]{4})/([0-9]{2})/([0-9]{2})");
	Matcher m = p.matcher(dateString);
	if (m.matches())
	{
		date = new GregorianCalendar();
		date.set(Integer.parseInt(m.group(1)),
				 Integer.parseInt(m.group(2))-1,
				 Integer.parseInt(m.group(3)));
	}
	else
	{
		try
		{
			int dayoffset = Integer.parseInt(dateString);
			date = new GregorianCalendar();
			date.add(Calendar.DAY_OF_YEAR, dayoffset);
		}
		catch (Exception e) {}
	}
}

if (date == null)
{
	date = new GregorianCalendar();
}

if ((hour == null) || (hour == -1))
{
	// current hour
	hour = new GregorianCalendar().get(Calendar.HOUR_OF_DAY);
}

date.set(Calendar.HOUR_OF_DAY, hour);
date.set(Calendar.MINUTE, 0);
date.set(Calendar.SECOND, 0);
date.set(Calendar.MILLISECOND, 0);
%>

<c:set var="varLocal" value="<%= date.getTime() %>"/>
