/*
 * This database access class is responsible for creating database connection and closing the data base connection.
 */
package com.tastyBurger.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author VBlue
 */
public class connectionDAO {
    
    private static String url = "jdbc:mysql://localhost:3306/tastyburger";
    private static String user = "root";
    private static String password = "toor";
    
    public static Connection getConnection() throws SQLException 
	{
            Connection connection = null;
            try {
            	Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(url, user, password);
            } catch(ClassNotFoundException e) {
		throw new SQLException();
            }
            
            return connection;
	}
	
	/**This method will close the connection
	 * @param connection : Connection to be closed.	 
	 */
	
	public static void closeConnection(Connection connection)
	{
            try
            {
		if(connection!= null && !connection.isClosed())
		{
                    connection.close();
		}
            }
            catch(Exception e)
            {
		System.out.println("CLOSE CON : " + e);
            }
	}
    
}
