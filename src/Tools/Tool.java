package Tools;

import java.io.File;

public class Tool {
 public String [] subStringByPoint(String str){
	 String string [] = str.split(",");
	 return string;
 }
 
 public boolean DeleteFile(String path){
	 boolean flag = false;
	 File f = new File(path);
	 if(f.exists()){
		 f.delete();
		 flag = true;
	 }
	return flag;
 }
}
