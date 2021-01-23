package mvc.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	public static Connection getConnection() throws SQLException, ClassNotFoundException{
		
		Connection conn=null;
		
		String url="jdbc:mysql://34.64.186.191:3306/ap";
//		String user="root";
		String user="shin";
		String password="0323";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url, user, password);
		
		return conn;
	}

}
