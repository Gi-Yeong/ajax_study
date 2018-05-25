package com.ajax.common;

public class DBConfig {

	public static final int CJ_DB = 1;
	public static final int CJ_FDB = 2;

	public String DBHost = "localhost";
	public String DBUser = "ajax";
	public String DBName = "ajax_study";
	public String DBPassword = "qwe123";

	private DBConfig() {
		// 싱글톤 모델
	}

	private static class LazyHolder {
		public static final DBConfig INSTANCE = new DBConfig();
	}

	public static DBConfig getInstance() {
		return LazyHolder.INSTANCE;
	}

	public static DBConfig getConfig(int CJ_dbs) {
		DBConfig dbConfig = DBConfig.getInstance();

		if (CJ_dbs == CJ_DB) {
			dbConfig.DBHost = "localhost";
			dbConfig.DBUser = "ajax";
			dbConfig.DBName = "ajax_study";
			dbConfig.DBPassword = "qwe123";
		} else if (CJ_dbs == CJ_FDB) {
			dbConfig.DBHost = "";
			dbConfig.DBUser = "";
			dbConfig.DBName = "";
			dbConfig.DBPassword = "";
		}

		return dbConfig;
	}
}
