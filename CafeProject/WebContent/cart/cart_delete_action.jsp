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
	String product[] = request.getParameterValues("checked");

	for(String value : product){
		cart_dao.CartDelete(user_id, Integer.parseInt(value));
	}	
%>
<script>
	alert("해당 메뉴가 삭제 완료되었습니다 :)");
	window.location.href="../index/index.jsp?contentPage=../cart/myCart.jsp";
</script>

