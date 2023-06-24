<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <script src="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/md5.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.js"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.js"
			integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
			crossorigin="anonymous">
	</script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<script>
		$(function () {
			$("#header").load("header.html");
			$("#footer").load("footer.html");
		});	
		
	</script>


 
 
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TechTonic</title>
    <link rel="icon" href="imgs/tech.png">
    	
   
</head>
<body onload="Empty()">

<sql:setDataSource var = "news" driver = "com.mysql.jdbc.Driver"
         url = "jdbc:mysql://localhost:3306/news"
         user = "root"  password = "abcd"/>



    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    
    <div class="font">
		<div class="container-fluid">
			<div id="header"></div>
			    <link rel="stylesheet" href="styles/style.css">
			    <div class="header-spacing"></div>
			    <br>
                <div class="tag-news-category"><i class="fa-solid fa-chevron-right fa-xs"></i>&nbsp;#<% out.println(request.getAttribute("tag")); %></div>

                <div class="tag-news-container">


				<sql:query dataSource = "${news}" var = "user">
         				SELECT * from article <% out.println(request.getAttribute("query")); %> order by post_date desc;
     				</sql:query>
     				<c:forEach var = "row" items = "${user.rows}">
                        
                        <ul>
                        
                        <li>
                        <a class="no-decoration" href="Article?title=<c:out value = "${row.title}"/>&id=<c:out value = "${row.article_id}"/>" title="<c:out value = "${row.title}"/>">
                        <div class="tag-news">
                            <div class="row" style="margin:auto;">
                                <div class="col-4" >
                                    <div class="news-image-container">
                                    <img src="<c:out value = "${row.image_path}"/>" class="img-fluid news-img">
                                    </div>
                                </div>
                                    <div class="col" >
                                        <h4 class="tag-news-title"><c:out value = "${row.title}"/></h4>
                                    </div>
                            </div>
                        </div>
                        </a>
                        </li>

        
                    </ul>
                    
                    </c:forEach>
                    
                    
                    
                    
                </div>
		
	    </div>
	</div>
	
	<div id="footer">></div>
	
	
</body>

<script>
	$(document).ready(function(){
		  
        $('.news-title').each(function (f) {
      
            var newstr = $(this).text().substring(0,50);
            $(this).text(newstr);
      
          });
      })

      function Empty()
      {
        var news_container = document.getElementsByClassName("tag-news-container")[0];
        if(news_container.childElementCount == 0)
        {
            news_container.innerHTML = "<h1>This looks empty!</h1>";
        }
      }
	</script>

</html>