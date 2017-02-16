package Tools;

import java.util.Vector;

import Dao.CateDao;
import Dao.FamilyDao;
import Dao.FishDao;
import Dao.ListDao;
import entity.Category;
import entity.Family;
import entity.Fish;
import entity.List;

public class TestTools {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
//      Tool tool = new Tool();
//      String [] string = tool.subStringByPoint("ÏÌÓã,¶·Óã,öêÓã");
//      for(int i = 0 ; i<string.length;i++)
//      System.out.println(string[i]);
	
	
//	Vector<List> x = new ListDao().getListByPage(1, 10);
//	for(List l:x){
//		System.out.println(l.getName());
//	}
//      FishDao d = new FishDao();
//		System.out.println(d.getSumCateNum("öÙ¿Æ"));
	    
//		Vector<Fish> x = d.getFishsByCate("´óÂé¹şÓãÊô");
//		for(Fish f:x){
//			System.out.println(f.getIntroduction());
//		}	
//	   Fish f = d.getFishByName("Ì¨ÍåÂíËÕÂé¹ş");
//	   System.out.println(f.getLocalNameByString());
Vector<List> l = new ListDao().getListByListName("ĞÎ");
for(List x:l){
System.out.println(x.getName());
}
}
}
