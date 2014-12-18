package com.scottrade.datagovernance.util;

//"C:/RNANDAKUMAR/temp/IRA-Final.xlsx"
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.FileVisitResult;
import java.nio.file.FileVisitor;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.util.CollectionUtils;

import com.scottrade.datagovernance.domain.ApplicationMaster;
import com.scottrade.datagovernance.domain.DataEntity;
import com.scottrade.datagovernance.domain.HRDepartmentPositions;
import com.scottrade.datagovernance.domain.TempBusinessProcess;

public class ExcelWorker {

	//https://myinsider.scottrade.com/portal/page/portal/Scottrade%20Intranet/Departments/Privacy%20and%20Data%20Governance/Data%20Governance/Business%20Process%20Inventory%20Project
	// Insider Path's
	static final String pathForDEfile = "//stlfs1/homedirs/Privacy and Data Governance/Data Governance/Current/Data Ownership/Business Process Inventory - Insider Page/Data Entity Master List.xlsx";
	static final String pathForAppMstr = "//stlfs1/homedirs/Privacy and Data Governance/Data Governance/Current/Data Ownership/Business Process Inventory - Insider Page/Master Application List.xlsx";
	static final String pathForHRPosnTitles = "//stlfs1/homedirs/Privacy and Data Governance/Data Governance/Current/Data Ownership/Business Process Inventory - Insider Page/HR Position Master List.xlsx";
	
	// Temporary local path's
//	static final String pathForDEfile = "C:/RNANDAKUMAR/WIP/published_templates_as_of_09042014/Data Entity Master List.xlsx";
//	static final String pathForAppMstr = "C:/RNANDAKUMAR/WIP/published_templates_as_of_09042014/Master Application List.xlsx";
//	static final String pathForHRPosnTitles = "C:/RNANDAKUMAR/WIP/published_templates_as_of_09042014/HR Position Master List.xlsx";

	// Local lists for processing.
	private static Map<String, ApplicationMaster> appMstrMap = new HashMap<String, ApplicationMaster>();
	private static List<HRDepartmentPositions> hrPositionList = new ArrayList<HRDepartmentPositions>();
	private static Map<String, DataEntity> dataEntityMap = null;

	// Constants
	private static String EMPTY_STRING = "";

	// JDBC driver name and database URL
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost:3306/data_governance";

	// Database credentials
	static final String USER = "dg_user";
	static final String PASS = "dg_4pp_u53r";

	// Counters
	static int iTotalRecords = 0;
	static int iTotalErrorRecords = 0;

