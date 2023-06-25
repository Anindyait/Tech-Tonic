package pkg;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class ModifyArticle
 */
@WebServlet("/DeleteArticle")

public class DeleteArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteArticle() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ServletContext context=getServletContext(); 
		response.setContentType("text/html");
		PrintWriter pw = response.getWriter();
		
		
		String delete_no = request.getParameter("delete");
		
		String user_id = Utilities.GetUID(request);

		
		System.out.println("Delete = "+delete_no);
		
		
		 try 
			{
				Connection con;
				PreparedStatement pstm; 			       //class to prepare statement
				
				Class.forName("com.mysql.cj.jdbc.Driver"); //Class is a class
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/news", "root", Utilities.DB_pwd); //DriverManager is a class 
															//jdbc:mysql then ip address then port no. then db name
														

				Statement stmt = con.createStatement();
				
				
				pstm = con.prepareStatement("select poster from article where article_id = ?;");
				pstm.setString(1, delete_no);
				ResultSet rs_id = pstm.executeQuery();
				
				if(rs_id.next() && rs_id.getString("poster").equals(user_id))
				{
					
								
						pstm  = con.prepareStatement("delete from article where article_id=?");
						pstm.setString(1, delete_no); 
						
						pstm.executeUpdate();
						
						System.out.println("Deleted "+delete_no);

						pw.println("Deleted!");
						

				}
				request.getRequestDispatcher("postDelete.html").include(request, response);

				
				
			}catch(Exception e) {System.out.println(e);}
		
		 
		
	}

}
