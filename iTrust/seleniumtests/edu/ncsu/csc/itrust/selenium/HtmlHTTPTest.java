package edu.ncsu.csc.itrust.selenium;

import java.net.ConnectException;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

import edu.ncsu.csc.itrust.datagenerators.TestDataGenerator;
import junit.framework.TestCase;

public class HtmlHTTPTest extends TestCase {
	/*
	 * The URL for iTrust, change as needed
	 */
	/**ADDRESS*/
	public static final String ADDRESS = "http://localhost:8080/iTrust/";
	/**gen*/
	protected TestDataGenerator gen = new TestDataGenerator();

	public static void login(String username, String password, HtmlUnitDriver h) throws Exception {
			
		// HtmlUnitDriver driver = new HtmlUnitDriver();
		h.get(ADDRESS);
			
		/* https://github.com/ruthst/APT_FALL_14/blob/b115de2382785362bfbe857fcd631236cd79254a/Lab4/SeleniumLab/src/TempConversion.java */
	    WebElement usernameInput = h.findElementById("j_username");
	    WebElement passwordInput = h.findElementById("j_password");
	        
	    usernameInput.sendKeys(username);
	    passwordInput.sendKeys(password);
	        
	    passwordInput.submit();
	        
	    if(h.getTitle().equals("iTrust Login")) {
	        throw new IllegalArgumentException("Error logging in, user not in database?");
	    }

	} 
}
