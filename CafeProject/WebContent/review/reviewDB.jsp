<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.project.dto.*" %>
<%@ page import="com.project.dao.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8"); 
	String userId = (String)session.getAttribute("id");
	
	try{
		ReviewDTO review_dto = new ReviewDTO();
		ReviewDAO review_dao = new ReviewDAO();
		OrderDAO order_dao = new OrderDAO();
		ProductDAO product_dao = new ProductDAO();
		Timestamp writeData = new Timestamp(System.currentTimeMillis());
		
		String productName = request.getParameter("productName"); // 상품이름
		int productId = product_dao.findProductID(productName); // 상품번호
		int orderId = order_dao.findOrderID(userId, productId); // 주문번호(같은 상품을 여러 번 주문했을 때엔 order_id가 작은 것을 반환)
		String reviewContent = request.getParameter("reviewContent"); // 리뷰내용
		int grade = Integer.parseInt(request.getParameter("rating")); // 별점
		
		review_dto.setOrderID(orderId);
		review_dto.setProductID(productId);
		review_dto.setReview_content(reviewContent);
		review_dto.setDate(writeData);
		review_dto.setGrade(grade);
		
		review_dao.write(review_dto, userId); // 리뷰 등록 메소드
		review_dao.changeStatus(orderId, userId,productId);
	}catch(Exception e){
		System.out.println(e);
	}
%>
	<script>
      	alert("리뷰 작성 성공");
      	self.close();
      	window.location.href="../index/index.jsp?contentPage=../review/reviewList.jsp";
    </script>
</body>
</html>