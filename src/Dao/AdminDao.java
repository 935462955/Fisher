package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDao {
public boolean CheckVolid(String account,String password){
	boolean contain = false;
	String back;
	Connection con = null;
	  PreparedStatement pre = null;
	try{
		   con = new DataBase().getConnection();
		  String sql ="select password from account where account = ?";
		   pre = con.prepareStatement(sql);
		  pre.setString(1, account);
		  ResultSet result = pre.executeQuery();
		  if(result.next()){
		  back = result.getString("password");
		  }
		  else{
			 return contain;
		  }
		  if(back.equals(password))
			  contain = true;
		  return contain;
	  }
	  catch(Exception e){
		  e.printStackTrace();
		  return contain;
	  }
	finally{
		  try {
	  
		  if(pre != null){
			pre.close();
			
		  }
		  if(con != null){
			  con.close();
		  }
		  }
		  catch(Exception e){
			  e.printStackTrace();
		  }
	  }
}
}
