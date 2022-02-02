<!--컴퓨터학과 20200998 이시윤 chrome-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LAB13_1</title>
</head>
<body>
	id: ${param['id']}<br/>
	pw: ${param['pw']}<br/>
	gender: 
	<c:forEach var="num" varStatus="i" items="${paramValues.gender}">
		${i.index +1}
	</c:forEach><br/>
	phone1: 
	<c:forEach var="num" varStatus="i" items="${paramValues.phone1}">
		${i.index}
	</c:forEach><br/>
	phone2: ${param['phone2']}<br/>
	phone3: ${param['phone3']}<br/>
	email: ${param['email']}<br/>
	birth: ${param['birth']}<br/>
	hobby: 	
	<c:forEach var="num" varStatus="i" items="${paramValues.hobby}">
		${i.index +1}/
	</c:forEach><br/>
	memo: ${param['memo']}<br/>
	
	<hr>
	
	<h1>Processing Parameters</h1>
	id: ${param['id']}<br/>
	pw: ${param['pw']}<br/>
	gender: ${paramValues.gender[0]}<br/>
	phone1: ${param['phone1']}<br/>
	phone2: ${param['phone2']}<br/>
	phone3: ${param['phone3']}<br/>
	email: ${param['email']}<br/>
	birth: ${param['birth']}<br/>
	hobby: 	
	<c:forEach var="num" varStatus="i" items="${paramValues.hobby}">
		${num}/
	</c:forEach><br/>
	memo: ${param['memo']}<br/>
</body>
</html>