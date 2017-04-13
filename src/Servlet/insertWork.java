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
import Dao.ListDao;

/**
 * Servlet implementation class insertWork
 */
@WebServlet("/insertWork")
public class insertWork extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public insertWork() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");		
		String result  = "false";
	    String type = request.getParameter("insertType");
	    //System.out.println(type);
	    if(type.equals("list")){
	    	String list = request.getParameter("newValue");
	    	
	    	ListDao myListDao = new ListDao();
	    	result = String.valueOf(myListDao.InsertNewList(list));
	    }
	    else if(type.equals("family")){
	    	String list = request.getParameter("list");
	    	//System.out.println(list);
	    	String family = request.getParameter("family");
	    	FamilyDao familyDao = new FamilyDao();
	        result = String.valueOf(familyDao.InsertNewFamily(list, family));
	    }
	    else if(type.equals("category")){
	    	String family = request.getParameter("family");
	    	String category = request.getParameter("category");
	    	CateDao cateDao = new CateDao();
	    	result = String.valueOf(cateDao.InsertNewCategory(family,category));
	    	
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
