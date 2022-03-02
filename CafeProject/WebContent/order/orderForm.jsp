<!-- 인나현 -->

<%@page import="com.project.dto.ProductDTO"%>
<%@page import="com.project.dao.ProductDAO"%>
<%@page import="com.project.dto.UserDTO"%>
<%@page import="com.project.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	UserDAO user_dao = new UserDAO();
	ProductDAO product_dao = new ProductDAO();

	String user_id = (String)session.getAttribute("id");
	UserDTO user_dto = user_dao.getUserInfo(user_id);
	
	String product_id = request.getParameter("product_id");
	ProductDTO product_dto = product_dao.getProduct(Integer.parseInt(product_id));
	
	String menu_qty = request.getParameter("menu_qty");
	int qty = Integer.parseInt(menu_qty);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oder Form</title>
<link href="./../css/order.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div class="oder-form-container" width=100% align="center">
	<form action="./order_insert_action.jsp" method="post">
	
		<input type="hidden" name="product_id" value="<%=product_dto.getProductID()%>"> 
	
		<div class="oder-info-box">
			<h2>주문 내역</h2>
			<hr class="hr_1">
	
			<table class="order-info-table" >
				<tr>
					<td class="order-info-td"><img class="oder-menu-img" alt="menu-img" src="./../images/<%=product_dto.getProductIMG() %>"></td>
					<td class="order-info-td"><%=product_dto.getProductNAME() %></td>
					<td class="order-info-td"><%=product_dto.getProductPRICE() %></td>
					<td class="order-info-td"><%=qty%>개<input type="hidden"  name="menu_qty" value="<%=qty%>"></td>
					<td class="order-info-td"><%=product_dto.getProductPRICE() * qty %></td>
				</tr>
			</table>
		
		</div>		
	
		<div class="oderer-info-box">
			<h2>주문자 정보</h2>
			<hr class="hr_1">
			
			<table class="orderer-info-table">
				<tr>
					<td class="orderer-info-td">이름</td>
					<td><input type="text" name="user_id" value="<%=user_dto.getUserName()%>"></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td class="orderer-info-td">전화번호</td>
					<td><input type="text" name="user_phone" value="<%=user_dto.getUser_phone()%>"></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td class="orderer-info-td">주소</td>
					<td><input type="text" name="user_address" value="<%=user_dto.getUser_address()%>"></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
			</table>
		</div>
		
		<div class="pay-box">
			<h2>결제 정보</h2>
			<hr class="hr_1">
			
			<table class="pay-table">
				<tr>
					<td colspan="4"><hr class="hr_2"></td>
				</tr>
				<tr>
					<td>총 주문 개수</td>
					<td>전자 영수증 발행</td>
					<td>배송비</td>
					<td>총 결제 예상 금액</td>
				</tr>
				<tr>
					<td colspan="4"><hr class="hr_2"></td>
				</tr>
				<tr>
					<td><%=qty %>개</td>
					<td><%=user_dto.getUser_email() %></td>
					<td>2500원</td>
					<td><%=product_dto.getProductPRICE() * qty + 2500 %>원</td>
				</tr>
			</table>
		</div>
		
		<div class="btn-box">
			
			<table class="bin-table">
				<tr>
					<td height="30" align="left"><a href="../index/index.jsp?contentPage=./../product/menu.jsp" class="menu">MENU</a></td>
					<td height="30" align="right"><input type="button" class="back" value="BACK" onclick="javascript: history.back();"></td>
				</tr>
			</table>
		
		</div>
		
		<input type="submit" value="ORDER" class="order-btn">
	</form>
	
</div>

</body>
</html>