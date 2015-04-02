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
	
	//Check here to sure on is not greater than other
	
	DateCheck checker = new DateCheck();
	boolean status = false; 
	
	status = checker.checkRange(rangeDateStart, rangeDateEnd);
	
	if(status == true){
	}else if(status == false){
		//set session var
		//redirect
	}
	
	
	session.setAttribute("start", rangeDateStart);
	session.setAttribute("end", rangeDateEnd);
	response.sendRedirect("/iTrust/auth/patient/viewFoodDiaryPat.jsp");

%>

<%@include file="/footer.jsp"%>