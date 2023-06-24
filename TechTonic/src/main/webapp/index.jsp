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


        window.addEventListener("scroll", scroll);
		function scroll() {


			var pageTop = $(document).scrollTop();
			var pageBottom = pageTop + $(window).height();
			
			var tags = $(".appear");


		  
			for (var i = 0; i < tags.length; i++) {
			  var tag = tags[i];
			  if ($(tag).position().top.toFixed(0) < pageBottom) {
				$(tag).addClass("visible");


			  } else  {
				$(tag).removeClass("visible");
			  }
			}
		  }
		
	      
		
	      function checkLogin1(){
	      var login_dashboard = document.getElementById("msg-link");
	      var the_msg = document.getElementById("msg");

	      var user = getCookie("UID");
	      if(user!="")
	      {
	          login_dashboard.href = "Dashboard";
	          the_msg.innerHTML = "Write and publish articles with us.";
	      }
	      else
	      {
	          login_dashboard.href = "Login";
	          the_msg.innerHTML = "Write and publish your first article with us.";
	      }
	  }
	      
	      window.onload = function() {
	    	  checkLogin1();
	    	}		
	</script>


    
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TechTonic</title>
    <link rel="icon" href="imgs/tech.png">
    	
   
</head>
<body oninit="checkLogin1()">


