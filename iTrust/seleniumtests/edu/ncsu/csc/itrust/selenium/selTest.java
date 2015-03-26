package edu.ncsu.csc.itrust.selenium;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

public class selTest {
	

	public static void main(String[] args) {
		// Create a new instance of the html unit driver
		WebDriver driver = new HtmlUnitDriver();

		//Navigate to desired web page
		driver.get("https://www.google.com/");
	
		String actualTitle = driver.getTitle();
		
		System.out.println(actualTitle);

	}

}
