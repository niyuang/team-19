<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="edu.ncsu.csc.itrust.action.BodyMeasurementAction"%>
<%@page import="edu.ncsu.csc.itrust.beans.BodyMeasurementBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page import="java.io.BufferedReader" %>


<%@include file="/global.jsp" %>

<%
pageTitle = "iTrust - View Body Measurements";
%>

<%@include file="/header.jsp" %>

</head>
<body>
<h1>JFreechart: Create Pie Chart Dynamically</h1>
<form id="form1">
  <img src="BodyChartServlet?key=didthismessagetpassedcorrectly" width="600" height="400" border="0"/>
  <input type="button" onclick="refreshpage()" value="Refresh"/>
</form>
</body>
</html>

<%@include file="/footer.jsp"%>