package system.monitoring.rest;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import javax.ws.rs.GET;

import javax.ws.rs.Path;
import com.mongodb.DBObject;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;

import javax.ws.rs.core.MediaType;

import system.monitoring.db.MongoDBSingleton;
import system.monitoring.parameters.Settings;

@Path("/scan")
public class ScanningCalls {

	@Path("/website")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public DBObject scanWeb(@QueryParam("webname") String webname) {
		MongoDBSingleton mongoDBSingleton = MongoDBSingleton.getInstance();
		DB db = mongoDBSingleton.getDB();
		DBCollection col = db.getCollection(Settings.WEB_COL);
		DBObject query = new BasicDBObject("host", webname);
		DBObject result = col.findOne(query);
		if (result != null) {
			BasicDBList vulnerabilities = (BasicDBList) result.get("vulnerabilities");
			int dangerousErrors = 0;
			int normalErrors = 0;
			System.out.println(vulnerabilities.size());
			for (int idx = 0; idx < vulnerabilities.size(); idx++) {
				DBObject vulnerability = (DBObject) vulnerabilities.get(idx);
				if ((int) vulnerability.get("OSVDB") == 0) 
					normalErrors++;
				 else
					dangerousErrors++;
			}
			DBObject vulnerabilitiesAssessment = new BasicDBObject("DangerousSystemAssessment",
					(float) dangerousErrors * 2 / (dangerousErrors * 2 + normalErrors));
			vulnerabilitiesAssessment.put("NormalSystemAssessment",
					(float) normalErrors / (dangerousErrors * 2 + normalErrors));
			return vulnerabilitiesAssessment;
		} else {
			DBObject obtainedResult = new BasicDBObject();
			try {
				Runtime rt = Runtime.getRuntime();
				Process proc = rt.exec(new String[] { Settings.SHELL_SCRIPT_FILE, webname });
				proc.waitFor();
				StringBuffer output = new StringBuffer();
				BufferedReader reader = new BufferedReader(new InputStreamReader(proc.getInputStream()));
				String line = "";
				while ((line = reader.readLine()) != null) {
					output.append(line);
				}
				obtainedResult.put("scan tool", "nikto");
				obtainedResult.put("result", output.toString());
				return obtainedResult;
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			return null;
		}
	}
}
