package Dao;

import java.sql.*;

public class DataBase {

	private Connection con = null;
	public DataBase(){
		 if(con == null)
			 	try {
					Class.forName("oracle.jdbc.driver.OracleDriver");
			        String url = "jdbc:oracle:" + "thin:@127.0.0.1:1521:XE";// 127.0.0.1�Ǳ�����ַ��XE�Ǿ����Oracle��Ĭ�����ݿ���
		            String user = "liu";// �û���,ϵͳĬ�ϵ��˻���
			        String password = "123";// �㰲װʱѡ���õ�����
			        con = DriverManager.getConnection(url, user, password);// ��ȡ����
			        
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
		 }
    public Connection getConnection(){
    	return con;
    }
}
