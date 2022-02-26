<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.project.dto.*"%>
<%@ page import="com.project.dao.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	try{
		request.setCharacterEncoding("utf-8");
		UserDTO user_dto = new UserDTO();
		UserDAO user_dao = new UserDAO();
		
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
		
		user_dto.setUserID(user_id);
		user_dto.setUserPW(user_pwd); 
		user_dto.setUserName(user_name);
		user_dto.setUser_phone(user_phonenum);
		user_dto.setUser_email(user_email);
		user_dto.setUser_address(user_address);
		
		user_dao.UserModify(user_dto); // 회원정보 수정하는 UserDAO 메소드
	}catch(Exception e){
		System.out.println(e);
	}
%>
	<script>
      	alert("회원정보 수정 성공");
      	self.close();
      	window.location.href="./../mypage/mypage.jsp";
    </script>
</body>
</html>