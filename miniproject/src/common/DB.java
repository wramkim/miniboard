package common;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB {
	public static Connection getConnection() {
		Connection CN = null;
		
		try {
			
			final String DBADDRESS = "localhost";
			final String PORT = "1521";
			final String USER = "SYSTEM";
			final String PWD = "1234";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@" + DBADDRESS + ":" + PORT + ":XE";
			CN = DriverManager.getConnection(url, USER, PWD);
		} catch (Exception e) {
			System.out.println("DB연결 에러 : " + String.valueOf(e));
		}
		return CN;
	}

}
