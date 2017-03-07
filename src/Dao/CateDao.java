package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.Category;
import entity.List;

public class CateDao {
	public int getSumCateNum(String familyName){
		try{
		int sum = 0;
		Connection con = new DataBase().getConnection();
		String sql = "select count(category) sum from category where family = ?";
    	PreparedStatement pre = con.prepareStatement(sql);
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
	}
	
	public Vector<Category> getCateByPage(String familyName,int page,int pageNum){
		   Vector<Category> v = new Vector<>();
		   try{
			    Connection con = new DataBase().getConnection();
				String sql = "select category from(select  row_number() over(order by category desc) rk ,category,family from category) where rk>? and rk<=? and family = ?";
		    	PreparedStatement pre = con.prepareStatement(sql);
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
	   }
	
	 public Vector<Category> getCategoryByCategoryName(String name){
		  Vector<Category> v = new Vector<>();
		  try{
			  Connection con = new DataBase().getConnection();
			  String sql ="select category from category where contains(category,?)>0";
			  PreparedStatement pre = con.prepareStatement(sql);
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
	  }
}
