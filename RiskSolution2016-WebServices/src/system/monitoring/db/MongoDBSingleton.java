package system.monitoring.db;

/**
 * @author PHU Ba Duong
 * Project : Hackathon 2016
 * 
 */

import com.mongodb.DB;
import java.util.Arrays;
import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;

import system.monitoring.parameters.Settings;

import com.mongodb.MongoCredential;

public class MongoDBSingleton {
	private static MongoDBSingleton mongoDBSingleton;
	private static MongoClient mongoClient;
	private static DB db;

	private MongoDBSingleton() {
	}

	public static MongoDBSingleton getInstance() {
		if (mongoDBSingleton == null) {
			mongoDBSingleton = new MongoDBSingleton();
		}
		return mongoDBSingleton;
	}

	public DB getDB() {
		if (mongoClient == null) {
			try {
				MongoCredential credential = MongoCredential.createCredential(Settings.DB_USER, Settings.DB_NAME,
						Settings.DB_PWD);
				mongoClient = new MongoClient(new ServerAddress(Settings.DB_HOST, Settings.DB_PORT),
						Arrays.asList(credential));
			} catch (Exception e) {
				return null;
			}
		}
		if (db == null) {
			db = mongoClient.getDB(Settings.DB_NAME);
		}
		return db;
	}
}
