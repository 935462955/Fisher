package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.CateDao;
import Dao.FamilyDao;
import Dao.ListDao;

/**
 * Servlet implementation class CommonInsert
 */
@WebServlet("/CommonInsert")
public class CommonInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommonInsert() {
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
	    String type = request.getParameter("type");
	    if(type.equals("list")){
	    	String list = request.getParameter("list");
	    	ListDao myListDao = new ListDao();
	    	boolean result = myListDao.InsertNewList(list);
	    	request.setAttribute("result", "addList.jsp");
	    	request.getRequestDispatcher("/CommonMessage.jsp").forward(request, response);
	    	
	    }
	    else if(type.equals("family")){
	    	String list = request.getParameter("list");
	    	String family = request.getParameter("family");
	    	FamilyDao familyDao = new FamilyDao();
	    	boolean result = familyDao.InsertNewFamily(list, family);
	    	if(result){
	    		request.setAttribute("result", "addFamily.jsp");
	    		request.getRequestDispatcher("/CommonMessage.jsp").forward(request, response);
	    	}
	    	else{
	    		
	    	}
	    }
	    else if(type.equals("category")){
	    	String family = request.getParameter("family");
	    	String category = request.getParameter("category");
	    	CateDao cateDao = new CateDao();
	    	boolean result = cateDao.InsertNewCategory(family,category);
	    	if(result){
	    		request.setAttribute("result", "addCategory.jsp");
	    		request.getRequestDispatcher("/CommonMessage.jsp").forward(request, response);
	    	}
	    	else{
	    		
	    	}
	    }
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
