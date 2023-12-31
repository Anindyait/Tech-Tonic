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
    <title>Article</title>
    <link rel="icon" href="imgs/tech.png">
    	
   
</head>
<body>



    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    
    <div class="font">
		<div class="container-fluid">
			<div class="error-container">
			<div id="header"></div>
			    <link rel="stylesheet" href="styles/style.css">
                <div class="header-spacing"></div>

                <h1 class="oops"><i class="fa-regular fa-face-sad-tear"></i>&nbsp;Oops!</h1>
				<h2 class="error-message"><% out.println(request.getAttribute("error_msg")); %></h2>


        	</div>
		</div>
		<div id="footer"></div>
    </div>
</body>
</html>