	/**
	 * Method to populate the Data Entities, Applications and HR Department Positions needed for validation and processing.
	 */
	private static void populateLists() {
		try {
			loadDataEntities();
			loadApplications();
			loadHRPositions();
			
			System.out.println("************************************");
			System.out.println(dataEntityMap.size() + " Data Entities loaded.");
			System.out.println(appMstrMap.size() + " Applications loaded.");
			System.out.println(hrPositionList.size() + " HR Department Positions loaded.");
			System.out.println("************************************");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws IOException {
		// writeXLSFile();
		// readXLSFile();
		// writeXLSXFile();
		// readXLSXFile();

		populateLists();
//		readDGbpTemplateFile("S:\\Privacy And Data Governance\\Data Governance\\Current\\Data Ownership\\Applications\\Business Process\\3. Completed Business Process Inventories\\Complete - Business Strategy\\Client Fulfillment & Imp - Final.xlsx");

		// Clean up Errors and Inserts files.
		File fErrors  = new File("C://RNANDAKUMAR//WIP//inserts//bpErrors.txt");
		File fInserts = new File("C://RNANDAKUMAR//WIP//inserts//bpInserts.txt");

		if ( fErrors.exists() ) {
			fErrors.delete();
		}

		if ( fInserts.exists() ) {
			fInserts.delete();
		}

	    String ROOT = "S:\\Privacy And Data Governance\\Data Governance\\Current\\Data Ownership\\Applications\\Business Process\\3. Completed Business Process Inventories\\";
	    FileVisitor<Path> fileProcessor = new ProcessFile();
	    Files.walkFileTree(Paths.get(ROOT), fileProcessor);

	    System.out.println("Total Records: " + iTotalRecords + " | Total Error Records: " + iTotalErrorRecords);
	}

	/**
	 * Process Files from directory.
	 * @author rnandakumar
	 */
	private static final class ProcessFile extends SimpleFileVisitor<Path> {
		 // First (minor) speed up. Compile regular expression pattern only one time.
        private Pattern finalFileNamePattern = Pattern.compile("^(.* - final.xlsx)", Pattern.CASE_INSENSITIVE);

		@Override
		public FileVisitResult visitFile ( Path aFile, BasicFileAttributes aAttrs ) throws IOException {
			boolean finalFileNameMatch = finalFileNamePattern.matcher(aFile.toString()).matches();

			if ( finalFileNameMatch && !aFile.getFileName().toString().startsWith("~$")) {
				try ( PrintWriter pwOut = new PrintWriter ( new BufferedWriter ( new FileWriter ("C://RNANDAKUMAR//WIP//inserts//bpErrors.txt", true) ) ) ) {
					pwOut.println(aFile.toString().replace("\\", "//"));
					System.out.println(aFile.toString().replace("\\", "//"));
				}
				catch (IOException e) {
				    //exception handling left as an exercise for the reader
				}

				try {
					readDGbpTemplateFile(aFile.toString().replace("\\", "//"));
				}
				catch (FileNotFoundException fnfe) {
					System.out.println("File NOT FOUND!!  Check Directory for temporary files!");
				}
			}

			return (finalFileNameMatch && !aFile.getFileName().toString().startsWith("~$")) ? FileVisitResult.CONTINUE : FileVisitResult.SKIP_SUBTREE;
	    }
	}

	/**
	 * Read the Data Governance Business Process template file and process the rows accordingly.
	 * The data in these templates will be loaded into the temp_busprocess_data table in the MySQL database.
	 * 
	 * @throws IOException
	 */
	private static void readDGbpTemplateFile(String fileName) throws IOException {
//		InputStream ExcelFileToRead = new FileInputStream("C:/RNANDAKUMAR/temp/IRA-Final.xlsx");
		InputStream ExcelFileToRead = new FileInputStream(fileName);

		String strBPdeptTeamNm   = EMPTY_STRING;
		String strBPONm          = EMPTY_STRING;
		String strBPOTitle       = EMPTY_STRING;
		String strBPOdeptTeamNm  = EMPTY_STRING;
		String strBPDesc         = EMPTY_STRING;
		String strBPSignOffDate  = EMPTY_STRING;

		String strSpName         = EMPTY_STRING;  // Sub Process Name column
		String strSpApplication  = EMPTY_STRING;  // Applications column
		String strSpDataEntity   = EMPTY_STRING;  // Data Entities column
		String strSpParticipants = EMPTY_STRING;  // Participants column
		String strSpCurrAccess   = EMPTY_STRING;  // Current Access column
		String strSpReqdAccess   = EMPTY_STRING;  // Required Access column
		String strSpNotes        = EMPTY_STRING;  // Notes

		String strExitRowKeyTxt  = "endDGxyz";
		List<TempBusinessProcess> tmpBPlist = null;
		List<Integer> workSheetNumsToRead = null;

		XSSFWorkbook wb = new XSSFWorkbook(ExcelFileToRead);
		
		// Loop through the Sheets in the Workbook to catch all "Business Process Summary".
		for ( int iSheetNum = 0; iSheetNum < wb.getNumberOfSheets(); iSheetNum++ ) {
			if ( wb.getSheetName(iSheetNum).contains("Business Process Summary") ) {
				if (CollectionUtils.isEmpty(workSheetNumsToRead)) {
					workSheetNumsToRead = new ArrayList<Integer>();
				}

				workSheetNumsToRead.add(iSheetNum);
			}
		}

		if (!CollectionUtils.isEmpty(workSheetNumsToRead) ) {
			for ( int iSheet : workSheetNumsToRead ) {
				XSSFSheet sheet = wb.getSheetAt(iSheet);

				System.out.println(sheet.getLastRowNum());

				/* BEGIN - Determine start and end rows for Business Sub Processes */
				int iStartRowNum = 0;
				int iEndRowNum = sheet.getLastRowNum() + 1;
				boolean boolBreakRowLoop     = true;
				StringBuilder sbError        = null;

				for(Row currRow : sheet) {
					iTotalRecords++;
					if ( boolBreakRowLoop ) {
	
						// If the cell is missing from the file, generate a blank one
						// (Works by specifying a MissingCellPolicy)
		
						if ( iStartRowNum == 0 ) {
							String strBpLabel = StringUtils.trimToEmpty(currRow.getCell(1, Row.CREATE_NULL_AS_BLANK).toString());
							String strBpValue = StringUtils.trimToEmpty(currRow.getCell(2, Row.CREATE_NULL_AS_BLANK).toString());
		
							switch (strBpLabel) {
								case "Business Process (Department/Team)":
									strBPdeptTeamNm = strBpValue;
									break;
								case "Business Process Owner (Name)":
									strBPONm = strBpValue;
									break;
								case "Business Process Owner (Title)":
									strBPOTitle = strBpValue;
									break;
								case "Business Process Owner (Dept/Team)":
									strBPOdeptTeamNm = strBpValue;
									break;
								case "Business Process Description":
									strBPDesc = strBpValue;
									break;
								case "Signoff Date":
									strBPSignOffDate = strBpValue;
									break;
								case "Sign off Date":
									strBPSignOffDate = strBpValue;
									break;
								case "Sign Off Date":
									strBPSignOffDate = strBpValue;
									break;
								case "SignOff Date":
									strBPSignOffDate = strBpValue;
									break;
								case "Sub Process Name":
									iStartRowNum = currRow.getRowNum() + 1;
									break;
								default:
									break;
							}
						}
						else if (	iStartRowNum > 0 
								 && currRow.getRowNum() >= iStartRowNum
								 && currRow.getRowNum() <= iEndRowNum
								) {

							strSpName         = StringUtils.trimToEmpty(currRow.getCell(1, Row.CREATE_NULL_AS_BLANK).toString()); // Sub Process Name
							strSpApplication  = StringUtils.trimToEmpty(currRow.getCell(2, Row.CREATE_NULL_AS_BLANK).toString()); // Application
							strSpParticipants = StringUtils.trimToEmpty(currRow.getCell(3, Row.CREATE_NULL_AS_BLANK).toString()); // Participants
							strSpDataEntity   = StringUtils.trimToEmpty(currRow.getCell(4, Row.CREATE_NULL_AS_BLANK).toString()); // Data Entities
							strSpCurrAccess   = cleanCRUDEntries(currRow.getCell(5, Row.CREATE_NULL_AS_BLANK).toString());        // Current Access
							strSpReqdAccess   = cleanCRUDEntries(currRow.getCell(6, Row.CREATE_NULL_AS_BLANK).toString());        // Required Access
							strSpNotes        = cleanNewLines(currRow.getCell(7, Row.CREATE_NULL_AS_BLANK).toString());           // Notes

							// If a blank cell is encountered on the sub process name column, the row looping terminates.
//							if (	StringUtils.trimToEmpty(strSpName).length() == 0
//								 || strSpName.equals(strExitRowKeyTxt) ) {
//								iEndRowNum = currRow.getRowNum() - 1;
//								boolBreakRowLoop = false;
//							}

							// If a Sub Process Name is not found, continue to next iteration.
							if ( StringUtils.trimToEmpty(strSpName).length() == 0 ) {
								// If the SP Name row contains the pre-determined Exit Row text, then set break row loop after. 
								if ( strSpName.equals(strExitRowKeyTxt) ) {
									boolBreakRowLoop = false;
								}
								else {
									continue;
								}
							}
		
							TempBusinessProcess tmpBp = new TempBusinessProcess();
							if ( null == sbError ) {
								sbError = new StringBuilder();
							}
	
							if ( null == tmpBPlist ) {
								tmpBPlist = new ArrayList<TempBusinessProcess>();
							}
	
							tmpBp.setBpFilePath(fileName);
							tmpBp.setBpDeptTeamNm(strBPdeptTeamNm);
							tmpBp.setBpBPONm(strBPONm);
							tmpBp.setBpBPOTitle(strBPOTitle);
							tmpBp.setBpBPOdeptTeamNm(strBPOdeptTeamNm);
							tmpBp.setBpDesc(
								cleanNewLines(strBPDesc));
							tmpBp.setBpSignOffDate(strBPSignOffDate);
							tmpBp.setBpSpNm(strSpName);
							tmpBp.setBpSpApplNm(
								parseVerifyApplNm(
									strSpApplication, 
									((XSSFCell) currRow.getCell(2, Row.CREATE_NULL_AS_BLANK)).getReference(),
									sbError
								)
							);
							tmpBp.setBpSpParticipantMap(
								parseVerifyParticipants(
									strSpParticipants,
									((XSSFCell) currRow.getCell(3, Row.CREATE_NULL_AS_BLANK)).getReference(),
									sbError
								)
							);
							tmpBp.setBpSpDataEntityMap(
								parseVerifyDataEntities(
									strSpDataEntity,
									((XSSFCell) currRow.getCell(4, Row.CREATE_NULL_AS_BLANK)).getReference(),
									sbError
								)
							);
	
							// Decode CRUD and separate to flags
							tmpBp.setBpSpCurrCrudCreate(checkCRUDEntries(strSpCurrAccess, "C"));
							tmpBp.setBpSpCurrCrudRead  (checkCRUDEntries(strSpCurrAccess, "R"));
							tmpBp.setBpSpCurrCrudUpdate(checkCRUDEntries(strSpCurrAccess, "U"));
							tmpBp.setBpSpCurrCrudDelete(checkCRUDEntries(strSpCurrAccess, "D"));
							tmpBp.setBpSpCurrCrudVal(cleanCRUDEntries(strSpCurrAccess));
							// Decode CRUD and separate to flags
							tmpBp.setBpSpReqdCrudCreate(checkCRUDEntries(strSpReqdAccess, "C"));
							tmpBp.setBpSpReqdCrudRead  (checkCRUDEntries(strSpReqdAccess, "R"));
							tmpBp.setBpSpReqdCrudUpdate(checkCRUDEntries(strSpReqdAccess, "U"));
							tmpBp.setBpSpReqdCrudDelete(checkCRUDEntries(strSpReqdAccess, "D"));
							tmpBp.setBpSpReqdCrudVal(cleanCRUDEntries(strSpReqdAccess));
							tmpBp.setBpSpNotes(strSpNotes);
		
							tmpBPlist.add(tmpBp);
//							System.out.println(currRow.getRowNum() + " | " + strSpName + " | " + strSpApplication + " | " + strSpDataEntity + " | " + strSpParticipants + " | " + strSpCurrAccess + " | " + strSpReqdAccess);
						}
					}
		
					if ( null != sbError && StringUtils.trimToEmpty(sbError.toString()).length() > 0 ) {
						try ( PrintWriter pwOut = new PrintWriter ( new BufferedWriter ( new FileWriter ("C://RNANDAKUMAR//WIP//inserts//bpErrors.txt", true) ) ) ) {
							pwOut.println(sbError.toString());
							sbError = null;
						}
						catch (IOException e) {
						    //exception handling left as an exercise for the reader
						}
		
						iTotalErrorRecords++;
					}
				}

//				System.out.println("iStartRowNum: " + iStartRowNum + " | iEndRowNum: " + iEndRowNum);
//				System.out.println(strBPdeptTeamNm + "|" + strBPONm + "|" + strBPOTitle + "|" + strBPOdeptTeamNm + "|" + strBPDesc + "|" + strBPSignOffDate);
//				System.out.println(">>>>>>>>>>>>>>>>>>>>>>>> List COUNT: " + tmpBPlist.size());
	
				generateInsertStatements(tmpBPlist, fileName);
			}
		}
		/* END   - Determine start and end rows for Business Sub Processes */
	}

	/**
	 * Write List contents to text file. In the needed INSERT format for SQL. 
	 */
	private static void generateInsertStatements ( List<TempBusinessProcess> bpList, String processedFileNamePath ) {
		if ( null != bpList && bpList.size() > 0 ) {
			String insertPrefix =
				"INSERT INTO temp_busprocess_data ("
					+   " as_of_da"
					+	",bp_dept_team_nm"
					+	",bp_bpo_nm"
					+	",bp_bpo_title"
					+	",bp_bpo_dept_team_nm"
					+	",bp_desc"
					+	",bp_signoff_date"
					+	",bp_sp_nm"
					+	",bp_sp_appl_nm"
					+	",bp_sp_participant_posn_title"
					+	",bp_sp_participant_job_title"
					+	",bp_sp_dataentity"
					+	",bp_sp_dataentity_class"
					+	",bp_sp_curr_crud_val"
					+	",bp_sp_curr_crud_create"
					+	",bp_sp_curr_crud_read"
					+	",bp_sp_curr_crud_update"
					+	",bp_sp_curr_crud_delete"
					+	",bp_sp_curr_reqd_val"
					+	",bp_sp_curr_reqd_create"
					+	",bp_sp_curr_reqd_read"
					+	",bp_sp_curr_reqd_update"
					+	",bp_sp_curr_reqd_delete"
					+   ",bp_sp_notes"
					+	",bp_file_path"
					+" ) VALUES ( CURDATE(), ";

			String insertSuffix = ");";

			for ( TempBusinessProcess tmpBp : bpList ) {
				if ( null != tmpBp.getBpSpDataEntityMap() && tmpBp.getBpSpDataEntityMap().size() > 0 ) {
					for ( Map.Entry<String, String> dataEntityEntry : tmpBp.getBpSpDataEntityMap().entrySet() ) {
						if ( null != tmpBp.getBpSpParticipantMap() && tmpBp.getBpSpParticipantMap().size() > 0 ) {
							for (Map.Entry<String, String> participantEntry : tmpBp.getBpSpParticipantMap().entrySet())
							{
								StringBuilder sb = new StringBuilder();
								  sb.append(insertPrefix)
								  	.append("\"")
									.append(tmpBp.getBpDeptTeamNm())
									.append("\",\"")
									.append(tmpBp.getBpBPONm())
									.append("\",\"")
									.append(tmpBp.getBpBPOTitle())
									.append("\",\"")
									.append(tmpBp.getBpBPOdeptTeamNm())
									.append("\",\"")
									.append(tmpBp.getBpDesc())
									.append("\",\"")
									.append(tmpBp.getBpSignOffDate())
									.append("\",\"")
									.append(tmpBp.getBpSpNm())
									.append("\",\"")
									.append(tmpBp.getBpSpApplNm())
									.append("\",\"")
									.append(participantEntry.getKey())   // position title
									.append("\",\"")
									.append(participantEntry.getValue()) // job title
									.append("\",\"")
									.append(dataEntityEntry.getKey())    // data entity name
									.append("\",\"")
									.append(dataEntityEntry.getValue())  // classification - internal or external
									.append("\",\"")
									.append(tmpBp.getBpSpCurrCrudVal())
									.append("\",")
									.append(tmpBp.getBpSpCurrCrudCreate())
									.append(",")
									.append(tmpBp.getBpSpCurrCrudRead())
									.append(",")
									.append(tmpBp.getBpSpCurrCrudUpdate())
									.append(",")
									.append(tmpBp.getBpSpCurrCrudDelete())
									.append(",\"")
									.append(tmpBp.getBpSpReqdCrudVal())
									.append("\",")
									.append(tmpBp.getBpSpReqdCrudCreate())
									.append(",")
									.append(tmpBp.getBpSpReqdCrudRead())
									.append(",")
									.append(tmpBp.getBpSpReqdCrudUpdate())
									.append(",")
									.append(tmpBp.getBpSpReqdCrudDelete())
									.append(",\"")
									.append(tmpBp.getBpSpNotes())
									.append("\",\"")
									.append(processedFileNamePath)
									.append("\"")
									.append(insertSuffix);
								;

								try ( PrintWriter pwOut = new PrintWriter ( new BufferedWriter ( new FileWriter ("C://RNANDAKUMAR//WIP//inserts//bpInserts.txt", true) ) ) ) {
									pwOut.println(sb.toString());
								}
								catch (IOException e) {
								    //exception handling left as an exercise for the reader
								}
							}
						}
					}
				}
			}
		}
	}
	
	/**
	 * Clean CRUD strings
	 */
	private static String cleanCRUDEntries ( String inStr ) {
		// replace any character occurrence of a ", or a " " with an "" string.
		return StringUtils.trimToEmpty(inStr.replaceAll("(, )( )", EMPTY_STRING));
	}

	/**
	 * Check CRUD strings
	 */
	private static int checkCRUDEntries ( String inStr, String strCheck ) {
		return inStr.indexOf(strCheck) >= 0 ? 1 : 0;
	}

	/**
	 * Clean string off of newlines (\r, \n)
	 */
	private static String cleanNewLines ( String inStr ) {
		inStr = StringUtils.trimToEmpty(inStr);
//		inStr = StringUtils.removePattern(inStr, "\\n");
//		inStr = StringUtils.removePattern(inStr, "\\r");

		/* "\\s{2,}", ""  TRY THIS TO REPLACE ALL newlines at once using String.replaceAll() */
		inStr = inStr.replaceAll("(\\r|\\n|\\r\\n)+", ". ").replaceAll("(  )", " ");
		// Remove any double quotes as well.
		inStr = inStr.replace("\"",  "");
		return inStr;
	}

	/**
	 * Validate Applications list.
	 */
	private static String parseVerifyApplNm ( String inStr, String strCellRef, StringBuilder sbErrorIn ) {
		inStr = cleanNewLines(inStr);

		// Spit out to Validation - Exception report.
		if ( !appMstrMap.containsKey(inStr)) {
			sbErrorIn.append("|" + strCellRef + ">" + inStr);
			return "ERR-" + inStr;
		}
		else {
			return inStr;
		}
	}

	/**
	 * Clean and parse the Data Entity strings and build them into Map<String, String>.  The KEY being the Entity name, and VALUE being the classification, internal or external.
	 * @param str - the input string
	 * @param str - the cell reference to log the error string.
	 * @return
	 */
	private static Map<String, String> parseVerifyDataEntities ( String inStr, String strCellRef, StringBuilder sbErrorIn ) {
		inStr = StringUtils.trimToEmpty(inStr).replaceAll("(, )", ",");

		// Fetch, tokenize and validate against Data Entities list.
		StringTokenizer stDE = new StringTokenizer(inStr, ",");
		Map<String, String> tmpDEmap = null;
		while (stDE.hasMoreElements()) {

			String deEntered = StringUtils.trimToEmpty((String) stDE.nextElement());
			boolean boolDEclassification = (deEntered.startsWith("E-") || deEntered.startsWith("e-"));
			String deClassification = boolDEclassification ? "External" : "Internal";

			if ( boolDEclassification ) {
				deEntered = deEntered.substring(2);
			}

			if ( dataEntityMap.containsKey(deEntered)) {
				if ( null == tmpDEmap ) {
					tmpDEmap = new HashMap<String, String>();
				}

				tmpDEmap.put(deEntered, deClassification);
			}
			// Spit out to Validation - Exception report.
			else {
				sbErrorIn.append("|" + strCellRef + ">" + (boolDEclassification ? "E-" + deEntered : deEntered));
			}
		}

		return tmpDEmap;
	}

	/**
	 * Clean and parse the Participants' strings and build them into Map<String, String>.
	 * @param str - the input string
	 * @param str - the cell reference to log the error string.
	 * @return
	 */
	private static Map<String, String> parseVerifyParticipants (String inStr, String strCellRef, StringBuilder sbErrorIn ) {

		inStr = StringUtils.trimToEmpty(inStr).replaceAll("(, )", ",");

		// Fetch, tokenize and validate against participants list.
		Map<String, String> tmpParticipMap = null;
		StringTokenizer stParticipEntered = new StringTokenizer(inStr, ",");
		while (stParticipEntered.hasMoreElements()) {

			String particip = (String) stParticipEntered.nextElement();
			boolean matchFound = false;

			for ( HRDepartmentPositions hrDeptPos : hrPositionList ) {
				if ( hrDeptPos.getJobPositionTitle().equals(particip)) {
					// if match found, break.
					matchFound = true;

					if ( null == tmpParticipMap ) {
						tmpParticipMap = new HashMap<String, String>();
					}

					tmpParticipMap.put(hrDeptPos.getJobPositionTitle(), hrDeptPos.getJobTitle());
					break;
				}
			}

			// Spit out to Validation - Exception report.
			if (!matchFound) {
				sbErrorIn.append("|" + strCellRef + ">" + particip);
			}
		}

		return tmpParticipMap;
	}
	
	/**
	 * Load Published Data Entities from The Insider.  This populates the static list on this Worker class.
	 */
	private static void loadDataEntities () throws IOException {
		// load file stream
		InputStream deStream = new FileInputStream(pathForDEfile);
		XSSFWorkbook deWB = new XSSFWorkbook(deStream);
		XSSFSheet deWS = deWB.getSheetAt(0);

		String entityNm  = EMPTY_STRING;
		String entityDsc = EMPTY_STRING;
		String entityEx  = EMPTY_STRING;
		dataEntityMap = new HashMap<String, DataEntity>();

		for ( Row deRow : deWS) {
			entityNm  = StringUtils.trimToEmpty(deRow.getCell(0, Row.CREATE_NULL_AS_BLANK).toString());  
			entityDsc = StringUtils.trimToEmpty(deRow.getCell(1, Row.CREATE_NULL_AS_BLANK).toString());
			entityEx  = StringUtils.trimToEmpty(deRow.getCell(2, Row.CREATE_NULL_AS_BLANK).toString());
			
			if (!entityNm.equals(EMPTY_STRING)) {
				dataEntityMap.put(entityNm, new DataEntity(entityNm, entityDsc, entityEx));
			}
			else {
				break;
			}
		}
		
		dataEntityMap.remove("Entity");
	}

	/**
	 * Load published Applications from The Insider.  This populates the static list on this Worker class.
	 */
	private static void loadApplications () throws IOException {
		// load application file stream
		InputStream applStream = new FileInputStream(pathForAppMstr);
		XSSFWorkbook applWB = new XSSFWorkbook(applStream);
		XSSFSheet applWS = applWB.getSheetAt(0);
		
		String applNm = EMPTY_STRING;
		String applDsc = EMPTY_STRING;
		String applDOscope = EMPTY_STRING;
		String applRBACscope = EMPTY_STRING;
		appMstrMap = new HashMap<String, ApplicationMaster>();
		
		for ( Row applRow : applWS ) {
//			if ( applRow.getRowNum() > 1 ) {
				applNm = StringUtils.trimToEmpty(applRow.getCell(0, Row.CREATE_NULL_AS_BLANK).toString());
				applDsc = StringUtils.trimToEmpty(applRow.getCell(1, Row.CREATE_NULL_AS_BLANK).toString());
				applDOscope = StringUtils.trimToEmpty(applRow.getCell(2, Row.CREATE_NULL_AS_BLANK).toString());
				applRBACscope = StringUtils.trimToEmpty(applRow.getCell(3, Row.CREATE_NULL_AS_BLANK).toString());

				if ( !applNm.equals(EMPTY_STRING)) {
					appMstrMap.put(applNm, new ApplicationMaster (applNm, applDsc, applDOscope, applRBACscope));
				}
				else {
					break;
				}
//			}
		}
	}

	/**
	 * Load published HR-Department-Position titles list from The Insider.  This populates the static list on this Worker class.
	 */
	private static void loadHRPositions () throws IOException {
		// load HR department, position titles from the stream.
		InputStream hrDeptPosnStream = new FileInputStream(pathForHRPosnTitles);
		XSSFWorkbook hrDeptPosnWB = new XSSFWorkbook(hrDeptPosnStream);
		XSSFSheet hrDeptPosnWS = hrDeptPosnWB.getSheetAt(0);
		
		String lob         = EMPTY_STRING;
		String division    = EMPTY_STRING;
		String dept        = EMPTY_STRING;
		String payrollDept = EMPTY_STRING;
		String posnTitle   = EMPTY_STRING;
		String jobTitle    = EMPTY_STRING;
		hrPositionList     = new ArrayList<HRDepartmentPositions>();

		for ( Row hrRow : hrDeptPosnWS ) {
			lob         = StringUtils.trimToEmpty(hrRow.getCell(0, Row.CREATE_NULL_AS_BLANK).toString());
			division    = StringUtils.trimToEmpty(hrRow.getCell(1, Row.CREATE_NULL_AS_BLANK).toString());
			dept        = StringUtils.trimToEmpty(hrRow.getCell(2, Row.CREATE_NULL_AS_BLANK).toString());
			payrollDept = StringUtils.trimToEmpty(hrRow.getCell(3, Row.CREATE_NULL_AS_BLANK).toString());
			posnTitle   = StringUtils.trimToEmpty(hrRow.getCell(4, Row.CREATE_NULL_AS_BLANK).toString());
			jobTitle    = StringUtils.trimToEmpty(hrRow.getCell(5, Row.CREATE_NULL_AS_BLANK).toString());

			if ( !lob.equals(EMPTY_STRING)) {
				hrPositionList.add(new HRDepartmentPositions(lob, division, dept, payrollDept, posnTitle, jobTitle));
			}
			else {
				break;
			}
		}
	}

	/**
	 * Commit to database implementation.
	 */
	private void writeToDb() {
		Connection conn = null;
		Statement stmt = null;
		try {
			// STEP 2: Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");

			// STEP 3: Open a connection
			System.out.println("Connecting to a selected database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			conn.setAutoCommit(false);
			System.out.println("Connected database successfully...");

			// STEP 4: Execute a query
			System.out.println("Inserting records into the table...");
			stmt = conn.createStatement();

			String sql =
				"INSERT INTO temp_busprocess_data "
					+ "(bus_process_nm"
					+ ",bus_process_owner_nm"
					+ ",bus_process_owner_title"
					+ ",bus_process_owner_dept_team_nm"
					+ ",bus_process_desc"
					+ ",bus_process_sign_off_date"
					+ ",bp_sub_process_nm"
					+ ",bp_sub_process_appl_nm"
					+ ",bp_sub_process_participant"
					+ ",bp_sub_process_data_entity"
					+ ",bp_sub_process_current_crud"
					+ ",bp_sub_process_reqd_crud )"
					+ " VALUES ("
					+ ");";

			stmt.executeUpdate(sql);
			System.out.println("Inserted records into the table...");
		} catch (SQLException se) {
			// Handle errors for JDBC
			se.printStackTrace();
		} catch (Exception e) {
			// Handle errors for Class.forName
			e.printStackTrace();
		} finally {
			// finally block used to close resources
			try {
				if (stmt != null)
					conn.close();
			} catch (SQLException se) {
			}// do nothing
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}// end finally try
		}// end try
		System.out.println("Goodbye!");
	}

	public static void readXLSFile() throws IOException {
		InputStream ExcelFileToRead = new FileInputStream(
				"C:/RNANDAKUMAR/temp/IRA-Final_.xlsx");
		HSSFWorkbook wb = new HSSFWorkbook(ExcelFileToRead);

		HSSFSheet sheet = wb.getSheetAt(1);
		HSSFRow row;
		HSSFCell cell;

		Iterator rows = sheet.rowIterator();

		while (rows.hasNext()) {
			row = (HSSFRow) rows.next();
			Iterator cells = row.cellIterator();

			while (cells.hasNext()) {
				cell = (HSSFCell) cells.next();

				if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					System.out.print(cell.getStringCellValue() + " ");
				} else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
					System.out.print(cell.getNumericCellValue() + " ");
				} else {
					// You can handle Boolean, Formula, Errors
				}
			}

			System.out.println();
		}
	}

