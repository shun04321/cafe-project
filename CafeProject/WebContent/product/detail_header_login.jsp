<!-- 인나현 -->

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title></title>
</head>
<body>
	<div align="center" class="text-box">
			<a class="detail-header-menu" href="./../index/index.jsp" >HOME</a>
			<a class="detail-header-menu" href="./../index/index.jsp" >ABOUT US</a>
			<a class="detail-header-menu" href="./../index/index.jsp?contentPage=./../product/menu.jsp" >MENU</a>
			<a class="detail-header-menu" href="../qanda/list.jsp" >Q&A</a>
			<a class="detail-header-menu" href="./../index/index.jsp?contentPage=../review/reviewList.jsp" >REVIEW</a>
	</div>

	<div class="logo-box">
		<a class="welcom-id" href="../index/index.jsp?contentPage=../cart/myCart.jsp"><%=session.getAttribute("id") %>님</a>
		<a class="mypage" href="./test.jsp">MY PAGE</a>
	</div>	
</body>
</html>