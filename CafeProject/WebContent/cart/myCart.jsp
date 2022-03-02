<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.project.dto.*"%>
<%@ page import="com.project.dao.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.cartTag{
		color: black;
		font-size: 20px;
		margin: 20px;
	}
	
	.cartTable {
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
		font-weight: 400;
		border-spacing: 0;
		border-collapse: collapse;	
		color: #4e4c4a;
		font-size: 13px;
		letter-spacing: -0.3px;
		word-break: break-all;
		word-wrap: break-word;
		padding: 30px 0;
		vertical-align: middle;
		border-bottom: 1px solid #eeeeee;
		width: 1000px;
		position: relative;
		margin: 30px 0 0;
		border: 1px solid #eeeeee;
		text-align: center;
	}
	
	.cartTable tr {
		border: 1px solid #eeeeee;
		text-align: center;
	}
	
	.write {
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
		cursor: pointer;
		display: inline-block;
		box-sizing: border-box;
		padding: 0 11px;
		border: 1px solid transparent;
		font-size: 13px;
		font-weight: 300;
		text-decoration: none;
		vertical-align: middle;
		letter-spacing: -0.3px;
		text-align: center;
		white-space: nowrap;
		transition: 0.2s ease-in-out;
		color: #ffffff;
		background-color: #222222;
		height: 40px;
		line-height: 40px;
		word-break: keep-all;
		word-wrap: break-word;
		margin-left: 6px;
		width: 100px;
	}
	
	.deleteBtn {
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
		cursor: pointer;
		display: inline-block;
		box-sizing: border-box;
		padding: 0 11px;
		border: 1px solid transparent;
		font-size: 13px;
		font-weight: 300;
		text-decoration: none;
		vertical-align: middle;
		letter-spacing: -0.3px;
		text-align: center;
		white-space: nowrap;
		transition: 0.2s ease-in-out;
		color: #ffffff;
		background-color: #222222;
		height: 40px;
		line-height: 40px;
		word-break: keep-all;
		word-wrap: break-word;
		margin-left: 6px;
		width: 100px;
	}
	
	.orderBtn {
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
		cursor: pointer;
		display: inline-block;
		box-sizing: border-box;
		padding: 0 11px;
		font-size: 13px;
		font-weight: 300;
		text-decoration: none;
		vertical-align: middle;
		letter-spacing: -0.3px;
		color: #4e4c4a;
		text-align: center;
		white-space: nowrap;
		transition: 0.2s ease-in-out;
		background-color: transparent;
		border: 1px solid #eeeeee;
		height: 40px;
		line-height: 40px;
		word-break: keep-all;
		word-wrap: break-word;
		margin-left: 6px;
		width: 100px;
	}
</style>
<script>
	function goToMenu(){
		location.href = "../index/index.jsp?contentPage=../product/menu.jsp;"
	}
</script>
</head>
<body>
	<center>
	<br><br><span class="cartTag">장바구니</span><br>
<%
	request.setCharacterEncoding("UTF-8");
	
	String user_id = (String)session.getAttribute("id");
	CartDAO cart_dao = new CartDAO();
	List<CartDTO> list = new ArrayList<CartDTO>();
	
	list = cart_dao.cartList(user_id);		// DB review Table의 데이터를 list로 가져오기
	request.setAttribute("list", list);
%>	
	<form name="cartForm">
		<table class="cartTable" text-align="center">
			<tr height="50" style="background-color: #C4C8CC; color: #ffffff;">
				<td colspan="2">Check</td>
				<td colspan="2">No.</td>
				<td colspan="2">Image</td>
				<td>Menu</td>
				<td>Quantity</td>
				<td>Price</td>
			</tr>
			<%
				int idx = 1;
				int totalPrice = 0;
				ProductDAO dao = new ProductDAO();
				
				for(CartDTO cart : list){
					String productName = dao.findProductName(cart.getProduct_id());
					String src = dao.imageSrc(productName);
					int productId = cart.getProduct_id();
					
					out.println("<tr style='height: 100px; cursor: pointer;' onclick='viewReview(${list.reviewID})' border-bottom='1px solid #6d6d6d'>");
					out.println("<td colspan='2' width='15%'><input type='checkbox' name='checked' value='" + productId + "'></td>");
					out.println("<td colspan='2' width='15%'>" + (idx++) + "</td>");
					out.println("<td colspan='2' width='25%'><img style='margin-top: 5px; width: 35%; height: 35%;' src='../images/" + src + "'></td>");
					out.println("<td width='15%'>" + productName + "</td>");
					out.println("<td width='15%'>" + cart.getProduct_qty() + "</td>");
					out.println("<td width='15%'>" + dao.getPrice(productName, cart.getProduct_qty()) + "</td>");
					out.println("</tr>");
					
					totalPrice += dao.getPrice(productName, cart.getProduct_qty());
				}
			%>
		</table>
		<%
			if(list.isEmpty()){
				out.println("<center>");
				out.println("<br><br><p style='font-size: 18px; color: black;'>장바구니에 담은 상품이 없습니다.</p>");
				out.println("<br>");
			}
			else{
		%>
			<br><hr style="width: 1000px;">
			<table width="1000px" style="text-align: center;">
				<tr style="height: 50px;">
					<td colspan="4">총 상품가격</td>
					<td colspan="5"><%= totalPrice %>원</td>
					<td colspan="4">총 배송비</td>
					<td colspan="5">2500원</td>
					<td colspan="4">총 결제금액</td>
					<td colspan="5"><%= totalPrice+2500 %>원</td>
				</tr>
			</table><hr style="width: 1000px;">
		<%		
			}
		%>
		<br><br><hr><br>
		<table width="50%" cellpadding="0" cellspacing="0">
			<tr>
				<td height="30" align="left"><input type="submit" class="orderBtn" value="BACK" onclick="javascript: history.back();"></td>
				<td height="30" align="center"><input type="submit" class="deleteBtn" value="ORDER" onclick="javascript: form.action='../order/ordersForm.jsp';"></td>
				<td height="30" align="center"><input type="button" class="orderBtn" value="메뉴 보러가기"; onclick="goToMenu()"></td>
				<td height="30" align="right"><input type="submit" class="deleteBtn" value="DELETE" onclick="javascript: form.action='../cart/cart_delete_action.jsp;'"></td>
			</tr>
		</table>
		<br><br><br>
	</form>
	</center>
</body>
</html>