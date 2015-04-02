<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page import="java.io.BufferedReader" %>
<%@page import="java.text.DecimalFormat"%>  

<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>
<%@page errorPage="/auth/exceptionHandler.jsp" %>
<%@page import="edu.ncsu.csc.itrust.exception.DBException"%>

<%@taglib prefix="itrust" uri="/WEB-INF/tags.tld" %>

<%@include file="/global.jsp"%>

<%@include file="/header.jsp"%>
<div align=center>
	<h2>Categorize Food Diary Entries</h2>
</div>

<%
    pageTitle = "iTrust - Categorize Food Diary";


	//Clears the session vars that hold the date

	if(session.getAttribute("single") != null){
	session.setAttribute("single", null);
	}
	if(session.getAttribute("start") != null){
		session.setAttribute("start", null);
	}
	if(session.getAttribute("end") != null){
		session.setAttribute("end", null);
	}
	//Error Handling Session Variables
	if(session.getAttribute("singleDateError") != null){
		out.println("<div align=center> <span style=\"color:red\"  class=\"font_success\">" + session.getAttribute("singleDateError")+ "<br>" + "</span></div>");
	session.setAttribute("singleDateError", null);
	}

%>



<br>
<br>

<form method="post" action="validateSingleDate.jsp" name=single>
<h4>Single Date</h4>
<table>
<tr>
<td><span class="font1">Date &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="singleDate">
<input type="submit" value="Filter"></td>
</tr>
</table>
</form>

<br>
<br>

<form method="post" action="validateRangeDate.jsp" name=range>
<h4>Range of Dates</h4>
<table>
<tr>
<td><span class="font1">Start &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="rangeDateStart">
<span class="font1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; End &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="rangeDateEnd">
<input type="submit" value="Filter"></td>
</tr>
</table>
</form>





<%@include file="/footer.jsp"%>
