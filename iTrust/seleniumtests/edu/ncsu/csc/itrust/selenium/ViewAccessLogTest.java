package edu.ncsu.csc.itrust.selenium;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

public class ViewAccessLogTest extends HtmlHTTPTest {
	
    // private PageUnderTest page;
	public void testViewAccessLog1() throws Exception {
		
		HtmlUnitDriver driver = new HtmlUnitDriver();
		
		try {
			login("9000000000", "pw", driver);
		} catch (Exception e) {
			fail();
		}
        
        assertEquals("iTrust - HCP Home", driver.getTitle());
        
        // choose patient
        WebElement link = driver.findElement(By.linkText("PHR Information"));
        
        // process assertion
        String linkLocatin = link.getAttribute("href");
        assertEquals("/iTrust/auth/hcp-uap/editPHR.jsp", linkLocatin);
        
        link.click();
        driver.findElementById("searchBox").sendKeys("2");
        
        // type in 2
        // driver.findElementById("searchTarget").findElement(By.xpath("//input[@value='2' and @type='input']")).click();
        System.out.print(driver.getTitle());
        

	}
}
