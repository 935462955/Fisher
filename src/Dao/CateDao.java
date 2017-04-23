package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.Category;
import entity.Family;
import entity.List;

public class CateDao {
	public int getSumCateNum(String familyName){
		Connection con = null;
		  PreparedStatement pre = null;
		try{
		int sum = 0;
		 con = new DataBase().getConnection();
		String sql = "select count(category) sum from category where family = ?";
    	 pre = con.prepareStatement(sql);
    	pre.setString(1, familyName);
    	ResultSet result = pre.executeQuery();
    	if(result.next())
        sum = result.getInt("sum");
    	return sum;
    	
		}
		catch(Exception e){
			e.printStackTrace();
			return -1;
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
	
	public Vector<Category> getCateByPage(String familyName,int page,int pageNum){
		   Vector<Category> v = new Vector<>();
		   Connection con = null;
			  PreparedStatement pre = null;
		   try{
			    con = new DataBase().getConnection();
				String sql = "select category from(select  row_number() over(order by category desc) rk ,category,family from category) where rk>? and rk<=? and family = ?";
		        pre = con.prepareStatement(sql);
		    	pre.setInt(1,(page-1)*pageNum);
		    	pre.setInt(2, page*pageNum);
		    	pre.setString(3, familyName);
		    	ResultSet result = pre.executeQuery();
		    	Category ca = null;
		    	while(result.next()){
		    		ca = new Category();
		    		ca.setName(result.getString("category"));
		    		v.add(ca);
		    	}
		    	return v;
		   }
		   catch(Exception e){
			   e.printStackTrace();
			   return v;
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
	
	public Vector<Category> getCategoryByPinYin(String word,String familyName,int page, int pageNum){
		   Vector<Category> v = new Vector<>();
		   Connection con = null;
		   PreparedStatement pre = null;
		   try{
			   con = new DataBase().getConnection();
			   String sql ="select family,category from(select  row_number() over(order by category desc) rk,category,family from"
		+"(select f_pinyin(category) py,family,category from category where family = ?) "+ 
		"where py like ?) where rk>? and rk<=?";
			   pre = con.prepareStatement(sql);
			   pre.setString(1,familyName);
			   pre.setString(2, word+"%");
			   pre.setInt(3, (page-1)*pageNum);
			   pre.setInt(4, page * pageNum);
			   ResultSet result = pre.executeQuery();
			   Category category = null;
			 	while(result.next()){
			 		category = new Category();
			 		category.setName(result.getString("category"));
			 		category.setFamily(result.getString("family"));
		    		v.add(category);
		    	}
		    	return v;
			
		   }
		   catch(Exception e){
			   e.printStackTrace();
			   return v;
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
	
	public int getSumCategoryPYNum(String word,String familyName){
		Connection con = null;
		PreparedStatement pre = null;
		try{
		int sum = 0;
		 con = new DataBase().getConnection();
		String sql = "select count(category) sum from(select f_pinyin(categort) py,category from category where family = ? ) where py like ?";
		 pre = con.prepareStatement(sql);
		 pre.setString(1,familyName);
		 pre.setString(2,word+"%");
		ResultSet result = pre.executeQuery();
		if(result.next())
	   sum = result.getInt("sum");
		return sum;
		
		}
		catch(Exception e){
		
			e.printStackTrace();	
			return -1;
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
	
	 public Vector<Category> getCategoryByCategoryName(String name){
		  Vector<Category> v = new Vector<>();
		  Connection con = null;
		  PreparedStatement pre = null;
		  try{
			   con = new DataBase().getConnection();
			  String sql ="select category from category where contains(category,?)>0";
			   pre = con.prepareStatement(sql);
			  pre.setString(1, name);
			  ResultSet result = pre.executeQuery();
			  Category category = null;
			  while(result.next()){
				  category =new Category();
				  category.setName(result.getString("category"));
				  v.add(category);
			  }
			  return v;
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  return v;
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

	 public boolean IsInCategory(String category){
		 boolean contain = false; 
		 Connection con = null;
		  PreparedStatement pre = null;
		 try{
			  con = new DataBase().getConnection();
			  String sql ="select category from category where category = ?";
			  pre = con.prepareStatement(sql);
			  pre.setString(1, category);
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
	 
	public boolean InsertNewCategory(String family, String category) {
		 Connection con = null;
		  PreparedStatement pre = null;
		  try{
			  con = new DataBase().getConnection();
			  String sql = "insert into category values(?,?)";
			  pre = con.prepareStatement(sql);
			  pre.setString(1, family);
			  pre.setString(2,category);
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
	
	 public boolean DeleteCate(String category){
		  Connection con = null;
		  PreparedStatement pre = null;
		  try{
			  con = new DataBase().getConnection();
			  String sql = "delete from category where category=?";
			  pre = con.prepareStatement(sql);
			  pre.setString(1,category);
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
	  
	  public boolean UpdateCate(String newCategory,String oldCategory){
		  Connection con = null;
		  PreparedStatement pre = null;
		  try{
			  con = new DataBase().getConnection();
			  String sql = "update category set category = ? where category = ?";
			  pre = con.prepareStatement(sql);
			  pre.setString(1, newCategory);
			  pre.setString(2, oldCategory);
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
