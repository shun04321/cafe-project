<%@page import="com.project.dto.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String user_id = (String)session.getAttribute("id");	
	
	CartDAO cart_dao = new CartDAO();
	List<CartDTO> cart_list = new ArrayList<CartDTO>();
	
	UserDAO user_dao = new UserDAO();
	UserDTO user_dto = user_dao.getUserInfo(user_id);
	
	ProductDAO product_dao = new ProductDAO();
	List<ProductDTO> product_list = new ArrayList<ProductDTO>();
	
	String product[] = request.getParameterValues("checked");
	for(String product_id : product){
		cart_list.add(cart_dao.cartByProductID(user_id, Integer.parseInt(product_id)));  // id, 수량 반환하는 함수;
		product_list.add(product_dao.getProduct(Integer.parseInt(product_id)));
	}	
	
	request.setAttribute("cart_list", cart_list);
	request.setAttribute("product_list", product_list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Form</title>
<link href="./../css/order.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div class="oder-form-container" width=100% align="center">
	<form action="./orders_insert_action.jsp" method="post">
	
		<input type="hidden" name="product_id" value=""> 
	
		<div class="oder-info-box">
			<h2>주문 내역</h2>
			<hr class="hr_1">
	
			<table class="order-info-table" >
				<%
					int idx = 0;
					int[] qty = new int[cart_list.size()];
					int totalPrice = 0;
					
					for(CartDTO cart : cart_list){
						qty[idx++] = (int)cart.getProduct_qty();	
					}
					
					idx = 0;
					for(ProductDTO pList : product_list){
				%>
				<tr>
					<td class="order-info-td"><img class="oder-menu-img" alt="menu-img" src="./../images/<%=pList.getProductIMG()%>"></td>
					<td class="order-info-td"><%=pList.getProductNAME()%></td>
					<td class="order-info-td"><%=pList.getProductPRICE()%></td>
					<td class="order-info-td"><%=qty[idx]%></td>
					<td class="order-info-td"><%=pList.getProductPRICE()*qty[idx]%></td>
					<td><input type="hidden" name="productId" value="<%=pList.getProductID()%>"></td>
					<td><input type="hidden" name="productQty" value="<%=qty[idx]%>"></td>
				</tr>
				<tr><td colspan="5"><hr></td></tr>
				<%
							totalPrice+=qty[idx++]*pList.getProductPRICE();
					}
				%>
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
					<td>전자 영수증 발행</td>
					<td>배송비</td>
					<td>총 결제 예상 금액</td>
				</tr>
				<tr>
					<td colspan="4"><hr class="hr_2"></td>
				</tr>
				<tr>
					<td><%=user_dto.getUser_email() %></td>
					<td>2500원</td>
					<td><%=totalPrice+2500%>원</td>
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