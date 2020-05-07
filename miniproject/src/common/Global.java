package common;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class Global {
	public Connection CN;
	public Statement ST;
	public PreparedStatement PST;
	public CallableStatement CS;
	public ResultSet RS;
	public String qry;
}
