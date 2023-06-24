package pkg;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Dashboard
 */
@WebServlet("/Dashboard")
public class Dashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Dashboard() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    String first_name=null;
    String last_name=null;
    String email=null;
    String phone=null;
    String dob=null;
    String gender=null;

    
    void DB_Access(String user_id)
    {
    	

    	try {
			PreparedStatement pstm;
			
			int uid = Integer.parseInt(user_id);
			System.out.println(uid*10);
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/news", "root", "abcd"); //DriverManager is a class 
			
			
			pstm = con.prepareStatement("select first_name, last_name, email, phone, dob, gender from user_table where user_id = ?;");
	
			pstm.setString(1, user_id);
			
			ResultSet rs = pstm.executeQuery();
			
			if(rs.next())
			{
				first_name = rs.getString("first_name");
				last_name = rs.getString("last_name");
				email = rs.getString("email");
				phone = rs.getString("phone");
				dob = rs.getString("dob");
				gender = rs.getString("gender");

			}
			
			con.close();
			
    	}catch(Exception e) {System.out.println(e);}
    	
    
    }
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ServletContext context=getServletContext();
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html");
	
		String user_id = Utilities.GetUID(request);
		
		if(user_id == null)
		{
			//request.getRequestDispatcher("Login").forward(request, response);
			pw.print("Not logged in!<br><a href='Login'>Login Page</a>");
		}
		else
		{
			DB_Access(user_id);

			request.setAttribute("user", first_name);
			request.setAttribute("last_name", last_name);
			request.setAttribute("user_id", user_id);
			request.setAttribute("email", email);
			request.setAttribute("phone", phone);
			request.setAttribute("gender", gender);
			request.setAttribute("dob", dob);

	    	request.getRequestDispatcher("dashboard.jsp").include(request, response);
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