	public static void writeXLSFile() throws IOException {
		String excelFileName = "C:/Test.xls";// name of excel file
		String sheetName = "Sheet1";// name of sheet

		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet(sheetName);

		// iterating r number of rows
		for (int r = 0; r < 5; r++) {
			HSSFRow row = sheet.createRow(r);

			// iterating c number of columns
			for (int c = 0; c < 5; c++) {
				HSSFCell cell = row.createCell(c);

				cell.setCellValue("Cell " + r + " " + c);
			}
		}

		FileOutputStream fileOut = new FileOutputStream(excelFileName);

		// write this workbook to an Outputstream.
		wb.write(fileOut);
		fileOut.flush();
		fileOut.close();
	}

	public static void readXLSXFile() throws IOException {
		InputStream ExcelFileToRead = new FileInputStream(
				"C:/RNANDAKUMAR/temp/IRA-Final.xlsx");
		XSSFWorkbook wb = new XSSFWorkbook(ExcelFileToRead);
		XSSFSheet sheet = wb.getSheetAt(1);
		XSSFRow row;
		XSSFCell cell;

		Iterator rows = sheet.rowIterator();

		while (rows.hasNext()) {
			row = (XSSFRow) rows.next();
			Iterator cells = row.cellIterator();
			while (cells.hasNext()) {
				cell = (XSSFCell) cells.next();

				if (cell.getCellType() == XSSFCell.CELL_TYPE_STRING) {
					System.out.print(cell.getStringCellValue() + "|");
				} else if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
					System.out.print(cell.getNumericCellValue() + "|");
				} else {
					// You can handle Boolean, Formula, Errors
				}
			}
			System.out.println();
		}
	}

	public static void writeXLSXFile() throws IOException {
		String excelFileName = "C:/Test.xlsx";// name of excel file
		String sheetName = "Sheet1";// name of sheet

		XSSFWorkbook wb = new XSSFWorkbook();
		XSSFSheet sheet = wb.createSheet(sheetName);

		// iterating r number of rows
		for (int r = 0; r < 5; r++) {
			XSSFRow row = sheet.createRow(r);

			// iterating c number of columns
			for (int c = 0; c < 5; c++) {
				XSSFCell cell = row.createCell(c);

				cell.setCellValue("Cell " + r + " " + c);
			}
		}

		FileOutputStream fileOut = new FileOutputStream(excelFileName);

		// write this workbook to an Outputstream.
		wb.write(fileOut);
		fileOut.flush();
		fileOut.close();
	}
}