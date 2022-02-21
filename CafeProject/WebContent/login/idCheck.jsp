<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.project.dao.UserDAO.*"%>
<jsp:useBean id="dao" class="com.project.dao.UserDAO"/>

<%
	 int rst = 0;
	 String id = (String)request.getParameter("id");
	 rst = dao.idCheck(id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<style>
	body{
		text-align: center;
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
		font-weight: 400;
		font-size: 14px;
		font-color: #C4C8CC;
	}
</style>
<title>아이디 중복체크</title>
</head>
<body>
<%
	if(rst == 1){
%>
	<br><br>
	<span style="color: red;">이미 사용중인 아이디입니다.</span><br><br>
	<input type='button' value="확인" onclick="window.close();">
	<!-- 아이디가 이미 존재할때 이미지 -->
<%
	}else{ 
%>
	<br><br>
	사용 가능한 아이디입니다.<br><br>
	<input type='button' value="확인" onclick="window.close();">
	<!-- 아이디가 존재하지 않을 때 이미지 -->
<%
	} 
%>
</body>
</html>