package pkg;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Article
 */
@WebServlet("/Article")
public class Article extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Article() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		boolean flag=true;
		ServletContext context=getServletContext();
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html");
		
		String title = request.getParameter("title");
		String id = request.getParameter("id");
		
		if(title == null || id == null)
			flag=false;
		
		try {
    		
    		Connection con;
    		PreparedStatement pstm;
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/news", "root", Utilities.DB_pwd); //DriverManager is a class 
			
			//Query by id
			pstm = con.prepareStatement("select article_id, title, body, tags, post_date, image_path, poster from article where article_id = ?;");
    		
			pstm.setString(1, id);
			
			ResultSet rs = pstm.executeQuery();
			
			
			
			if(rs.next())
			{
				title = rs.getString("title");
				String body = rs.getString("body");
				String tags = rs.getString("tags");
				String post_date = rs.getString("post_date");
				String image_path = rs.getString("image_path");
				String poster_id = rs.getString("poster");
				
				//Date and time formatting
			    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    Date date = formatter.parse(post_date);
			    DateFormat formatter2 = new SimpleDateFormat("HH:mm E, dd MMM yyyy");
			    post_date = formatter2.format(date);
			    
			    //Access poster name
				pstm = con.prepareStatement("select first_name, last_name from user_table where user_id = ?;");
				pstm.setString(1, poster_id);
				
				ResultSet rs2 = pstm.executeQuery();
				String poster_name = poster_id;
				
				if(rs2.next())
				{
					poster_name = rs2.getString("first_name") + " " + rs2.getString("last_name");
				}
				
				
				request.setAttribute("title", title);
				request.setAttribute("image_path", image_path);
				request.setAttribute("poster_name", poster_name);
				request.setAttribute("post_date", post_date);
				request.setAttribute("body", body);
				request.setAttribute("tags", tags);

				request.getRequestDispatcher("article.jsp").include(request, response);

			    
			   
			    

			}
			
			else {
				flag = false;
			}
			
			
			con.close();
			
			if(!flag)
			{
				request.setAttribute("error_msg", "Page doesn't exist!");
				request.getRequestDispatcher("error.jsp").include(request, response);

			}
			
			}
		catch(Exception e) {System.out.println(e);}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
