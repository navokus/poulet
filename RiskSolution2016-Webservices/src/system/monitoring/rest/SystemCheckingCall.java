package system.monitoring.rest;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import javax.ws.rs.GET;

import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import system.monitoring.object.Content;

@Path("/scan")
public class SystemCheckingCall {

	@Path("/website")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response scanWeb(@QueryParam("webname") String webname) {
		Content obtainedResult = new Content();
		try {
			Runtime rt = Runtime.getRuntime();
			Process proc = rt.exec(new String[] {"/home/lion/Desktop/test.sh", webname});
			proc.waitFor();
			StringBuffer output = new StringBuffer();
			BufferedReader reader = new BufferedReader(new InputStreamReader(proc.getInputStream()));
			String line = "";
			while ((line = reader.readLine()) != null) {
				output.append(line);
			}
			obtainedResult.setKey("scan result");
			obtainedResult.setContent(output.toString());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return Response.status(201).entity(obtainedResult).build();
	}
}
