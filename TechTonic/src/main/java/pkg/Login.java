package pkg;

import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//request.setAttribute("wrong_password", "hidden");
	   	//request.setAttribute("wrong_email", "hidden");

    	request.getRequestDispatcher("login.html").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ServletContext context=getServletContext();
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html");

		request.setAttribute("wrong_email", "hidden");

		String email = request.getParameter("email");
		String password  = request.getParameter("password");
		
		
		
		System.out.println(email);
		System.out.println(password);
		
		if(email!=null || password!=null)
		{
			try {
				Connection con;
				PreparedStatement pstm;
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/news", "root", Utilities.DB_pwd); //DriverManager is a class 
				
				
				
				pstm = con.prepareStatement("select user_id, email, password, first_name, last_name, phone, dob, gender from user_table where email = ?;");
				pstm.setString(1, email);
				
				ResultSet rs = pstm.executeQuery();
				
				if(rs.next())
				{
					String generatedSecuredPasswordHash = generateStrongPasswordHash(password);
					System.out.println("From input: " + generatedSecuredPasswordHash);
					System.out.println("From db: " + rs.getString("password"));
	
					if(generatedSecuredPasswordHash.equals(rs.getString("password")))
					{
						
						//Cookies
						Cookie ck  =new Cookie("UID", rs.getString("user_id"));
						ck.setMaxAge(60 * 60 * 24 * 10);
						response.addCookie(ck);
						pw.print("success");

						
						/*
						//Converting dob to a suitable date format
						Date dob = rs.getDate("dob");
						String dob1 = new SimpleDateFormat("dd-MM-yyyy").format(dob);  
						
						//Post log in page
					   	request.setAttribute("first_name", rs.getString("first_name"));
					   	request.setAttribute("last_name", rs.getString("last_name"));
					   	request.setAttribute("phone", rs.getString("phone"));
					   	request.setAttribute("dob", dob1);
					   	request.setAttribute("gender", rs.getString("gender"));
					   	request.setAttribute("address", rs.getString("address"));
					   	request.setAttribute("email", rs.getString("email"));
	
				    	*/
						System.out.println("Success!");
				    	request.getRequestDispatcher("Dashboard").forward(request, response);

	
	
					}
					else
					{
						pw.write("wrong_pwd");
	
						System.out.println("Wrong Password!");
	
					}
				}
				else
				{
					pw.print("wrong_email");
	
					System.out.println("Email not present!");
				}
				
				con.close();

				
			
			}catch(Exception e) {System.out.println(e);}
		}
		
		
		
	}

	private static String generateStrongPasswordHash(String password)throws NoSuchAlgorithmException, InvalidKeySpecException
		{
		    int iterations = 1000;
		    char[] chars = password.toCharArray();
		    byte[] salt = "[B@76ed5528".getBytes();
		    PBEKeySpec spec = new PBEKeySpec(chars, salt, iterations, 64 * 8);
		    SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		    byte[] hash = skf.generateSecret(spec).getEncoded();
		    return iterations + ":" + toHex(salt) + ":" + toHex(hash);
		}
	
		private static String toHex(byte[] array) throws NoSuchAlgorithmException
		{
		    BigInteger bi = new BigInteger(1, array);
		    String hex = bi.toString(16);
		    int paddingLength = (array.length * 2) - hex.length();
		    if(paddingLength > 0)
		    {
		        return String.format("%0"  +paddingLength + "d", 0) + hex;
		    }else{
		        return hex;
		    }
		}
}