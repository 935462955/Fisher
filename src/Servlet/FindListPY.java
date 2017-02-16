package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.FishDao;

/**
 * Servlet implementation class FindListPY
 */
@WebServlet("/FindListPY")
public class FindListPY extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindListPY() {
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
        FishDao fishdao = new FishDao();
        String s = fishdao.getListByPinYin(request.getParameter("PY"));
        PrintWriter out = response.getWriter();
        out.write(s);
        out.close();
        }
        else if(type.equals("family")){
        	FishDao fishdao = new FishDao();
        	String s = fishdao.getFamilyByPinYin(request.getParameter("PY"), request.getParameter("list"));
        	PrintWriter out = response.getWriter();
            out.write(s);
            out.close();
        }
        else if(type.equals("category")){
        	FishDao fishdao = new FishDao();
            String s = fishdao.getCategoryByPinYin(request.getParameter("PY"), request.getParameter("family"));
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
