<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.project.dto.*" %>
<%@ page import="com.project.dao.*" %>

<%
	String id = (String)session.getAttribute("id");
	if(id==null){
		pageContext.forward("../login/login.jsp");
	}
	
	// order_detail 테이블에서 로그인한 유저 아이디와 같은 행의 write_review가 0인 레코드가 있는지 검사
	//(없으면 reviewList.jsp로 이동 / 있으면 여러개의 product_id 중 하나 선택해서 폼 작성할 수 있도록 하기)
	OrderDAO order_dao = new OrderDAO();
	int flag = order_dao.isBought(id);
	
	if(flag==-1 || flag==0){
%>
	<script>
		alert('리뷰를 작성할 수 없습니다.');
		history.back();
	</script>
<%
	}
	
	List<OrderDetailDTO> list = new ArrayList<OrderDetailDTO>();
	list = order_dao.orderList(id); // write_review 0인 주문들 반환
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<style>
	.chooseProduct{
	 height: 150px;
	}
	
	.selectProduct{
		font-size: 20px;
		font-weight: bold;
		color: #325446;
	}
</style>
<body>
	<center>
	<div class="chooseProduct">
	<br>
		<p class="selectProduct">리뷰를 작성할 상품을 선택하세요 :)</p><br>
	<form name="chooseProduct" method="post" action="../index/index.jsp?contentPage=../review/reviewForm.jsp">
		<select name="product" style="width:200px;height:30px;">
			<%
				int orderId=0;
				for(OrderDetailDTO o : list){
					String productName = order_dao.findProductName(o.getProductID());
					out.println("<option>" + productName + "</option>"); 	
				}
			%>
		</select>
		<input type="submit" value="리뷰작성">
	</form>
	</div>
	</center>
</body>
</html>