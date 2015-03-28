<%@page import="edu.ncsu.csc.itrust.action.FoodDiaryAction"%> <% //  Fooddiaryaction %> 
<%@page import="edu.ncsu.csc.itrust.beans.FoodDiaryBean"%> <% //  Changed to EntryBean %> 

<%@page import="edu.ncsu.csc.itrust.action.DietSuggestionAction"%>  
<%@page import="edu.ncsu.csc.itrust.beans.DietSuggestionBean"%> 

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page import="java.io.BufferedReader" %>


<%@page errorPage="/auth/exceptionHandler.jsp" %>
<%@page import="edu.ncsu.csc.itrust.exception.DBException"%>

<%@taglib prefix="itrust" uri="/WEB-INF/tags.tld" %>

<%@include file="/global.jsp"%>

<%
    pageTitle = "iTrust - View Patient Food Diary";
%>

<%@include file="/header.jsp"%>

<div style="color: red;">

<%

FoodDiaryAction action = new FoodDiaryAction(prodDAO, loggedInMID);
List<FoodDiaryBean> eatlist = action.getFoodDiary();

DietSuggestionAction suggestionAction = new DietSuggestionAction(prodDAO, loggedInMID);
List<DietSuggestionBean> suggestionList = suggestionAction.getSuggestion();

SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");

loggingAction.logEvent(TransactionType.VIEW_FOOD_DIARY, loggedInMID.longValue(), loggedInMID.longValue() , "Patient views their food diary");
loggingAction.logEvent(TransactionType.VIEW_SUGGESTION, loggedInMID.longValue(), loggedInMID.longValue() , "Patient views their suggestion");

if(session.getAttribute("err1") != null){
	out.println("<span class=\"myspan\">" + session.getAttribute("err1")+ "<br>" + "</span>");
	session.setAttribute("err1", null);
}

%>
</div>



<table class="fTable" align="center" id="foodDiaryTable">
    <tr>
        <th colspan="13">Patient Food Diary</th>
    </tr>

    <tr class="subHeader">
        <td style="text-align: center">Consumption<br>Date</td>
        <td style="text-align: center">Type of<br>Meal</td>
        <td style="text-align: center">Name of<br>food</td>
        <td style="text-align: center">Servings</td>
        <td style="text-align: center">Calories per<br>Serving</td>
        <td style="text-align: center">Grams Fat per<br>Serving</td>
        <td style="text-align: center">mg Sodium per<br>Serving</td>
        <td style="text-align: center">Grams Carbs per<br>Serving</td>
        <td style="text-align: center">Grams Sugars per<br>Serving</td>
        <td style="text-align: center">Grams Fiber per<br>Serving</td>
        <td style="text-align: center">Grams Protein per<br>Serving</td>
        <td style="text-align: center">Edit Entry</td>
        <td style="text-align: center">Delete Entry</td>
    </tr>
    
