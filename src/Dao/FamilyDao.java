package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.Family;
import entity.List;

public class FamilyDao {
	public int getSumFamilyNum(String listName){
		try{
		int sum = 0;
		Connection con = new DataBase().getConnection();
		String sql = "select count(family) sum from family where list = ?";
    	PreparedStatement pre = con.prepareStatement(sql);
    	pre.setString(1, listName);
    	ResultSet result = pre.executeQuery();
    	if(result.next())
        sum = result.getInt("sum");
    	return sum;
    	
		}
		catch(Exception e){
			e.printStackTrace();
			return -1;
		}
	}
	  
	public Vector<Family> getFamilyByPage(String listName,int page,int pageNum){
		   Vector<Family> v = new Vector<>();
		   try{
			    Connection con = new DataBase().getConnection();
				String sql = "select family from(select  row_number() over(order by family desc) rk ,family,list from family) where rk>? and rk<=? and list = ?";
		    	PreparedStatement pre = con.prepareStatement(sql);
		    	pre.setInt(1,(page-1)*pageNum);
		    	pre.setInt(2, page*pageNum);
		    	pre.setString(3, listName);
		    	ResultSet result = pre.executeQuery();
		    	Family family = null;
		    	while(result.next()){
		    		family = new Family();
		    		family.setName(result.getString("family"));
		    		v.add(family);
		    	}
		    	return v;
		   }
		   catch(Exception e){
			   e.printStackTrace();
			   return v;
		   }
	   }
	
	 public Vector<Family> getFamilyByFamilyName(String name){
		  Vector<Family> v = new Vector<>();
		  try{
			  Connection con = new DataBase().getConnection();
			  String sql ="select family from family where contains(family,?)>0";
			  PreparedStatement pre = con.prepareStatement(sql);
			  pre.setString(1, name);
			  ResultSet result = pre.executeQuery();
			  Family family = null;
			  while(result.next()){
				  family =new Family();
				  family.setName(result.getString("family"));
				  v.add(family);
			  }
			  return v;
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  return v;
		  }
	  }
}
