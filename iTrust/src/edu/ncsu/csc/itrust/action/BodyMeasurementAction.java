package edu.ncsu.csc.itrust.action;

import java.text.ParseException;
import java.util.List;

import edu.ncsu.csc.itrust.beans.BodyMeasurementBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.BodyMeasurementDAO;
import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.exception.FormValidationException;

/**
 * @version 1.0 3/20/15
 * initial creation
 * 
 * @author Jay Patel
 * @author Weijia Li
 * @author Yuang Ni
 * @author Balaji Sundaram
 * 
 * This is the action file for the body measurement objects, currently its only tasks are to
 * call the DAO class to perform two functions adding a weight measurement entry by MID and then
 * retrieving all the entries based on MID.
 *
 */

public class BodyMeasurementAction {
	private BodyMeasurementDAO bodyMeasurementDAO;
	long patient;
	
	public BodyMeasurementAction(DAOFactory factory, long loggedInMID) {
		bodyMeasurementDAO = factory.getBodyMeasurementDAO();
		patient = loggedInMID;
	}
	
	/**
	 * When given an MID this function will return all the body measurement entries via the DAO file
	 * the list that comes out will be organized in DESC order
	 * @return
	 * @throws DBException
	 */
	public List<BodyMeasurementBean> getBodyMeasurement() throws DBException {
		return bodyMeasurementDAO.getBodyMeasurementByMID(patient);
	}
	
	/**
	 * When this function is called it will passed the BodyMeasurementBean to be parsed by the DAO file and inserted into the
	 * SQL table
	 * 
	 * ERROR CHECK ON ALL THE VARIABLES STILL NEEDS TO BE DONE
	 * as of now just accepts anything in double form input need to filter out negatives and nulls
	 * 
	 * @param bm BodyMeasurementBean of the entry to be added
	 * @return True or False depending on success
	 * @throws DBException
	 * @throws FormValidationException
	 */
	public boolean addBodyMeasurement(BodyMeasurementBean bm) throws DBException, FormValidationException {
		try {
			return bodyMeasurementDAO.addBodyMeasurement(bm);
		} catch (ParseException e) {
			return false;
		}
	}

}
