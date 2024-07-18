/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public class util {
    private static final String DB_Name = "PRJ_Assignment";
    private static final String DB_User_Name = "sa";
    private static final String DB_Password = "12345";
    
    public static Connection makeConnection() throws ClassNotFoundException, SQLException{
        Connection con = null;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url="jdbc:sqlserver://localhost:1433;databaseName=PRJ_Assignment";
        con = DriverManager.getConnection(url, DB_User_Name, DB_Password);       
        return con;
    }
    
    public static void main(String[] args) {
        util u = new util();
        System.out.println(u);
    }
}