<%
for (FoodDiaryBean fdbean: eatlist) {
%>
        <tr>
            <td style="text-align: center; min-width: 8em">
                    <%= StringEscapeUtils.escapeHtml(fdbean.getEntryDate()) %>
            </td>            <td style="text-align: center; min-width: 8em">
                    <%= StringEscapeUtils.escapeHtml(fdbean.getMeal()) %>
            </td>            <td style="text-align: center; min-width: 8em">
                    <%= StringEscapeUtils.escapeHtml(fdbean.getFood()) %>
            </td>            <td style="text-align: center; min-width: 8em">
                    <%= StringEscapeUtils.escapeHtml(Double.toString(fdbean.getServings())) %>
            </td>            <td style="text-align: center; min-width: 8em">
                    <%= StringEscapeUtils.escapeHtml(Double.toString(fdbean.getCals())) %>
            </td>            <td style="text-align: center; min-width: 8em">
                    <%= StringEscapeUtils.escapeHtml(Double.toString(fdbean.getFat())) %>
            </td>            <td style="text-align: center; min-width: 8em">
                    <%= StringEscapeUtils.escapeHtml(Double.toString(fdbean.getSodium())) %>
            </td>            <td style="text-align: center; min-width: 8em">
                    <%= StringEscapeUtils.escapeHtml(Double.toString(fdbean.getCarbs())) %>
            </td>            <td style="text-align: center; min-width: 8em">
                    <%= StringEscapeUtils.escapeHtml(Double.toString(fdbean.getSugar())) %>
            </td>            <td style="text-align: center; min-width: 8em">
                    <%= StringEscapeUtils.escapeHtml(Double.toString(fdbean.getFiber())) %>
            </td>            <td style="text-align: center; min-width: 8em">
                    <%= StringEscapeUtils.escapeHtml(Double.toString(fdbean.getProtein())) %>
            </td>            <td style="text-align: center; min-width: 8em">
								<form method="post" action="editFoodDiaryPat.jsp">
								<input type="hidden" value=<%=fdbean.getEntryDate()%> name="entryDate">
								<input type="hidden" value=<%=fdbean.getMeal()%> name="meal">
								<input type="hidden" value='<%=fdbean.getFood()%>' name="food">
								<input type="hidden" value=<%=Double.toString(fdbean.getServings())%> name="servings">
								<input type="hidden" value=<%=Double.toString(fdbean.getCals())%> name="cals">
								<input type="hidden" value=<%=Double.toString(fdbean.getFat())%> name="fat">
								<input type="hidden" value=<%=Double.toString(fdbean.getSodium())%> name="sodium">
								<input type="hidden" value=<%=Double.toString(fdbean.getCarbs())%> name="carbs">
								<input type="hidden" value=<%=Double.toString(fdbean.getSugar())%> name="sugar">
								<input type="hidden" value=<%=Double.toString(fdbean.getFiber())%> name="fiber">
								<input type="hidden" value=<%=Double.toString(fdbean.getProtein())%> name="protein">
								<input type="hidden" name="sub">
								<input type="submit" value="Edit Entry">
								</form>
            </td>            <td style="text-align: center; min-width: 8em">
								<form method="post" action="delFoodDiaryPat.jsp">
								<input type="hidden" value=<%=fdbean.getEntryDate()%> name="entryDate">
								<input type="hidden" value=<%=fdbean.getMeal()%> name="meal">
								<input type="hidden" value='<%=fdbean.getFood()%>' name="food">
								<input type="hidden" value=<%=Double.toString(fdbean.getServings())%> name="servings">
								<input type="hidden" value=<%=Double.toString(fdbean.getCals())%> name="cals">
								<input type="hidden" value=<%=Double.toString(fdbean.getFat())%> name="fat">
								<input type="hidden" value=<%=Double.toString(fdbean.getSodium())%> name="sodium">
								<input type="hidden" value=<%=Double.toString(fdbean.getCarbs())%> name="carbs">
								<input type="hidden" value=<%=Double.toString(fdbean.getSugar())%> name="sugar">
								<input type="hidden" value=<%=Double.toString(fdbean.getFiber())%> name="fiber">
								<input type="hidden" value=<%=Double.toString(fdbean.getProtein())%> name="protein">
								<input type="submit" value="Delete Entry" onclick="return confirm('Are you sure you want to delete this entry?')">
								</form>
            </td>
        </tr>
        
<%
}
%>
    
</table>

	<table class="fTable" align="center" id="foodDiaryTotals">
    <tr>
        <th colspan="11">Patient Daily Totals</th>
    </tr>

    <tr class="subHeader">
        <td style="text-align: center"><br>Date</td>
        <td style="text-align: center">Calories</td>
        <td style="text-align: center">Grams Fat</td>
        <td style="text-align: center">mg Sodium</td>
        <td style="text-align: center">Grams Carbs</td>
        <td style="text-align: center">Grams Sugars</td>
        <td style="text-align: center">Grams Fiber</td>
        <td style="text-align: center">Grams Protein</td>
        <td style="text-align: center">Nutritionist's Suggestions</td>
    </tr>

