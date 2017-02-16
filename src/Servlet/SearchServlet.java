package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.FamilyDao;
import Dao.FishDao;
import Dao.ListDao;
import entity.Family;
import entity.Fish;
import entity.List;


public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServlet() {
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
        String content = request.getParameter("content");
       if(type.equals("fish")){
    	   
       }
       else if(type.equals("list")){
    	   Vector <List> v = new ListDao().getListByListName(content);

    	   request.getSession().setAttribute("searchReturn",v);//jhkhjkjkjkjk

       }
       else if(type.equals("family")){
    	  Vector <Family> v = new FamilyDao().getFamilyByFamilyName(content);
    	  request.getSession().setAttribute("searchReturn",v);
       }

       request.getRequestDispatcher("SearchResult.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
