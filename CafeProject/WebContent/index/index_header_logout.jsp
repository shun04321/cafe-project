<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
</head>
<body>
	<div class="text-box">
		<span class="header-menu" onclick="changeView1(0)">HOME</span>
		<span class="header-menu" onclick="changeView1(1)">ABOUT US</span>
		<span class="header-menu" onclick="changeView1(2)">MENU</span>
		<span class="header-menu" onclick="changeView1(4)">Q&A</span>
		<span class="header-menu" onclick="changeView1(5)">REVIEW</span>
	</div>
	
	<div class="logo-box">
		<a class="cart"><img class="cart-log" alt="shopping cart" src="./../images/shopping_cart.png" class="cart-log" style="cursor: pointer;" onclick="alert('로그인이 필요한 서비스입니다 :)');"></a>
		<a class="man" href="./../login/login.jsp"><img alt="man" src="./../images/man.png" class="man-log"></a>
	</div>
</body>
</html>