package Server;

import java.io.IOException;


import Connection.DatabaseOperations;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;  





/**
 * Servlet implementation class CrawlServlet
 */
public class CrawlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con = null;
	static ResultSet rs;
    Statement stmt = null; 
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CrawlServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
          
		
		String url=request.getParameter("url");
		String keyword=request.getParameter("keyword");
		DatabaseOperations db=new DatabaseOperations();
		db.extractLinks(url, keyword);     // call this method to extract links and crawl pages
		request.getRequestDispatcher("/View/Display.jsp").forward(request, response);
		
		
	}
	
	
	

}
