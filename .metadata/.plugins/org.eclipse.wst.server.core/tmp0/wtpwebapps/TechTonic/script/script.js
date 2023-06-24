
    function mode(status)
    {
        var root = document.querySelector(':root');
        var label = document.getElementById("modeIcon");
    
        if (status=="dark")
        {
            const d = new Date();
            var exdays = 30;
            d.setTime(d.getTime() + (exdays*24*60*60*1000));
            var expires = "expires=" + d.toUTCString();

            root.style.setProperty('--bg-color', '#262626');
            root.style.setProperty('--text-color', 'white');
            root.style.setProperty('--shadow-color', 'rgba(255, 255, 255, 0.455)');
            document.cookie = "Mode=dark;" + expires + ";path=/";
            label.innerHTML = '<i class="fa-solid fa-sun fa-lg"></i>';
        }

        else{
            root.style.setProperty('--shadow-color', 'rgba(0, 0, 0, 0.455)');
            document.cookie = "Mode=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            root.style.setProperty('--bg-color', '#ffffff');
            root.style.setProperty('--text-color', 'black');
            label.innerHTML = '<i class="fa-solid fa-moon fa-lg"></i>';
        }
    }

    function changeMode(checkbox)
    {

        if(checkbox.checked == true) {
            mode("dark");
        }
        else
        {
            mode("light");
        }
    }

    function getCookie(cname) {
        let name = cname + "=";
        let ca = document.cookie.split(';');
        for(let i = 0; i < ca.length; i++) {
          let c = ca[i];
          while (c.charAt(0) == ' ') {
            c = c.substring(1);
          }
          if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
          }
        }
        return "";
      }

    function checkMode()
    {
		var toggle = document.getElementById("mode");
        var status = getCookie("Mode");
        if (status == "dark") {
            mode("dark");
            toggle.checked = true;
            console.log(toggle.checked);
        } 
    }

    


    window.onpaint = checkMode();
    
    
    
      function checkLogin(){
      var login_dashboard = document.getElementById("login-dashboard");
      var user = getCookie("UID");
      if(user!="")
      {
          console.log("Logged in");
          login_dashboard.href = "Dashboard";
          login_dashboard.innerHTML = "Profile";
      }
      else
      {
          console.log("Not logged in");
          login_dashboard.href = "Login";
          login_dashboard.innerHTML = "Log in";
      }
  }
  
  window.onpaint = checkLogin();



  $(document).on("scroll", function() {
    var pageTop = $(document).scrollTop();
    var pageBottom = pageTop + $(window).height();
    var tags = $(".scroll");
  
    for (var i = 0; i < tags.length; i++) {
      var tag = tags[i];
      if ($(tag).position().top < pageBottom) {
        $(tag).addClass("visible");
      } else {
        $(tag).removeClass("visible");
      }
    }
  });



  function articleLimit()
    {
        var upper_limit = 5000, lower_limit = 100;
        var chars = document.getElementById("article").value;
        var articleWordCount = document.getElementById("article-limit");
        articleWordCount.innerHTML = chars.length + " / " + upper_limit;

        if(chars.length > upper_limit || chars.length < lower_limit)
        {
            articleWordCount.style.color = "red";
        }
        else
        {
            articleWordCount.style.color = "green";

        }

    }

    function titleLimit()
    {
        var upper_limit = 200, lower_limit = 10;
        var chars = document.getElementById("title").value;
        var titleWordCount = document.getElementById("title-limit");
        titleWordCount.innerHTML = chars.length + " / " + upper_limit;

        if(chars.length > upper_limit || chars.length < lower_limit)
        {
            titleWordCount.style.color = "red";
        }
        else
        {
            titleWordCount.style.color = "green";

        }

    }


    var loadFile = function(event) {
        var image = document.getElementById('output');
        var image2 = document.getElementById('output2');
        image.src = URL.createObjectURL(event.target.files[0]);
        image2.src = URL.createObjectURL(event.target.files[0]);
    };


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



 