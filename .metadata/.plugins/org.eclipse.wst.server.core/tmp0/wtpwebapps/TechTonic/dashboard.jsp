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
    <title>Dashboard</title>
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

                <h1 class="welcome" style="opacity:80%;">Welcome <% out.println(request.getAttribute("user")); %>!</h1>

				<div class="dashboard-button">
					<a href="index.html" class="btn bamboo"><i class="fa-solid fa-house"></i> &nbsp;Home</a>
				
					<a href="NewArticle" class="btn bamboo"><i class="fa-regular fa-plus"></i> &nbsp;New article</a>
					<a href="#YourArticle" class="btn bamboo" onclick="YourArticle()"><i class="fa-regular fa-newspaper"></i> &nbsp;Your Articles</a>
					<a href="#YourDetails" class="btn bamboo" onclick="YourDetails()"><i class="fa-solid fa-circle-info"></i> &nbsp;Your Details</a>


					<a href="Logout" class="btn red-button"><i class="fa-solid fa-right-from-bracket"></i> &nbsp;Logout</a>
				</div>
				
				
				<div class="your-articles" id="your-article">
					<h1>Your Articles</h1>
					<div class="your-article-empty">
						Woh! write some <a href="NewArticle">articles!</a>
					</div>
					
					
					
					<sql:query dataSource = "${news}" var = "article">
         				SELECT article_id, title from article where poster = <% out.println(request.getAttribute("user_id")); %> order by article_id desc;
     				</sql:query>
     				
       				<c:forEach var = "row" items = "${article.rows}">
     				
						<div class="row d-flex align-items-center" style="width: 100%;margin:0 auto">
							<div class="col-2 text-center  ">
								<div class="your-article-no">#<c:out value = "${row.article_id}"/></div>
							</div>
							<div class="col">
							<a class="no-decoration" href="Article?title=<c:out value = "${row.title}"/>&id=<c:out value = "${row.article_id}"/>" title="<c:out value = "${row.title}"/>">
								<div class="your-article-title"><c:out value = "${row.title}"/></div>
							</a>
							</div>
							
							<div class="col-1  text-center">
								<a class="no-decoration" title="Edit/Delete this Article" href="EditArticle?article_id=<c:out value = "${row.article_id}"/>"><i class="fa-solid fa-pen-to-square fa-lg"></i></a>
							</div>	
						</div>
					
					</c:forEach>
					
					
				</div>
				
				
				<div class="your-details" id="your-details">
					<hr>
					<h1>Your Details</h1>
					<div>
						<p><b>Name:</b> <% out.println(request.getAttribute("user")); %> <% out.println(request.getAttribute("last_name")); %></p>
						<p><b>Phone No:</b> <% out.println(request.getAttribute("phone")); %></p>
						<p><b>Email Id:</b> <% out.println(request.getAttribute("email")); %></p>
						<p><b>Gender:</b> <% out.println(request.getAttribute("gender")); %></p>
						<p><b>Date of Birth:</b> <% out.println(request.getAttribute("dob")); %></p>


					</div>
				</div>

        </div>
    </div>
    
    <div id="footer"></div>
    
    <script>
		function YourArticle()
		{
			document.getElementById("your-article").scrollIntoView();
		}
		
		function YourDetails()
		{
			document.getElementById("your-details").scrollIntoView();
		}
		
		function Empty()
		{
			var your_article = document.getElementById('your-article');

			if(your_article.childElementCount == 2)
			{
				your_article.children[1].style.display='block';
			}
		}
	</script>
</body>
</html>