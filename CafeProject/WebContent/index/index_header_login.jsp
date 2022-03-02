<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./../css/index.css?after" rel="stylesheet" type="text/css" />
</head>
<body>
	<div align="center" class="text-box">
			<span class="header-menu" onclick="changeView1(0)" >HOME</span>
			<span class="header-menu" onclick="changeView1(1)" >ABOUT US</span>
			<span class="header-menu" onclick="changeView1(2)" >MENU</span>
			<span class="header-menu" onclick="changeView1(3)" >Q&A</span>
			<span class="header-menu" onclick="changeView1(5)" >REVIEW</span>
	</div>

	<div class="logo-box">
		<a class="welcom-id" href="../index/index.jsp?contentPage=../cart/myCart.jsp"><%=session.getAttribute("id") %>님</span>
		<a class="mypage" href="./../mypage/mypage.jsp">MY PAGE</a>
	</div>
</body>
</html>