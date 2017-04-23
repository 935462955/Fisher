package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.CateDao;
import Dao.FamilyDao;
import Dao.FishDao;
import Dao.ListDao;
import Tools.Tool;

/**
 * Servlet implementation class deleteWork
 */
@WebServlet("/deleteWork")
public class deleteWork extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final String DIRECTORY = "E:\\Fisher\\img\\";   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteWork() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
      //  System.out.println("afaaf");
        String deleteValue = request.getParameter("deleteValue");//要从数据库删除的值
        String deleteType = request.getParameter("deleteType");//表名
       // System.out.println("value "+deleteValue+" !"+deleteType);
        String result = "false";
        if(deleteType.equals("list")){
        ListDao listDao = new ListDao();
        result = String.valueOf(listDao.DeleteList(deleteValue));
        }
        else if(deleteType.equals("family")){
        	FamilyDao familyDao = new FamilyDao();
        	result = String.valueOf(familyDao.DeleteFamily(deleteValue));
        }
        else if(deleteType.equals("category")){
        	CateDao cateDao = new CateDao();
        	result = String.valueOf(cateDao.DeleteCate(deleteValue));
        }
        else if(deleteType.equals("fish")){
        	String fileURL = request.getParameter("fileURL");
        	fileURL = fileURL.replace('/', '\\');
        	if(!fileURL.substring(fileURL.lastIndexOf('\\')+1).equals("no.jpg")){//如果不是系统默认图片则删除图片
        	fileURL = fileURL.substring(fileURL.lastIndexOf('\\')+1);
        	fileURL = DIRECTORY+fileURL ;
        	System.out.println(fileURL);
        	Tool tool = new Tool();
        	if(!tool.DeleteFile(fileURL))
        		System.out.println("图片删除失败请手动删除！");
        	}
        	FishDao fishDao = new FishDao();
        	result = String.valueOf(fishDao.DeleteFish(deleteValue));
        }
        PrintWriter out = response.getWriter();
        out.write(result);
        out.close();
    }
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
