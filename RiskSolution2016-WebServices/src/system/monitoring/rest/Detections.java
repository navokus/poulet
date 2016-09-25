package system.monitoring.rest;
/**
 * @author PHU Ba Duong
 * Project : Hackathon 2016
 */
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import com.mongodb.DBObject;
import com.mongodb.BasicDBObject;

import system.monitoring.parameters.Settings;

@Path("/detections")
public class Detections {
	@GET
	@Path("/warning")
	@Produces(MediaType.APPLICATION_JSON)
	public DBObject warningLevel(@QueryParam("website") String webName) {
		DBObject warningLevel = new BasicDBObject("Web side", webName);
		warningLevel.put("warningLevel", Settings.LOW_SECURITY);
		// ....code danh gia mức độ cảnh báo
		return warningLevel;
	}
}
