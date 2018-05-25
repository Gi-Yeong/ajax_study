package com.ajax.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBManager {

	String urlForLocalDB;
	String urlForFDB;

	public static final int CJ_DB = 1;
	public static final int CJ_FDB = 2;
	int defaultDB = CJ_DB;

	public DBManager() {
		this.defaultDB = DBManager.CJ_DB;
		init();
	}

	public DBManager(int defaultDB) {
		this.defaultDB = defaultDB;
		init();
	}

	private void init() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		String unicode = "&useUnicode=yes&characterEncoding=UTF-8";

		DBConfig dbConfig = DBConfig.getConfig(CJ_DB);
		urlForLocalDB = "jdbc:mysql://" + dbConfig.DBHost + ":3306/" + dbConfig.DBName + "?user=" +
				dbConfig.DBUser + "&password=" + dbConfig.DBPassword + "&noAccessToProcedureBodies=true&useSSL=false";
		urlForLocalDB += unicode;
		dbConfig = DBConfig.getConfig(CJ_FDB);
		urlForFDB = "jdbc:mysql://" + dbConfig.DBHost + ":3306/" + dbConfig.DBName + "?user=" +
				dbConfig.DBUser + "&password=" + dbConfig.DBPassword + "&noAccessToProcedureBodies=true&useSSL=false";
		urlForFDB += unicode;
	}

	public Connection getConnection(int db) {
		Connection conn;

		try {
			String url = null;
			if (db == CJ_DB) url = urlForLocalDB;
			else if (db == CJ_FDB) url = urlForFDB;
			conn = DriverManager.getConnection(url);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return conn;
	}

	public Connection getConnection() {
		return getConnection(this.defaultDB);
	}
}
