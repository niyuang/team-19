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

<%
    pageTitle = "iTrust - Categorize Food Diary";
%>

<%@include file="/header.jsp"%>
<div align=center>
	<h2>Categorize Food Diary Entries</h2>
</div>

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
