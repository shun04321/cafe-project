<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="com.project.dao.UserDAO"%>
<%@ page import="com.project.dao.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>

<% request.setCharacterEncoding("UTF-8"); %>
<!-- 모든 데이터를 UTF-8로 받음 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%request.setCharacterEncoding("UTF-8");%>

<% 
	String userID = null;
	
	String userPassword = null;
	
	if(request.getParameter("id") != null) {
	
		userID = (String) request.getParameter("id");
	
	}
	
	if(request.getParameter("password") != null) {
	
		userPassword = (String) request.getParameter("password");
	
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(userID, userPassword); // userDAO객체의 login메소드에서 리턴된 값
	
	if(result == 1){ //관리자 페이지
		session.setAttribute("id", userID);
		session.setAttribute("password", userPassword);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 성공')");
		script.println("location.href='./../admin/admin_index.jsp'");
		script.println("</script>");
	}else if(result == 2){ // 사용자페이지
		session.setAttribute("id", userID);
		session.setAttribute("password", userPassword);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 성공')");
		script.println("location.href='./../index/index.jsp'");
		script.println("</script>");
	}else if(result == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다')");
		script.println("history.back()");
		script.println("</script>");
	}else if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다')");
		script.println("history.back()");
		script.println("</script>");
	}else if(result == -2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류입니다')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	
%>

</body>
</html>