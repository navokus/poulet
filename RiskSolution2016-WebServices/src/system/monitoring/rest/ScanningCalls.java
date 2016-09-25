package system.monitoring.rest;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Scanner;

import javax.ws.rs.GET;

import javax.ws.rs.Path;
import com.mongodb.DBObject;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import com.mongodb.DB;
import com.mongodb.BasicDBList;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.BasicDBObject;

import javax.ws.rs.core.MediaType;
import system.monitoring.db.MongoDBSingleton;
import system.monitoring.parameters.Settings;

@Path("/scan")
public class ScanningCalls {

	public static final java.util.Map<String, Float> CO_DANGERS;

	static {
		CO_DANGERS = new HashMap<String, Float>();
		CO_DANGERS.put("dangerous", (float) 3);
		CO_DANGERS.put("warming", (float) 1.5);
	}

	@Path("/website")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public DBObject scan(@QueryParam("webname") String webname, @QueryParam("tools") String tools) {
		MongoDBSingleton mongoDBSingleton = MongoDBSingleton.getInstance();
		DB db = mongoDBSingleton.getDB();
		DBCollection col = db.getCollection(Settings.WEB_COL);
		DBObject query = new BasicDBObject("host", webname);
		DBCursor cursor = col.find(query);
		while (cursor.hasNext()) {
			DBObject result = cursor.next();
			if (result != null) {
				BasicDBList vulnerabilities = (BasicDBList) result.get("vulnerabilities");
				int dangerousErrors = 0;
				int undefinedErrors = 0;
				int insignificantErrors = 0;
				for (int idx = 0; idx < vulnerabilities.size(); idx++) {
					DBObject vulnerability = (DBObject) vulnerabilities.get(idx);
					if ((int) vulnerability.get("OSVDB") == 0)
						undefinedErrors++;
					else
						dangerousErrors++;
					if (vulnerability.get("Severity") != null
							&& ((String) vulnerability.get("Severity")).equals("High")) {
						dangerousErrors++;
					}
					if (vulnerability.get("Severity") != null
							&& (((String) vulnerability.get("Severity")).equals("Medium")
									|| ((String) vulnerability.get("Severity")).equals("Low"))) {
						insignificantErrors++;
					}
				}

				DBObject vulnerabilitiesAssessment = new BasicDBObject("dangerousErrors",
						(float) dangerousErrors * CO_DANGERS.get("dangerous")
								/ (dangerousErrors * CO_DANGERS.get("dangerous")
										+ undefinedErrors * CO_DANGERS.get("warming") + insignificantErrors));
				vulnerabilitiesAssessment.put("undefinedErrors",
						(float) undefinedErrors * CO_DANGERS.get("warming")
								/ (dangerousErrors * CO_DANGERS.get("dangerous")
										+ undefinedErrors * CO_DANGERS.get("warming") + insignificantErrors));
				vulnerabilitiesAssessment.put("insignificantErrors",
						(float) insignificantErrors / (dangerousErrors * CO_DANGERS.get("dangerous")
								+ undefinedErrors * CO_DANGERS.get("warming") + insignificantErrors));
				vulnerabilitiesAssessment.put("totalErrors", dangerousErrors + undefinedErrors + insignificantErrors);
				return vulnerabilitiesAssessment;
			} else {
				return scanWebSite(webname, tools);
			}
		}
		return null;
	}

	@SuppressWarnings("finally")
	public DBObject scanWebSite(String webName, String tools) {
		DBObject webScanElement = new BasicDBObject();
		try {
			String[] usedTools = tools.split(",");
			Runtime rt = Runtime.getRuntime();
			for (int idx = 0; idx < usedTools.length; idx++) {
				// in case of nikto tool
				if (usedTools[idx].equals("nikto")) {
					// perform the sh file for scanning website
					Process proc = rt
							.exec(new String[] { Settings.SHELL_SCRIPT_FILE + "-" + usedTools[idx] + ".sh", webName });
					proc.waitFor();
					// import data returned
					proc = rt.exec(new String[] { Settings.SHELL_SCRIPT_IMPORT_DATA, webName + ".JSON" });
					proc.waitFor();
					// in case of w3af
				} else if (usedTools[idx].equals("w3af")) {
					Process proc = rt
							.exec(new String[] { Settings.SHELL_SCRIPT_FILE + "-" + usedTools[idx] + ".sh", webName });
					proc.waitFor();
					File file = new File(Settings.CSV_FILE_PATH);
					Scanner scanner = new Scanner(file);

					BasicDBList vulerabilities = new BasicDBList();
					String headers[] = new String[6];
					if (scanner.hasNextLine()) {
						String firstLine = scanner.nextLine();
						headers = firstLine.split(",");
					}

					while (scanner.hasNextLine()) {
						String line = scanner.nextLine();
						String[] newLines = line.split(",");
						DBObject vulerability = new BasicDBObject();
						int i = 0;
						if (newLines.length == headers.length) {
							vulerability.put(headers[i], newLines[i++]);
							vulerability.put(headers[i], newLines[i++]);
							vulerability.put(headers[i], newLines[i++]);
							vulerability.put(headers[i], newLines[i++]);
							vulerability.put(headers[i], newLines[i++]);
							vulerability.put(headers[i], newLines[i++]);
							vulerability.put(headers[i], newLines[i]);
							vulerabilities.add(vulerability);
						}
					}
					webScanElement = new BasicDBObject("host", webName).append("vulnerabilities", vulerabilities);
					MongoDBSingleton mongoDBSingleton = MongoDBSingleton.getInstance();
					DB db = mongoDBSingleton.getDB();
					DBCollection col = db.getCollection(Settings.WEB_COL);
					col.insert(webScanElement);
				}
			}
			return webScanElement;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			return null;
		}
	}

	@Path("/website/log")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public DBObject scanGetLog(@QueryParam("webname") String webname, @QueryParam("typelog") String typelog) {
		DBObject log = new BasicDBObject();
		MongoDBSingleton mongoDBSingleton = MongoDBSingleton.getInstance();
		DB db = mongoDBSingleton.getDB();
		DBCollection col = db.getCollection(Settings.LOGS_COL);
		DBObject result = col.findOne(new BasicDBObject("host", webname));
		if (result != null) {
			return result;
		}
		try {
			Runtime rt = Runtime.getRuntime();
			Process proc = rt.exec(new String[] { Settings.SHELL_SCRIPT_FILE + "-" + typelog + ".sh", webname });
			proc.waitFor();
			StringBuffer output = new StringBuffer();
			BufferedReader reader = new BufferedReader(new InputStreamReader(proc.getInputStream()));
			String line = "";
			while ((line = reader.readLine()) != null) {
				output.append(line);
			}
			log.put("Scan-tool", "nikto");
			log.put("log", output.toString());
			col.insert(log);
			return log;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
