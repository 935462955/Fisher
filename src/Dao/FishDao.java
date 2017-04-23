package Dao;

import java.sql.*;
import java.util.Vector;

import entity.Category;
import entity.Family;
import entity.Fish;


public class FishDao {
	    
	    public Fish getFishByName(String name){
	    	 Connection con = null;
	   	     PreparedStatement pre = null;
	    	try{
	    	con = new DataBase().getConnection();
	    	String sql = "select * from fish where name = ?";
	    	pre = con.prepareStatement(sql);
	    	pre.setString(1,name);
	    	ResultSet result = pre.executeQuery();
	    	Fish fish = null;
	    	while(result.next()){
	    	fish = new Fish();
	    	fish.setName(result.getString("name"));
	 	    	if(result.getString("localname")!=null)
	 	    	fish.setLocalName(result.getString("localname").split(","));//返回一条包含所有别名的字符串,通过逗号分隔为数组
	 	    	else fish.setLocalName(new String []{" "});
	 	    	if(result.getString("englishname")!=null)
	 	    	fish.setEnglishName(result.getString("englishname"));
	 	    	else fish.setEnglishName(" ");
	 	        if(result.getString("origin")!=null)
	 	    	fish.setOrigin(result.getString("origin"));
	 	        else fish.setOrigin(" ");
	 	        if(result.getString("introduction")!=null)
	 	    	fish.setIntroduction(result.getString("introduction"));
	 	        else fish.setIntroduction(" ");
	 	        if(result.getString("picture")!=null)
	 	    	fish.setPicture(result.getString("picture"));
	 	        else fish.setPicture("img\timg.gif");
	 	    	fish.setList(result.getString("list"));
	 	    	fish.setFamily(result.getString("family"));
	 	    	fish.setCategory(result.getString("category"));
	    	}
	    	if(result != null)
	    		result.close();
            if (pre != null)
                pre.close();
            if (con != null)
                con.close();
            if(fish == null )
            	System.out.println("fish is null");//
            return fish;	
	    	}
	    	catch(Exception e) {
	    		e.printStackTrace();
	    		return null;
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
	     
       public Vector<Fish> getFishsByCate(String categoryName){
    	   Vector<Fish> f = new Vector<>();
    	   Connection con = null;
    	   PreparedStatement pre = null;
    	   try{
   	    	con = new DataBase().getConnection();
   	    	String sql = "select * from fish where category = ? ";
   	    	 pre = con.prepareStatement(sql);
   	    	pre.setString(1, categoryName);
   	 	    ResultSet result = pre.executeQuery();
   	 	        Fish fish = null;
   	    		while(result.next()){
   	 	    	fish = new Fish();
   	 	    	fish.setName(result.getString("name"));
   	 	    	if(result.getString("localname")!=null)
   	 	    	fish.setLocalName(result.getString("localname").split(","));//返回一条包含所有别名的字符串,通过逗号分隔为数组
   	 	    	else fish.setLocalName(new String []{" "});
   	 	    	if(result.getString("englishname")!=null)
   	 	    	fish.setEnglishName(result.getString("englishname"));
   	 	    	else fish.setEnglishName(" ");
   	 	        if(result.getString("origin")!=null)
   	 	    	fish.setOrigin(result.getString("origin"));
   	 	        else fish.setOrigin(" ");
   	 	        if(result.getString("introduction")!=null)
   	 	    	fish.setIntroduction(result.getString("introduction"));
   	 	        else fish.setIntroduction(" ");
   	 	        if(result.getString("picture")!=null)
   	 	    	fish.setPicture(result.getString("picture"));
   	 	        else fish.setPicture("img\timg.gif");
   	 	    	fish.setList(result.getString("list"));
   	 	    	fish.setFamily(result.getString("family"));
   	 	    	fish.setCategory(result.getString("category"));
   	 	        f.add(fish);
   	 	    	}
   	    		return f;
   	    	}
    	   catch(Exception e){
    		   e.printStackTrace();
    		   return f;
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
       
       public void insertFish(Fish fish){
    	   Connection con = null;
    	   PreparedStatement pre = null;
    	  try{
    		  con = new DataBase().getConnection();
    		  String sql = "insert into fish (name,localname,englishname,origin,introduction,picture,list,family,category)"
    		  		+ "values(?,?,?,?,?,?,?,?,?)";
    		  pre = con.prepareStatement(sql);
    		  pre.setString(1, fish.getName());
    		  pre.setString(2, fish.getLocalNameByString());
    		  pre.setString(3, fish.getEnglishName());
    		  pre.setString(4, fish.getOrigin());
    		  pre.setString(5,fish.getIntroduction());
    		  pre.setString(6, fish.getPicture());
    		  pre.setString(7, fish.getList());
    		  pre.setString(8, fish.getFamily());
    		  pre.setString(9,fish.getCategory());
    		  pre.executeUpdate();
    	  }
    	  catch(Exception e){
    		 
    		  e.printStackTrace();
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
       
       public String getListByPinYin(String word){
    	   Connection con = null;
    	   PreparedStatement pre = null;
    	   String s="";
    	   try{
    		   con = new DataBase().getConnection();
    		   String sql ="select list from (select f_pinyin(list) py,list  from list) where lower(py) like ?";
    		   pre = con.prepareStatement(sql);
    		   pre.setString(1, word+"%");
    		   ResultSet result = pre.executeQuery();
               if(result.next()) s=result.getString(1);
    		   while(result.next()){
    			   s=s+","+result.getString(1);
    		   }
    		   return s;
    	   }
    	   catch(Exception e){
    		   e.printStackTrace();
    		   return s;
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
       
       public String getFamilyByPinYin(String word,String list){
    	   Connection con = null;
    	   PreparedStatement pre = null;
    	   String s="";
    	   try{
    		   con = new DataBase().getConnection();
    		   String sql ="select family from (select f_pinyin(family) py,family  from family where list = ?) where lower(py) like ?";
    		   pre = con.prepareStatement(sql);
    		   pre.setString(1, list);
    		   pre.setString(2, word+"%");
    		   ResultSet result = pre.executeQuery();
               if(result.next()) s=result.getString(1);
    		   while(result.next()){
    			   s=s+","+result.getString(1);
    		   }
    		   return s;
    	   }
    	   catch(Exception e){
    		   e.printStackTrace();
    		   return s;
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
       
       public String getCategoryByPinYin(String word,String family){
    	   System.out.println(family);
    	   Connection con = null;
    	   PreparedStatement pre = null;
    	   String s="";
    	   try{
    		   con = new DataBase().getConnection();
    		   String sql ="select category from (select f_pinyin(category) py,category  from category where family = ?) where lower(py) like ?";
    		   pre = con.prepareStatement(sql);
    		   pre.setString(1, family);
    		   pre.setString(2, word+"%");
    		   ResultSet result = pre.executeQuery();
               if(result.next()) s=result.getString(1);
    		   while(result.next()){
    			   s=s+","+result.getString(1);
    		   }
    		   return s;
    	   }
    	   catch(Exception e){
    		   e.printStackTrace();
    		   return s;
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
       
   	public Vector<Fish> getFishByPinYin(String word,String categoryName){
		   Vector<Fish> f = new Vector<>();
		   Connection con = null;
		   PreparedStatement pre = null;
		   try{
			   con = new DataBase().getConnection();
			   String sql ="select name,introduction,picture from"
		+"(select f_pinyin(name) py,name,introduction,picture from fish where category = ?) "+ 
		"where py like ?" ;
			   pre = con.prepareStatement(sql);
			   pre.setString(1,categoryName);
			   pre.setString(2, word+"%");
			 
			   ResultSet result = pre.executeQuery();
			   Fish fish = null;
  	    		while(result.next()){
  	 	    	fish = new Fish();
  	 	    	fish.setName(result.getString("name"));
  	 	    	
  	 	        if(result.getString("introduction")!=null)
  	 	    	fish.setIntroduction(result.getString("introduction"));
  	 	        else fish.setIntroduction(" ");
  	 	        if(result.getString("picture")!=null)
  	 	    	fish.setPicture(result.getString("picture"));
  	 	        else fish.setPicture("img\timg.gif");
  	 	        f.add(fish);
  	    		}
		    	return f;
			
		   }
		   catch(Exception e){
			   e.printStackTrace();
			   return f;
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
	
	public int getSumFamilyPYNum(String word,String listName){
		Connection con = null;
		PreparedStatement pre = null;
		try{
		int sum = 0;
		 con = new DataBase().getConnection();
		String sql = "select count(family) sum from(select f_pinyin(family) py,family from family where list = ? ) where py like ?";
		 pre = con.prepareStatement(sql);
		 pre.setString(1,listName);
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
       
       public Vector<Fish> getFishByKeyWord(String keyWord){
    	   Vector<Fish> v = new Vector<>();
    	   Connection con = null;
    		  PreparedStatement pre = null;
 		  try{
 			   con = new DataBase().getConnection();
 			  String sql ="  select * from fish where contains(name,?)>0 or contains(englishname,?)>0 or contains(localname,?)>0";
 			  pre = con.prepareStatement(sql);
 			  pre.setString(1, keyWord);
 			  pre.setString(2, "%"+keyWord+"%");
 			  pre.setString(3, keyWord);
 			  ResultSet result = pre.executeQuery();
 			  Fish fish = null;
 			  while(result.next()){
 				 fish =new Fish();
 				fish.setName(result.getString("name"));
   	 	    	fish.setLocalName(result.getString("localname").split(","));//返回一条包含所有别名的字符串,通过逗号分隔为数组
   	 	    	fish.setEnglishName(result.getString("englishname"));
   	 	    	fish.setOrigin(result.getString("origin"));
   	 	    	fish.setIntroduction(result.getString("introduction"));
   	 	    	fish.setPicture(result.getString("picture"));
   	 	    	fish.setList(result.getString("list"));
   	 	    	fish.setFamily(result.getString("family"));
   	 	    	fish.setCategory(result.getString("category"));
 				  v.add(fish);
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
       
       public boolean DeleteFish(String fishName){
    		  Connection con = null;
    		  PreparedStatement pre = null;
    		  try{
    			  con = new DataBase().getConnection();
    			  String sql = "delete from fish where name=?";
    			  pre = con.prepareStatement(sql);
    			  pre.setString(1, fishName);
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