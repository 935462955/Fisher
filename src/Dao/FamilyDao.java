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
		    		System.out.println(family.getName());
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
	 
	 public boolean IsInFamily(String family){
		 boolean contain = false; 
		 try{
			  Connection con = new DataBase().getConnection();
			  String sql ="select family from family where family = ?";
			  PreparedStatement pre = con.prepareStatement(sql);
			  pre.setString(1, family);
			  ResultSet result = pre.executeQuery();
			  while(result.next()){
				  contain = true;
			  }
			 return contain;
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  return contain;
		  }
	 }
	 
	  public boolean InsertNewFamily(String newList,String newFamily){
		  Connection con = null;
		  PreparedStatement pre = null;
		  try{
			  con = new DataBase().getConnection();
			  String sql = "insert into family values(?,?)";
			  pre = con.prepareStatement(sql);
			  pre.setString(1, newList);
			  pre.setString(2,newFamily);
			  pre.executeUpdate();
			  return true;
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  return false;
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
	  
	  public boolean DeleteFamily(String family){
		  Connection con = null;
		  PreparedStatement pre = null;
		  try{
			  con = new DataBase().getConnection();
			  String sql = "delete from family where family=?";
			  pre = con.prepareStatement(sql);
			  pre.setString(1,family);
			  pre.executeUpdate();
			  return true;
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  return false;
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
	  
	  public boolean UpdateFamily(String newFamily,String oldFamily){
		  Connection con = null;
		  PreparedStatement pre = null;
		  try{
			  con = new DataBase().getConnection();
			  String sql = "update family set family = ? where family = ?";
			  pre = con.prepareStatement(sql);
			  pre.setString(1, newFamily);
			  pre.setString(2, oldFamily);
			  pre.executeUpdate();
			  return true;
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  return false;
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
