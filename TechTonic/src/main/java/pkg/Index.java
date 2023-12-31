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
 * Servlet implementation class Index
 */
@WebServlet("/Index")
public class Index extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Index() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ServletContext context=getServletContext(); 
		response.setContentType("text/html");
		PrintWriter pw = response.getWriter();
		
		boolean flag = false;
		
		
		try {
    		
    		Connection con;
    		PreparedStatement pstm;
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/news", "root", Utilities.DB_pwd); //DriverManager is a class 
			
			//Access top news
			pstm = con.prepareStatement("select article_id, title, image_path, poster from article order by post_date desc limit 1;");
    		
			
			ResultSet rs_top = pstm.executeQuery();
			
			
			
			while(rs_top.next())
			{
				String title = rs_top.getString("title");
				String poster_id = rs_top.getString("poster");
				String article_id = rs_top.getString("article_id");
				String image_path = rs_top.getString("image_path");
				
				
			    
			    //Access poster name
				pstm = con.prepareStatement("select first_name, last_name from user_table where user_id = ?;");
				pstm.setString(1, poster_id);
				
				ResultSet rs2 = pstm.executeQuery();
				String poster_name = poster_id;
				
				if(rs2.next())
				{
					poster_name = rs2.getString("first_name") + " " + rs2.getString("last_name");
				}
				
				System.out.println(title);
				
				request.setAttribute("top_title", title);
				request.setAttribute("top_image_path", image_path);
				request.setAttribute("top_poster_name", poster_name);
				request.setAttribute("top_article_id", article_id);
				
				flag = true;
			    
			}
			
			
			pstm = con.prepareStatement("select article_id, title, image_path, poster from article where tags like (?) order by post_date desc limit 4;");
    		pstm.setString(1, Utilities.LikeString("phone"));
			
			ResultSet rs_news = pstm.executeQuery();
			
			
			
			
			
			con.close();
			
			if(!flag)
			{
				pw.println("Doesn't exist!");

			}
			else
			{
				request.getRequestDispatcher("index.jsp").include(request, response);

			}
			
			}
		catch(Exception e) {System.out.println(e);}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		
		
		
	}

}