<%

double dCal = 0;
double dFat = 0;
double dSod = 0;
double dCarbs = 0;
double dSugar = 0;
double dFiber = 0;
double dProt = 0;
List<String> dateCheck = new ArrayList<String>();
for(FoodDiaryBean superDate: eatlist) {
	
	String entDate = superDate.getEntryDate();
	
	DietSuggestionBean dsbn = null;
	
	try{
		dsbn = suggestionAction.getSuggestionBean(entDate);
	} catch(DBException e) {
		dsbn = new DietSuggestionBean();
	}
	
	//Check for duplicates
	if( dateCheck.size() == 0 || !(dateCheck.contains(entDate)) ){
		dateCheck.add(entDate);
	} else {
		dCal = 0;
		dFat = 0;
		dSod = 0;
		dCarbs = 0;
		dSugar = 0;
		dFiber = 0;
		dProt = 0;
		continue; //skips if already exists
	}
	
	for (FoodDiaryBean foodbean: eatlist) {
		if(foodbean.getEntryDate().equals(entDate)){
			double serve = foodbean.getServings();
			dCal += (double)foodbean.getCals() * serve;
			dFat += (double)foodbean.getFat() * serve;
			dSod += (double)foodbean.getSodium() * serve;
			dCarbs += (double)foodbean.getCarbs() * serve;
			dSugar += (double)foodbean.getSugar() * serve;
			dFiber += (double)foodbean.getFiber() * serve;
			dProt += (double)foodbean.getProtein() * serve;
		}
	}
%>	

	<tr>
					<td style="text-align: center; min-width: 8em">
	        <%= StringEscapeUtils.escapeHtml(entDate) %>				
	</td>			<td style="text-align: center; min-width: 8em">
            <%= StringEscapeUtils.escapeHtml(Double.toString(dCal)) %>
    </td>            <td style="text-align: center; min-width: 8em">
            <%= StringEscapeUtils.escapeHtml(Double.toString(dFat)) %>
    </td>            <td style="text-align: center; min-width: 8em">
            <%= StringEscapeUtils.escapeHtml(Double.toString(dSod)) %>
    </td>            <td style="text-align: center; min-width: 8em">
            <%= StringEscapeUtils.escapeHtml(Double.toString(dCarbs)) %>
    </td>            <td style="text-align: center; min-width: 8em">
            <%= StringEscapeUtils.escapeHtml(Double.toString(dSugar)) %>
    </td>            <td style="text-align: center; min-width: 8em">
            <%= StringEscapeUtils.escapeHtml(Double.toString(dFiber)) %>
    </td>            <td style="text-align: center; min-width: 8em">
            <%= StringEscapeUtils.escapeHtml(Double.toString(dProt)) %>
    </td>               

    <%
    	if(suggestionList.size() == 0) {
    		%> 
    		<td style="text-align: center; min-width: 8em">
            <%= StringEscapeUtils.escapeHtml("") %> </td>
    		
    		<%} 
    	else if(dsbn == null){
   			%> 
   		    <td style="text-align: center; min-width: 8em">
            <%= StringEscapeUtils.escapeHtml("") %> </td>
   			
	<% 
    	}
    	else {
    		%> 
			<td style="text-align: center; min-width: 8em; color:green">
            <%= StringEscapeUtils.escapeHtml(dsbn.getSuggestion()) %> </td>		
			
			<%
    		
    	}
	
	%>
            
	</tr>
	
<%
	
	//reset counter
	dCal = 0;
	dFat = 0;
	dSod = 0;
	dCarbs = 0;
	dSugar = 0;
	dFiber = 0;
	dProt = 0;
}

%>

	</table>

<%@include file="/footer.jsp"%>
