package edu.ncsu.csc.itrust.selenium;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import edu.ncsu.csc.itrust.enums.TransactionType;

import org.openqa.selenium.By;

import com.meterware.httpunit.WebConversation;
import com.meterware.httpunit.WebForm;
import com.meterware.httpunit.WebResponse;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class ViewAccessLogTest extends iTrustSeleniumTest {
	
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		gen.clearAllTables();
		gen.uap1();
		gen.patient2();
		gen.patient1();
		gen.patient4();
		gen.hcp0();
		gen.hcp3();
		gen.er4();
	}
	
    // private PageUnderTest page;
	public void testViewAccessLog1() throws Exception {

		gen.transactionLog();
		
		// hcp views phr of patient 2
		// login hcp
		HtmlUnitDriver driver = (HtmlUnitDriver)login("9000000000", "pw");
		assertEquals("iTrust - HCP Home", driver.getTitle());
		assertLogged(TransactionType.HOME_VIEW, 9000000000L, 0L, "");
		
		// click Edit PHR
		WebElement link = driver.findElement(By.linkText("PHR Information"));
		
        // URL assertion
        String linkLocatin = link.getAttribute("href");
        assertEquals("/iTrust/auth/hcp-uap/editPHR.jsp", linkLocatin);
        
        link.click();
        
        driver.findElement(By.name("UID_PATIENTID")).sendKeys("2");
        driver.findElement(By.xpath("//input[@value='2']")).submit();
        
		assertEquals(ADDRESS + "auth/hcp-uap/editPHR.jsp", driver.getCurrentUrl());
		assertLogged(TransactionType.PATIENT_HEALTH_INFORMATION_VIEW, 9000000000L, 2L, "");
        
		// login patient 2
		driver = (HtmlUnitDriver)login("2", "pw");
		assertEquals("iTrust - Patient Home", driver.getTitle());
		assertLogged(TransactionType.HOME_VIEW, 2L, 0L, "");
		
		// click on View Access Log
		driver.findElement(By.linkText("Access Log")).click();

		// Capture the table
		// Source from: http://stackoverflow.com/questions/14191935/how-to-find-specific-lines-in-a-table-using-selenium
	
		WebElement baseTable = driver.findElement(By.className("fTable"));
		List<WebElement> tableRows = baseTable.findElements(By.tagName("tr"));
		
		// Test if the first row contains the date format 
		// If there is, then we successfully capture the table
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date date = new java.util.Date();
		
		assertTrue(tableRows.get(1).getText().contains(dateFormat.format(date)));
		assertTrue(tableRows.get(1).getText().contains("Kelly Doctor"));
		assertTrue(tableRows.get(1).getText().contains("View personal health information"));
		
		// it is possible to parse table into a two-dimensional array but I am afraid I am too lazy to do that.
	}
	
	public void testViewAccessLog2() throws Exception {

		gen.transactionLog();
		
		HtmlUnitDriver driver = (HtmlUnitDriver)login("2", "pw");
		assertEquals("iTrust - Patient Home", driver.getTitle());
		assertLogged(TransactionType.HOME_VIEW, 2L, 0L, "");

		// click on View Access Log
		driver.findElement(By.linkText("Access Log")).click();
		
		WebElement startDate_box = driver.findElement(By.xpath("//*[@id=\"logMIDSelectionForm\"]/div/table/tbody/tr[2]/td[2]/input[1]"));
		startDate_box.sendKeys("06/22/2000");
		
		WebElement dueDate_box = driver.findElement(By.xpath("//*[@id=\"logMIDSelectionForm\"]/div/table/tbody/tr[2]/td[4]/input[1]"));
		dueDate_box.sendKeys("06/23/2000");
		
		// No need to test "exception", try "No data" this time instead
		
		WebElement submit_button = driver.findElement(By.xpath("//*[@id=\"logMIDSelectionForm\"]/div/input"));
		submit_button.submit();
		
		WebElement chart_generated = driver.findElementById("iTrustContent");
	
		assertTrue( chart_generated.getText().contains("No Data"));
		assertLogged(TransactionType.ACCESS_LOG_VIEW, 2L, 0L, "");
	}
	
	public void testViewAccessLog3() throws Exception {
		gen.transactionLog();
		
		HtmlUnitDriver driver = (HtmlUnitDriver)login("1", "pw");
		assertEquals("iTrust - Patient Home", driver.getTitle());
		assertLogged(TransactionType.HOME_VIEW, 1L, 0L, "");

		// click on View Access Log
		driver.findElement(By.linkText("Access Log")).click();
		
		WebElement chart_generated = driver.findElementById("iTrustContent");
	
		assertTrue( chart_generated.getText().contains("No Data"));
		assertLogged(TransactionType.ACCESS_LOG_VIEW, 1L, 0L, "");
	}
	
	public void testViewAccessLogYearFirstFormat() throws Exception {

		gen.transactionLog();
		
		HtmlUnitDriver driver = (HtmlUnitDriver)login("2", "pw");
		assertEquals("iTrust - Patient Home", driver.getTitle());
		assertLogged(TransactionType.HOME_VIEW, 2L, 0L, "");

		// click on View Access Log
		driver.findElement(By.linkText("Access Log")).click();
		
		
		// enable JAVASCRIPT
		// I am trying to avoid to use sendKeys since this command will
		// automatically validate the date form. 
		
		// Source: http://stackoverflow.com/questions/25583641/set-value-of-input-instead-of-sendkeys-selenium-webdriver-nodejs
		
		// After researching online, input value can be made through Javascript
		driver.setJavascriptEnabled(true);
		
		WebElement startDate_box = driver.findElement(By.xpath("//*[@id=\"logMIDSelectionForm\"]/div/table/tbody/tr[2]/td[2]/input[1]"));
		// startDate_box.sendKeys("2000/5/5");
		driver.executeScript("arguments[0].setAttribute('value', '" + "2000/5/5" +"')", startDate_box);
		
		WebElement dueDate_box = driver.findElement(By.xpath("//*[@id=\"logMIDSelectionForm\"]/div/table/tbody/tr[2]/td[4]/input[1]"));
		driver.executeScript("arguments[0].setAttribute('value', '" + "2020/5/5" +"')", dueDate_box);
		

		WebElement submit_button = driver.findElement(By.xpath("//*[@id=\"logMIDSelectionForm\"]/div/input"));
		submit_button.click();
		
		WebElement message = driver.findElement(By.xpath("//*[@id=\"iTrustContent\"]/h2"));
		
		
		// iTrust should prompt a exception because an invalid input has been made.
		assertTrue( message.getText().contains("Information not valid"));
	}
	
	public void testViewAccessLogDateOrder() throws Exception {

		gen.transactionLog();
		
		HtmlUnitDriver driver = (HtmlUnitDriver)login("2", "pw");
		assertEquals("iTrust - Patient Home", driver.getTitle());
		assertLogged(TransactionType.HOME_VIEW, 2L, 0L, "");

		// click on View Access Log
		driver.findElement(By.linkText("Access Log")).click();
		
		WebElement startDate_box = driver.findElement(By.xpath("//*[@id=\"logMIDSelectionForm\"]/div/table/tbody/tr[2]/td[2]/input[1]"));
		driver.setJavascriptEnabled(true);
		driver.executeScript("arguments[0].setAttribute('value', '" + "11/12/2015" +"')", startDate_box);
		
		WebElement dueDate_box = driver.findElement(By.xpath("//*[@id=\"logMIDSelectionForm\"]/div/table/tbody/tr[2]/td[4]/input[1]"));
		driver.executeScript("arguments[0].setAttribute('value', '" + "11/11/2015" +"')", dueDate_box);
		

		WebElement submit_button = driver.findElement(By.xpath("//*[@id=\"logMIDSelectionForm\"]/div/input"));
		submit_button.click();
		
		WebElement message = driver.findElement(By.xpath("//*[@id=\"iTrustContent\"]/h2"));
		
		
		// iTrust should prompt a exception because an invalid input has been made.
		assertTrue( message.getText().contains("Information not valid"));
	}
	
	public void testViewAccessLogByDate() throws Exception {

		gen.transactionLog();
		
		HtmlUnitDriver driver = (HtmlUnitDriver)login("2", "pw");
		assertEquals("iTrust - Patient Home", driver.getTitle());
		assertLogged(TransactionType.HOME_VIEW, 2L, 0L, "");

		// click on View Access Log
		driver.findElement(By.linkText("Access Log")).click();
		
		WebElement startDate_box = driver.findElement(By.xpath("//*[@id=\"logMIDSelectionForm\"]/div/table/tbody/tr[2]/td[2]/input[1]"));
		
		driver.setJavascriptEnabled(true);
		driver.executeScript("arguments[0].setAttribute('value', '" + "03/01/2008" +"')", startDate_box);
		
		WebElement dueDate_box = driver.findElement(By.xpath("//*[@id=\"logMIDSelectionForm\"]/div/table/tbody/tr[2]/td[4]/input[1]"));
		driver.executeScript("arguments[0].setAttribute('value', '" + "12/01/2008" +"')", dueDate_box);
		

		WebElement submit_button = driver.findElement(By.xpath("//*[@id=\"logMIDSelectionForm\"]/div/input"));
		submit_button.click();
		
		WebElement baseTable = driver.findElement(By.className("fTable"));
		List<WebElement> tableRows = baseTable.findElements(By.tagName("tr"));
		
		System.out.println(tableRows.get(1).getText());
		
		assertTrue(tableRows.get(1).getText().contains("No Data"));
		
		// Strange error: TypeError: Cannot find function addEventListener in object [object]
		// http://grokbase.com/t/gg/selenium-users/126ng1snzx/typeerror-cannot-find-function-addeventlistener-in-object-exception-using-htmlunitdriver
		// 7:31 PM Mar, 26 
	}
}
