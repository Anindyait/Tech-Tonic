package pkg;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Search
 */
@WebServlet("/Tag")
public class Tag extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Tag() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		ServletContext context=getServletContext();
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html");
		
		String tag = request.getParameter("tag");
		
		request.setAttribute("tag", tag.substring(0, 1).toUpperCase() + tag.substring(1));

		
		String tag_string = Utilities.TagString(tag);
		
		System.out.println(tag_string);
		
		if(tag.equals("others") || tag.equals("all"))
			request.setAttribute("query", " ");
		else
			request.setAttribute("query", "where tags like " + tag_string);

		request.getRequestDispatcher("tags.jsp").include(request, response);

		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
