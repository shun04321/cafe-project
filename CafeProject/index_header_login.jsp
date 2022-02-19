<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center" class="text-box">
			<span class="header-menu" onclick="changeView1(0)" >HOME</span>
			<span class="header-menu" onclick="changeView1(1)" >ABOUT US</span>
			<span class="header-menu" onclick="changeView1(2)" >MENU</span>
			<span class="header-menu" onclick="changeView1(3)" >Q&A</span>		<!-- 바뀐 부분 -->
	</div>

	<div class="logo-box">
		<span class="welcom-id"><%=session.getAttribute("id") %>님 안녕하세요</span>
		<a class="mypage" href="./test.jsp">MY PAGE</a>
	</div>
</body>
</html>