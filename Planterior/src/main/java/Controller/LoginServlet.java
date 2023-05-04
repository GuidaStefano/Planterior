package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.apache.tomcat.jdbc.pool.PoolProperties;


import Model.Connessione;
import Model.LoginQuery;



/**
 * Servlet implementation class Login
 */
@WebServlet(name = "LoginServlet", urlPatterns = { "/LoginServlet" })
public class LoginServlet extends HttpServlet {
 
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
 
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		PrintWriter out = response.getWriter();
	/*	Connection conn=null;
	try {
		 conn = Connessione.getConnection();
	}catch(Exception e) {
		e.printStackTrace();
	}
		*/
		String n=request.getParameter("txtName");
		String m=request.getParameter("txtPwd");
		 
		 
 
		try {
		int  rs= LoginQuery.controllo(n, m);
		if(rs==1) {
			RequestDispatcher rd=request.getRequestDispatcher("Welcome.jsp");
			rd.forward(request, response);
			
		}
		else if(rs==0) {
			out.println("<font color=red size18>Login Failed<br>");
			out.println("<a href=login.jsp>Try Again</a>");
		}
		 
		}
		catch(Exception e) {
			out.println("non funziona");
		}
		
		
		}
		 
		
		}
	


