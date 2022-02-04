<!--이시윤 chrome-->
<%@page import="com.project.DB.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String user_id = request.getParameter("id");
	String user_pwd = request.getParameter("pwd");
	String user_name = request.getParameter("name");
	String user_phone1 = request.getParameter("phone1");
	String user_phone2 = request.getParameter("phone2");
	String user_phone3 = request.getParameter("phone3");
	String user_phonenum = user_phone1 + user_phone2 + user_phone3;
	String user_email = request.getParameter("email");
	String user_addr1 = request.getParameter("addr1");
	String user_addr2 = request.getParameter("addr2");
	String user_addr3 = request.getParameter("addr3");
	String user_address = user_addr1 + " " + user_addr2 + " " + user_addr3;
	
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	
	try {
		conn = DBUtil.getMySQLConnection(); //DB 연결
		
		String sql = "INSERT INTO user(user_id, user_pwd, user_name, user_phonenum, user_email, user_address) value(?, ?, ?, ?, ?, ?)";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, user_id);
		pstmt.setString(2, user_pwd);
		pstmt.setString(3, user_name);
		pstmt.setString(4, user_phonenum);
		pstmt.setString(5, user_email);
		pstmt.setString(6, user_address);
		pstmt.executeUpdate();
		
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		DBUtil.close(stmt);
    	DBUtil.close(conn);
	}
%>
	<script>
      	alert("회원 가입 성공");
      	self.close();
      	window.location.href="index.html";
    </script>
</body>
</html>