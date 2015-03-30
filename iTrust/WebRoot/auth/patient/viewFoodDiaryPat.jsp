<%@page import="edu.ncsu.csc.itrust.validate.HealthRecordFormValidator"%>
<%@page import="edu.ncsu.csc.itrust.beans.forms.HealthRecordForm"%>
<%@page import="edu.ncsu.csc.itrust.action.GetPatientsMostRecentHeighWeight"%>
<%@page import="edu.ncsu.csc.itrust.beans.PatientBean"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewPatientAction"%>
<%@page import="edu.ncsu.csc.itrust.action.FoodDiaryAction"%> <% //  Fooddiaryaction %> 
<%@page import="edu.ncsu.csc.itrust.beans.FoodDiaryBean"%> <% //  Changed to EntryBean %> 
<%@page import="edu.ncsu.csc.itrust.action.DietSuggestionAction"%>  
<%@page import="edu.ncsu.csc.itrust.beans.DietSuggestionBean"%> 

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


<%	
	// similar construction as editMyDemograph
	ViewPatientAction vpa = new ViewPatientAction(prodDAO,
		loggedInMID.longValue(), "" + loggedInMID.longValue());
	PatientBean pb = vpa.getPatient(loggedInMID.toString());
	GetPatientsMostRecentHeighWeight gpmrhw = new GetPatientsMostRecentHeighWeight(prodDAO);
%>

<br>
<h2>Calculate Daily Calories and MacroNutrition:</h2><br>
<h4>Recommended calories are based on individual's gender, most recent height, most recent weight, and age.</h4>
<h5>Your information as following:</h5>
<br>

<form action="viewFoodDiaryPat.jsp" id="weightAndHeightForm" method="post">

<input type="hidden" name="sortBy" value="">

<div align="center">
<table class="fTable" align="center">
	<tbody>
	<tr class="subHeader">
		<td>Name:</td>
		<td>
		<%= StringEscapeUtils.escapeHtml(pb.getFirstName() + " " + pb.getLastName()) %>
		</td>
		<td>Gender:</td>
		<td>
		<%= StringEscapeUtils.escapeHtml(pb.getGender().toString()) %>
		</td>
		<td>The most recent Height:</td>
		<td><% 
			// -------- If the user has not submit their new value yet, their most recent value in database has to be in the text box.
			// -------- Else new values will be in the box
			if(request.getParameter("submit") != null) {
				%><input name="TheMostRecentHeight" value= <%= request.getParameter("TheMostRecentHeight") %>> <% 
			} else {
				%><input name="TheMostRecentHeight" value= <%= gpmrhw.getPatientHeight(loggedInMID) %>> <% 
			}
		%>			
		</td>
		<td>The most recent Weight:</td>
		<td>
			<% 
			if(request.getParameter("submit") != null) {
				%><input name="TheMostRecentWeight" value= <%= request.getParameter("TheMostRecentWeight") %>> <% 
			} else {
				%><input name="TheMostRecentWeight" value= <%= gpmrhw.getPatientWeight(loggedInMID) %>> <% 
			}
			%>	
		</td>
		<td>Age:</td>
		<td>
		<%= pb.getAge()%>
		</td>
	</tr>
</tbody></table>
<br>
<input type="submit" name="submit" value="Calculate My Recommanded Calories">

<%	
	
	if(request.getParameter("submit") != null) {
		// If value in weight and height have been changed,
		// those value has to be validated
	    // In order to validate the new value in a convinient way 
	    // We'll create HealthRecordForm which only contains weight and height.
	    // Making life easier! 
		HealthRecordForm weightHeight = new HealthRecordForm();
		String weight = request.getParameter("TheMostRecentWeight");
		String height = request.getParameter("TheMostRecentHeight");
		
		weightHeight.setHeight(height);
		weightHeight.setWeight(weight);
		
		HealthRecordFormValidator hf = new HealthRecordFormValidator();
		
		
		try{
			hf.validateHeightAndWeight(weightHeight);
		} catch (FormValidationException e) {	
			%>
			<div align=center>
				<span class="iTrustError"><%=StringEscapeUtils.escapeHtml(e.getMessage())%></span>
			</div>
			<%
		}
		
		// <-------------------------- Calculation part -------------------------->
		// Formula source: http://www.wikihow.com/Calculate-Your-Total-Daily-Calorie-Needs
		// For female: (4.7 x your height in inches) + (4.35 x your weight in pounds) - (4.7 x your age in years) + 655
		// For male: (12.7 x your height in inches) + (6.23 x your weight in pounds) - (6.8 x your age in years) + 66
		
		double BMR = 0.0;
		// we want the result to be in 0.0 decimal form
		DecimalFormat df = new DecimalFormat( "0.0");  
		if(pb.getGender().equals("Female")) {
			BMR = 4.7 * Double.parseDouble(height) + 4.35 * Double.parseDouble(weight) - (4.7 * pb.getAge()) + 655;
		} else {
			BMR = 12.7 * Double.parseDouble(height) + 6.23 * Double.parseDouble(weight) - (6.8 * pb.getAge()) + 66;
		}
		
		double recmdCarb = BMR * 0.6;
		double recmdSugar = BMR * 0.1;
		double recmdProtein = BMR * 0.225;
		double recmdFat = BMR * 0.075;
		
		// <-------------------------- Chart part -------------------------->
		%>
			<table class="fTable" align="center">
				<tbody>
				<tr>
        		<th colspan="11">Recommendation:</th>
    			</tr>
				<tr class="BMR">
					<td>BMR(Daily Calories needed):</td>
					<td>
						<%= df.format(BMR)%>
					</td>
				</tr>
				<tr class="Carb">
					<td>Carb needed(approximately 60% of BMR):</td>
					<td>
						<%= df.format(recmdCarb)%>
					</td>
				</tr>
				<tr class="Sugar">
					<td>Sugar needed(approximately 10% of BMR):</td>
					<td>
						<%= df.format(recmdSugar)%>
					</td>
				</tr>
				<tr class="Protein">
					<td>Protein needed(approximately 22.5% of BMR):</td>
					<td>
						<%= df.format(recmdProtein)%>
					</td>
				</tr>
				<tr class="Fat">
					<td>Fat needed(approximately 7.5% of BMR):</td>
					<td>
						<%= df.format(recmdFat)%>
					</td>
				</tr>
			</tbody></table>
		<%
		//  <-------------------------- Percentge graph part -------------------------->
		// From piazza: How to insert a percentage diagram:
	    // source: https://google-developers.appspot.com/chart/interactive/docs/quick_start
	    // 10:00 PM Mar 29, 2015
	} 
%> 


</div>
</form>


<%@include file="/footer.jsp"%>
