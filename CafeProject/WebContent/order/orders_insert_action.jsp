
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	request.setCharacterEncoding("utf-8");

	CartDAO cart_dao = new CartDAO();
	OrderDAO order_dao = new OrderDAO();
	OrderDTO order_dto = new OrderDTO();
	OrderDetailDTO order_detail_dto = new OrderDetailDTO();
	
	String user_id = (String)session.getAttribute("id");
	String[] productId = request.getParameterValues("productId");
	String[] productQty = request.getParameterValues("productQty");
	
	for(int i=0; i<productId.length; i++){
		int order_id = order_dao.getNext();
		String order_date = order_dao.getDate();
		order_dto.setOrderID(order_id);
		order_dto.setUserID(user_id);
		order_dto.setOrderDate(order_date);

		order_dao.insertOrder(order_dto);
		
		order_detail_dto.setUserID(user_id);
		order_detail_dto.setOrderID(order_id);
		order_detail_dto.setProductID(Integer.parseInt(productId[i]));
		order_detail_dto.setDetailNUM(Integer.parseInt(productQty[i]));
		order_detail_dto.setWriteREVIEW(0);
		
		order_dao.insertOrderDetail(order_detail_dto);
		cart_dao.CartDelete(user_id, Integer.parseInt(productId[i]));  // 장바구니에서 해당 메뉴 삭제
	}	
%>
<script>
      	alert("곧 제품을 준비해 드리겠습니다:)");
      	location.href="../index/index.jsp?contentPage=./../product/menu.jsp";
</script>
</body>
</html>

