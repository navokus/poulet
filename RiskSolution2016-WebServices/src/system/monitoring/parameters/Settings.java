package system.monitoring.parameters;

public interface Settings {
	
	public static final String CSV_W3AF = "/home/lion/Desktop/Hackathon/W3afReport.csv";
	public static final String SHELL_SCRIPT_FILE = "/home/lion/Desktop/Hackathon/run";
	public static final String SHELL_SCRIPT_IMPORT_DATA = "/home/lion/Desktop/Hackathon/import-to-mongodb.sh";
	public static final String SHELL_SCRIPT_IMPORT_DATA_CSV = "/home/lion/Desktop/Hackathon/import-to-mongodb-csv.sh";
	public static final String CSV_FILE_PATH = "/home/lion/Desktop/Hackathon/W3afReport.csv";

	public static final Integer LOW_SECURITY = 1;
	public static final Integer HIGH_SECURITY = 3;
	public static final Integer AVERAGE_SECURITY = 2;

	public static final String DB_NAME = "SmartD";
	public static final String DB_HOST = "127.0.0.1";
	public static final Integer DB_PORT = 27017;
	public static final String DB_USER = "hackathon";
	public static final char[] DB_PWD = {'a', 'b', 'c', '1', '2', '3'};
	
	//Collection save the 
	public static final String WEB_COL = "Webs";
	public static final String EVAL_COL = "EvaluationMeasures";
	public static final String LOGS_COL = "Logs";
	public static final String W3AF_OUTPUT = "W3afReport.csv";
	 
}