<sql:setDataSource var = "news" driver = "com.mysql.jdbc.Driver"
         url = "jdbc:mysql://localhost:3306/news"
         user = "root"  password = "abcd"/>



    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    
    <div class="font">
		<div class="container-fluid">
			<div id="header"></div>
			    <link rel="stylesheet" href="styles/style.css">
			    <div class="header-spacing"></div>
			    
			    
			    <div class="top-bg">
			        <h1>Top News</h1>
			        
			        <sql:query dataSource = "${news}" var = "result">
         			SELECT article_id, title, image_path, poster from article order by post_date desc limit 1;
     			</sql:query>
			        
			        <br>
			        <c:forEach var = "row" items = "${result.rows}">
			        <a class="no-decoration" href="Article?title=<c:out value = "${row.title}"/>&id=<c:out value = "${row.article_id}"/>" title="<c:out value = "${row.title}"/>">
					
     				
			        <div class="top-news">
			            <div class="row" style="margin:auto">
			                <div class="col-md-4" >
			                    <img src="<c:out value = "${row.image_path}"/>" class="img-fluid top-img" style="margin:auto">
			                </div>
			                    <div class="col-md" >
			                        <h1 class="top-news-title justify-content-center"><c:out value = "${row.title}"/></h1>
			                        <!--  <p class="top-news-poster"></p>-->
			                        <sql:query dataSource = "${news}" var = "user">
         				SELECT * from user_table where user_id = <c:out value = "${row.poster}"/>;
     				</sql:query>
     				<c:forEach var = "row" items = "${user.rows}">
     					<p class="top-poster"><c:out value = "${row.first_name}"/> <c:out value = "${row.last_name}"/></p>
     				</c:forEach>
			
			                </div>
			            </div>
			        </div>
			        </c:forEach>
			        
			        </a>
			    </div>
			    
			    
    <h3 class="sub-category" >Popular categories</h3>

    <div class="row" style="margin:auto;">
        <div class="col-md" >
            <div class="news-container appear">
            <sql:query dataSource = "${news}" var = "result">
         			select * from article where tags like "%,phone,%" and article_id not in (select max(article_id) from news.article) order by post_date desc limit 4;
     			</sql:query>
                <a href="Tag?tag=phone" class="no-decoration">
                <div class="news-category">#Phone <i class="fa-solid fa-chevron-right fa-xs"></i></div>
                </a>
                <ul>
                <c:forEach var = "row" items = "${result.rows}">
                
                <li>
                <a class="no-decoration" href="Article?title=<c:out value = "${row.title}"/>&id=<c:out value = "${row.article_id}"/>" title="<c:out value = "${row.title}"/>">
                <div class="news">
                    <div class="row" style="margin:auto;">
                        <div class="col-5" >
                            <div class="news-image-container">
                            <img src="<c:out value = "${row.image_path}"/>" class="img-fluid news-img">
                            </div>
                        </div>
                            <div class="col" >
                                <div class="news-title" max-length="10"><c:out value = "${row.title}"/></div>
                            </div>
                    </div>
                </div>
                </a>
                </li>

            </ul>
            </c:forEach>
            
            
            
        </div>
        </div>
        <div class="col-md" >
            <div class="news-container appear">
            <sql:query dataSource = "${news}" var = "result">
         			select * from article where tags like "%,pc,%" and article_id not in (select max(article_id) from news.article) order by post_date desc limit 4;
     			</sql:query>
                <a href="Tag?tag=pc" class="no-decoration">
                <div class="news-category">#PC <i class="fa-solid fa-chevron-right fa-xs"></i></div>
                </a>
                <ul>
                <c:forEach var = "row" items = "${result.rows}">
                
                <li>
                <a class="no-decoration" href="Article?title=<c:out value = "${row.title}"/>&id=<c:out value = "${row.article_id}"/>" title="<c:out value = "${row.title}"/>">
                <div class="news">
                    <div class="row" style="margin:auto;">
                        <div class="col-5" >
                            <div class="news-image-container">
                            <img src="<c:out value = "${row.image_path}"/>" class="img-fluid news-img">
                            </div>
                        </div>
                            <div class="col" >
                                <div class="news-title" max-length="10"><c:out value = "${row.title}"/></div>
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
    
    
    
        <div class="row" style="margin:auto">
          <div class="col-md" >
            <div class="news-container appear">
            <sql:query dataSource = "${news}" var = "result">
         			select * from article where tags like "%,audio,%" and article_id not in (select max(article_id) from news.article) order by post_date desc limit 4;
     			</sql:query>
                <a href="Tag?tag=audio" class="no-decoration">
                <div class="news-category">#Audio <i class="fa-solid fa-chevron-right fa-xs"></i></div>
                </a>
                <ul>
                <c:forEach var = "row" items = "${result.rows}">
                
                <li>
                <a class="no-decoration" href="Article?title=<c:out value = "${row.title}"/>&id=<c:out value = "${row.article_id}"/>" title="<c:out value = "${row.title}"/>">
                <div class="news">
                    <div class="row" style="margin:auto;">
                        <div class="col-5" >
                            <div class="news-image-container">
                            <img src="<c:out value = "${row.image_path}"/>" class="img-fluid news-img">
                            </div>
                        </div>
                            <div class="col" >
                                <div class="news-title" max-length="10"><c:out value = "${row.title}"/></div>
                            </div>
                    </div>
                </div>
                </a>
                </li>

            </ul>
            </c:forEach>
            
            
           
        </div>
        </div>

             <div class="col-md" >
            <div class="news-container appear">
            <sql:query dataSource = "${news}" var = "result">
		select * from article where tags like "%,stocks,%" and article_id not in (select max(article_id) from news.article) order by post_date desc limit 4;     			</sql:query>
                <a href="Tag?tag=stocks" class="no-decoration">
                <div class="news-category">#Stocks <i class="fa-solid fa-chevron-right fa-xs"></i></div>
                </a>
                <ul>
                <c:forEach var = "row" items = "${result.rows}">
                
                <li>
                <a class="no-decoration" href="Article?title=<c:out value = "${row.title}"/>&id=<c:out value = "${row.article_id}"/>" title="<c:out value = "${row.title}"/>">
                <div class="news">
                    <div class="row" style="margin:auto;">
                        <div class="col-5" >
                            <div class="news-image-container">
                            <img src="<c:out value = "${row.image_path}"/>" class="img-fluid news-img">
                            </div>
                        </div>
                            <div class="col" >
                                <div class="news-title" max-length="10"><c:out value = "${row.title}"/></div>
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
    
    
    <div class="row" style="margin:auto">
          <div class="col-md" >
            <div class="news-container appear appear">
            <sql:query dataSource = "${news}" var = "result">
         			select * from article where tags like "%,gaming,%" and article_id not in (select max(article_id) from news.article) order by post_date desc limit 4;
     			</sql:query>
                <a href="Tag?tag=gaming" class="no-decoration">
                <div class="news-category">#Gaming <i class="fa-solid fa-chevron-right fa-xs"></i></div>
                </a>
                <ul>
                <c:forEach var = "row" items = "${result.rows}">
                
                <li>
                <a class="no-decoration" href="Article?title=<c:out value = "${row.title}"/>&id=<c:out value = "${row.article_id}"/>" title="<c:out value = "${row.title}"/>">
                <div class="news">
                    <div class="row" style="margin:auto;">
                        <div class="col-5" >
                            <div class="news-image-container">
                            <img src="<c:out value = "${row.image_path}"/>" class="img-fluid news-img">
                            </div>
                        </div>
                            <div class="col" >
                                <div class="news-title" max-length="10"><c:out value = "${row.title}"/></div>
                            </div>
                    </div>
                </div>
                </a>
                </li>

            </ul>
            </c:forEach>
            
            
           
        </div>
        </div>

             <div class="col-md" >
            <div class="news-container appear">
            <sql:query dataSource = "${news}" var = "result">
		select * from article where tags like "%,socials,%" and article_id not in (select max(article_id) from news.article) order by post_date desc limit 4;     			</sql:query>
                <a href="Tag?tag=socials" class="no-decoration">
                <div class="news-category">#Socials <i class="fa-solid fa-chevron-right fa-xs"></i></div>
                </a>
                <ul>
                <c:forEach var = "row" items = "${result.rows}">
                
                <li>
                <a class="no-decoration" href="Article?title=<c:out value = "${row.title}"/>&id=<c:out value = "${row.article_id}"/>" title="<c:out value = "${row.title}"/>">
                <div class="news">
                    <div class="row" style="margin:auto;">
                        <div class="col-5" >
                            <div class="news-image-container">
                            <img src="<c:out value = "${row.image_path}"/>" class="img-fluid news-img">
                            </div>
                        </div>
                            <div class="col" >
                                <div class="news-title" max-length="10"><c:out value = "${row.title}"/></div>
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
		
	</div>

    <a href="Tag?tag=all" class="no-decoration">
        <div class="see-all appear">
            All News&nbsp;<i class="fa-solid fa-chevron-right fa-xs"></i>
        </div>
    </a>
    <br>

    <hr width="90%" class="hr appear">

    <div class="follow-social appear">
        <h1>Follow us on Social media...</h1>
        <ul>
            <li><a href="https://www.instagram.com/anindyakbiswas5/" class="no-decoration"><i class="fa-brands fa-instagram fa-2xl"></i></a></li>
            <li><a href="https://www.facebook.com/Anindya.handy/" class="no-decoration"><i class="fa-brands fa-facebook fa-2xl"></i></a></li>
            <li><a href="https://twitter.com/ANINDYAKBISWAS" class="no-decoration"><i class="fa-brands fa-twitter fa-2xl"></i></a></li>
            <li><a href="https://www.reddit.com/r/CalcuttaUniversity/" class="no-decoration"><i class="fa-brands fa-reddit fa-2xl"></i></a></li>
        </ul>
    </div>

    <a href="#" id ="msg-link" class="no-decoration">
    <div class="index-message appear" >
        <h1>Become a Publisher!</h1>
        <p id="msg">Write and publish your first article with us.</p>
    </div>
    </a>

	</div>
	    <div id="footer"></div>
	
	
	
</body>
<script>
	$(document).ready(function(){
		  
        $('.news-title').each(function (f) {
      
            var newstr = $(this).text().substring(0,50);
            $(this).text(newstr);
      
          });
      })
      
      
	</script>
</html>