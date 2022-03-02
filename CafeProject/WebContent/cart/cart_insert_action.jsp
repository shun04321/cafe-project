<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.project.dto.*" %>
<%@ page import="com.project.dao.*" %>

<%
	request.setCharacterEncoding("utf-8");

	CartDTO cart_dto = new CartDTO();
	CartDAO cart_dao = new CartDAO();	
	
	String user_id = (String)session.getAttribute("id");
	int product_id = Integer.parseInt(request.getParameter("product_id")); 
	int product_qty = Integer.parseInt(request.getParameter("menu_qty"));
	
	cart_dto.setUser_id(user_id);
	cart_dto.setProduct_id(product_id);
	cart_dto.setProduct_qty(product_qty);

	cart_dao.CartInsert(cart_dto);
%>
<script>
   window.location.href="../index/index.jsp?contentPage=../cart/myCart.jsp";
</script>