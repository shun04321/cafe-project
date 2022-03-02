<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.project.dto.ProductDTO"%>
<%@ page import="com.project.dao.ProductDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MENU</title>
<link href="./../css/index.css" rel="stylesheet" type="text/css" />
<link href="./../css/product.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="./../js/product.js"></script>
</head>
<body>			

	<!-- 정민지 -->
	<%
		ProductDTO product_dto = new ProductDTO();
		ProductDAO product_dao = new ProductDAO();
	
		ArrayList<ProductDTO> coffeeList =  product_dao.getCoffeeDESC(); // 가격 높은순 정렬
	%>
	
	<div class="menu-container">
		
		<h2 class="coffee-text">
			-COFFEE
		</h2>
			
		<select name="sort"  onchange="sort(this.value);">	
			<option name="selected-sort">정렬선택</option>
			<option name="sort-asc" value="coffee_asc">커피 낮은가격순</option>
			<option name="sort-desc" value="coffee_desc">커피 높은가격순</option>
			<option name="sort-asc" value="dessert_asc">디저트 낮은가격순</option>
			<option name="sort-desc" value="dessert_desc">디저트 높은가격순</option>
		</select>	
		
		<ul class="coffee-outer">
		
			<%
				for(ProductDTO menu : coffeeList){
			%>

			<li class="coffee-inner">
				<div class="coffee">
					<a href="./../product/menu_detail.jsp?product_id=<%=menu.getProductID()%>"><img alt="menu" src="./../images/<%=menu.getProductIMG() %>"></a><br>
					<%=menu.getProductNAME() %><br>
					<%=menu.getProductPRICE() %>
				</div>
			</li>
			
			<%} %>		
		</ul>
	</div>
</body> 
</html>