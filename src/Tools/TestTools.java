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
import java.awt.image.BufferedImage;  
import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileNotFoundException;  
import java.io.IOException;  
  
import javax.imageio.ImageIO;  

public class TestTools {

	public static void main(String[] args) throws FileNotFoundException, IOException {
		// TODO Auto-generated method stub
//      Tool tool = new Tool();
//      String [] string = tool.subStringByPoint("œÃ”„,∂∑”„,ˆÍ”„");
//      for(int i = 0 ; i<string.length;i++)
//      System.out.println(string[i]);
	
	
	Vector<List> x = new ListDao().getListByPinYin("D", 1, 10);
	for(List l:x){
		System.out.println(l.getName());
	}
//      FishDao d = new FishDao();
//		System.out.println(d.getSumCateNum("ˆŸø∆"));
	    
//		Vector<Fish> x = d.getFishsByCate("¥Û¬Èπ˛”„ Ù");
//		for(Fish f:x){
//			System.out.println(f.getIntroduction());
//		}	
//	   Fish f = d.getFishByName("Ã®ÕÂ¬ÌÀ’¬Èπ˛");
//	   System.out.println(f.getLocalNameByString());
//Vector<Fish> l = new FishDao().getFishByKeyWord("¥Û");
//for(Fish x:l){
//System.out.println(x.getName());
//}
//String encoding = System.getProperty("file.encoding");
//System.out.println(encoding);
//	 File picture = new File("C:\\Users\\liu\\Pictures\\415637.jpg");  
//     BufferedImage sourceImg =ImageIO.read(new FileInputStream(picture));   
//     System.out.println(String.format("%.1f",picture.length()/1024.0));  
//     System.out.println(sourceImg.getWidth());  
//     System.out.println(sourceImg.getHeight());  

}
}

