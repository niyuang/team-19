package edu.ncsu.csc.itrust.server;

import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.data.general.DefaultPieDataset;
/* Code for the HTTP Servlet that will return the Pie Chart as a PNG image
back to the browser after generating it using JFreeChart API */

public class BodyChartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public BodyChartServlet() {
		/* No code in the constructor for this demonstration */
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OutputStream out = response.getOutputStream(); /* Get the output stream from the response object */
        String key = request.getParameter("key");
        System.out.println(key);
        try {
            DefaultPieDataset myServletPieChart = new DefaultPieDataset();
            myServletPieChart.setValue("Maths", 74);
            myServletPieChart.setValue("Physics", 87);
            myServletPieChart.setValue("Chemistry", 62);
            myServletPieChart.setValue("Biology", 92);
            myServletPieChart.setValue("English", 51);        
            JFreeChart mychart = ChartFactory.createPieChart("Programming - Colored Pie Chart Example",myServletPieChart,true,true,false);  
            response.setContentType("image/png"); /* Set the HTTP Response Type */
            ChartUtilities.writeChartAsPNG(out, mychart, 400, 300);/* Write the data to the output stream */
        }
        catch (Exception e) {
            System.err.println(e.toString()); /* Throw exceptions to log files */
        }
        finally {
            out.close();/* Close the output stream */
        }
	}
}