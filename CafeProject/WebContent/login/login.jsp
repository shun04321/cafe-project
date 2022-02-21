<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>

<style>
	 header{
                display:flex;
                justify-content: center;
            }
     form{
                padding:10px;
            }
            .input-box{
                position:relative;
                margin:10px 0;
            }
            .input-box > input{
                background:transparent;
                border:none;
                border-bottom: solid 1px #ccc;
                padding:20px 0px 5px 0px;
                font-size:14pt;
                width:100%;
            }
            input::placeholder{
                color:transparent;
            }
            input:placeholder-shown + label{
                color:#aaa;
                font-size:14pt;
                top:15px;
            }
            input:focus + label, label{
                color:#8aa1a1;
                font-size:10pt;
                pointer-events: none;
                position: absolute;
                left:0px;
                top:0px;
                transition: all 0.2s ease ;
                -webkit-transition: all 0.2s ease;
                -moz-transition: all 0.2s ease;
                -o-transition: all 0.2s ease;
            }
            input:focus, input:not(:placeholder-shown){
                border-bottom: solid 1px #8aa1a1;
                outline:none;
            }
            input[type=submit]{
                background-color: black;
                border:none;
                color:white;
                border-radius: 5px;
                width:100%;
                height:35px;
                font-size: 14pt;
                margin-top:100px;
            }
            
             #forgot{
                text-align: center;
                font-size:12pt;
                color:rgb(164, 164, 164);
                margin:10px 0px;
            }
     	a{
     			text-align: center;
                font-size:12pt;
                color:rgb(164, 164, 164);
                margin:10px 0px;
     }
    
	</style>
	
	  <script>
	  
	  function checkValue() {
          
		  loginForm = eval("document.login_form");
          
		  if(!loginForm.id.value) {
              alert("아이디를 입력하세요");    
              loginForm.id.focus();
              return false;
          }
		  
          if(!loginForm.password.value) {
              alert("비밀번호를 입력하세요");    
              loginForm.password.focus();
              return false;
          }
      } 
    
    </script>
</head>
<body>
<form name="login_form" action="login_action.jsp" onsubmit="return checkValue();" method="post">
 
            <header>
            <h1>SIGN IN</h1>
        </header>
        
  

            <div class="input-box">
                <input id="username" type="text" name="id" placeholder="ID">
                <label for="username">ID</label>
            </div>

            <div class="input-box">
                <input id="password" type="password" name="password" placeholder="Password">
                <label for="password">Password</label>
            </div>
            
           
            <input type="submit" value="SIGN IN">
            
            <div id="forgot">Forgot your password? <p>
            
            <a href ="member.jsp" style="text-decoration:none">SIGN UP</a>
            </div>

</form>

</body>
</html>