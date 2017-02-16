package Dao;

import java.sql.*;

public class DataBase {

	private Connection con = null;
	public DataBase(){
		 if(con == null)
			 	try {
					Class.forName("oracle.jdbc.driver.OracleDriver");
			        String url = "jdbc:oracle:" + "thin:@127.0.0.1:1521:XE";// 127.0.0.1是本机地址，XE是精简版Oracle的默认数据库名
		            String user = "liu";// 用户名,系统默认的账户名
			        String password = "123";// 你安装时选设置的密码
			        con = DriverManager.getConnection(url, user, password);// 获取连接
			        
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
		 }
    public Connection getConnection(){
    	return con;
    }
}
