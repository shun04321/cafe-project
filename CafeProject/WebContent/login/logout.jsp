<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%
	session.invalidate(); // 세션을 빼앗아 종료시킨다
%>

<script>
	location.href = 'index.jsp';
</script>


</body>
</html>