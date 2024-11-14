/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import java.sql.Connection;

/**
 *
 * @author LENOVO
 */
public class DBContext {


    private String server = "localhost";
    private String user = "sa";

    private String password = "123";

    private String db = "ordering_system";
    private int port = 1433;

    public Connection getConnection() throws Exception {
        SQLServerDataSource ds = new SQLServerDataSource();
        ds.setUser(user);
        ds.setPassword(password);
        ds.setDatabaseName(db);
        ds.setServerName(server);
        ds.setPortNumber(port);
        ds.setEncrypt(false);
        return ds.getConnection();
    }

    public void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    
     public static void main(String[] args) {
        
        try {
            
            DBContext dbConn = new DBContext();
            Connection conn = dbConn.getConnection();
            System.out.println("Kết nối thành công!");
            // Bạn có thể thêm mã để thực hiện các thao tác với cơ sở dữ liệu ở đây.
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
