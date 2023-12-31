package pkg;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


/**
 * Servlet implementation class NewArticle
 */
@WebServlet("/NewArticle")
@MultipartConfig(
		  fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
		  maxFileSize = 1024 * 1024 * 10,      // 10 MB
		  maxRequestSize = 1024 * 1024 * 100   // 100 MB
		)
public class NewArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewArticle() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
    	request.getRequestDispatcher("newArticle.html").include(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		ServletContext context=getServletContext(); 
		response.setContentType("text/html");
		PrintWriter pw = response.getWriter();
		

		
		//getting values from input fields
		String title = request.getParameter("title");
		String article = request.getParameter("article");
		String tags = request.getParameter("tags");
		String user_id = Utilities.GetUID(request);

		
		Part filePart = request.getPart("file");
	    String fileName = filePart.getSubmittedFileName();
	    
	    fileName = generateUniqueFileName(fileName);
	    
	    //path to store in DB
	    String path = "imgs\\article_images" + File.separator + fileName;

	    //storing image in the system
	    filePart.write("E:\\Programs\\Tech Tonic\\TechTonic\\src\\main\\webapp\\imgs\\article_images\\" + File.separator + fileName);
	    System.out.println(fileName);
	    
	    //seperating tags by comas
	    String formatted_tags="";
	    tags = tags.replaceAll("\\s", "").toLowerCase();
		String[] tokens=tags.split("#");  
	    for(int i=1;i<tokens.length;i++)
			formatted_tags = formatted_tags + "," + tokens[i] + ","; 
	    
	    
	    //Getting current time
	    LocalDateTime myDateObj = LocalDateTime.now();  
	    DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
	    String formattedDate = myDateObj.format(myFormatObj);  
	    System.out.println(formattedDate); 
	    
	    
	    
	    System.out.println(title);
	    System.out.println(article);
	    System.out.println(tags);
	    System.out.println("UID = " + user_id);
	    
	    try 
		{
			Connection con;
			PreparedStatement pstm; 			       //class to prepare statement
			
			Class.forName("com.mysql.cj.jdbc.Driver"); //Class is a class
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/news", "root", Utilities.DB_pwd); //DriverManager is a class 
														//jdbc:mysql then ip address then port no. then db name
													

			Statement stmt = con.createStatement();
			
			
			pstm = con.prepareStatement("select title from article where title = ?;");
			pstm.setString(1, title);
			ResultSet rs_title = pstm.executeQuery();
			
			if(!rs_title.next())
			{
				pstm  = con.prepareStatement("insert into article "
						+ "(title, body, tags, post_date, image_path, poster) "
						+ "values(?, ?, ?, ?, ?, ?)");
				pstm.setString(1, title); 					
				pstm.setString(2, article); 
				pstm.setString(3, formatted_tags); 
				pstm.setString(4, formattedDate);
				pstm.setString(5, path);
				pstm.setString(6, user_id);

				
				pstm.executeUpdate();
				
		    	request.getRequestDispatcher("postArticle.html").include(request, response);


			}
			
			
		}catch(Exception e) {System.out.println(e);}
	    
	    


}
	
	private String generateUniqueFileName(String originalFileName) {
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String uniqueID = UUID.randomUUID().toString();
        return uniqueID + extension;
    }


}
