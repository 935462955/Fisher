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
 * Servlet implementation class updateWork
 */
@WebServlet("/updateWork")
public class updateWork extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateWork() {
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
		String oldValue =request.getParameter("oldValue");
	    String newValue =request.getParameter("newValue");
	    String type     = request.getParameter("updateType");
	    String result = "false";
	    //System.out.println("oldValue "+oldValue+" newValue "+newValue+" type"+type);
	    if(type.equals("list")){
	    	ListDao listDao = new ListDao();
	    	result = String.valueOf(listDao.UpdateList(newValue, oldValue));
	    }
	    else if(type.equals("family")){
	    	FamilyDao familyDao = new FamilyDao();
	    	result = String.valueOf(familyDao.UpdateFamily(newValue, oldValue));
	    }
	    else if(type.equals("category")){
	    	CateDao cateDao = new CateDao();
	    	result = String.valueOf(cateDao.UpdateCate(newValue, oldValue));
	    	
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
