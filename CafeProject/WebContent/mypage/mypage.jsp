<!-- 정민지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./../css/mypage.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div id="title"><h1><%=session.getAttribute("id") %>님의 마이페이지</h1></div>
<hr id="hr">

	<ul class="img-ul">
		<li class="img-li">
			<div class="prof">
				<a href="./../mypage/modify.jsp"><img src="./../images/profile.png" id="img"></a><br>
				<h3>회원정보 수정</h3>
			</div>
		</li>	
		<li class="img-li">
			<div class="prof">
				<a href="./../mypage/list.jsp"><img src="./../images/note.png" id="img"></a><br>
				<h3>게시물 목록</h3>
			</div>
		</li><br>
		<li class="img-li">
			<div class="prof">
				<a href="./../mypage/list2.jsp"><img src="./../images/box.png" id="img"></a><br>
				<h3>주문내역 조회</h3>
			</div>
		</li>
				<li class="img-li">
			<div class="prof">
				<a href="./../cart/cart.jsp"><img src="./../images/bag.png" id="img"></a><br>  <!-- 수정 요함 -->
				<h3>장바구니</h3>
			</div>
		</li>
	</ul>




<div align="center"><input id="logout" type="button" value="SIGN OUT" onclick="location.href='../login/logout.jsp'"></div>



</body>
</html>
