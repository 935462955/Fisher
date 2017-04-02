package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.ListDao;

/**
 * Servlet implementation class deleteWork
 */
@WebServlet("/deleteWork")
public class deleteWork extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
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
        String deleteValue = request.getParameter("deleteValue");//Ҫ�����ݿ�ɾ����ֵ
        String deleteType = request.getParameter("deleteType");//����
        //System.out.println("value "+deleteValue+" !"+deleteType);
        String result = "false";
        if(deleteType.equals("list")){
        ListDao listDao = new ListDao();
        result = String.valueOf(listDao.DeleteList(deleteValue));
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
