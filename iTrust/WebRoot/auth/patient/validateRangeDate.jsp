<%@page import="edu.ncsu.csc.itrust.exception.DBException"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>
<%@page import="edu.ncsu.csc.itrust.action.DateCheck"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page import="java.io.BufferedReader" %>


<%@page errorPage="/auth/exceptionHandler.jsp" %>

<%@taglib prefix="itrust" uri="/WEB-INF/tags.tld" %>

<%@include file="/global.jsp"%>

<% 
	String rangeDateStart = request.getParameter("rangeDateStart");
	String rangeDateEnd = request.getParameter("rangeDateEnd");

	System.out.println("received DS: " + rangeDateStart);
	System.out.println("received DE: " + rangeDateEnd);
	
	DateCheck checker = new DateCheck();
	boolean status = false; 
	
	status = checker.checkRange(rangeDateStart, rangeDateEnd);
	
	if(status == true){
		System.out.println("correct date format");
	}else if(status == false){
		System.out.println("bad date format");
	}
	
	
	response.sendRedirect("/iTrust/auth/patient/categorizeFoodDiary.jsp");

%>

<%@include file="/footer.jsp"%>