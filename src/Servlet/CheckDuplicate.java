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

/**
 * Servlet implementation class CheckDuplicate
 */
@WebServlet("/CheckDuplicate")
public class CheckDuplicate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckDuplicate() {
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
        String value = request.getParameter("value");
        String s ;
        if(type.equals("fish")){
        	FishDao f = new FishDao();
        	if(f.getFishByName(value) != null)
        		s = "false";
        	else s = "true";
        	//System.out.println(s+" "+value);
        	PrintWriter out = response.getWriter();
            out.write(s);
            out.close();
        }
        else if(type.equals("list")){
        	ListDao l = new ListDao();
        	if(l.IsInList(value)){
        		s = "false";
        	}
        	else s = "true" ;
        	PrintWriter out = response.getWriter();
            out.write(s);
            out.close();
        }
        else if(type.equals("family")){
        	FamilyDao familyDao = new FamilyDao();
        	if(familyDao.IsInFamily(value)){
        		s = "false";
        	}
        	else s = "true";
        	PrintWriter out = response.getWriter();
            out.write(s);
            out.close();
        }
        else if(type.equals("category")){
        	CateDao cateDao = new CateDao();
        	if(cateDao.IsInCategory(value)){
        		s = "false";
        	}
        	else s = "true";
        	PrintWriter out = response.getWriter();
            out.write(s);
            out.close();
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
