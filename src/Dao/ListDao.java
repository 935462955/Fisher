package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.List;

public class ListDao {
  
	public int getSumListNum(){
		try{
		int sum = 0;
		Connection con = new DataBase().getConnection();
		String sql = "select count(list) sum from list";
    	PreparedStatement pre = con.prepareStatement(sql);
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
   public Vector<List> getListByPage(int page,int pageNum){
	   Vector<List> v = new Vector<>();
	   try{
		    Connection con = new DataBase().getConnection();
			String sql = "select list from(select  row_number() over(order by list desc) rk ,list from list) where rk>? and rk<=?";
	    	PreparedStatement pre = con.prepareStatement(sql);
	    	pre.setInt(1,(page-1)*pageNum);
	    	pre.setInt(2, page*pageNum);
	    	ResultSet result = pre.executeQuery();
	    	List list = null;
	    	while(result.next()){
	    		list = new List();
	    		list.setName(result.getString("list"));
	    		v.add(list);
	    	}
	    	return v;
	   }
	   catch(Exception e){
		   e.printStackTrace();
		   return v;
	   }
   }
   
  public Vector<List> getListByListName(String name){ //按目名进行搜索
	  Vector<List> v = new Vector<>();
	  try{
		  Connection con = new DataBase().getConnection();
		  String sql ="select list from list where contains(list,?)>0"; //返回全文索引包含搜索关键词的项；
		  PreparedStatement pre = con.prepareStatement(sql);
		  pre.setString(1, name);
		  ResultSet result = pre.executeQuery();
		  List list = null;
		  while(result.next()){
			  list =new List();
			  list.setName(result.getString("list"));
			  v.add(list);
		  }
		  return v;
	  }
	  catch(Exception e){
		  e.printStackTrace();
		  return v;
	  }
  }
  
  public boolean IsInList(String list){
		 boolean contain = false; 
		 try{
			  Connection con = new DataBase().getConnection();
			  String sql ="select list from list where list = ?";
			  PreparedStatement pre = con.prepareStatement(sql);
			  pre.setString(1, list);
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
  
  public boolean InsertNewList(String newList){
	  Connection con = null;
	  PreparedStatement pre = null;
	  try{
		  con = new DataBase().getConnection();
		  String sql = "insert into list values(?)";
		  pre = con.prepareStatement(sql);
		  pre.setString(1, newList);
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
  
  public boolean DeleteList(String List){
	  Connection con = null;
	  PreparedStatement pre = null;
	  try{
		  con = new DataBase().getConnection();
		  String sql = "delete from list where list=?";
		  pre = con.prepareStatement(sql);
		  pre.setString(1, List);
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
