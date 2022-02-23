<!-- 이시윤 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%
	 request.setCharacterEncoding("UTF-8"); //한글이 깨질 경우
	
	 String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	 String jdbc_url = "jdbc:mysql://mydbinstance.ctvgpvyuejsa.ap-northeast-2.rds.amazonaws.com:3306/myShoppingmallDB?serverTimezone=UTC";
		
	 //파라미터
	 String pass = String.valueOf(session.getAttribute("password"));
	 String qa_id = request.getParameter("num"); 		//null
	 String qa_password = null;
	 
	 Class.forName(jdbc_driver);
	 
	 //NULL값 체크 후 처리
	 if(qa_id == null){
	 	qa_id = "1";
	 }
	 int num = Integer.parseInt(qa_id);
	 
	 try{
	 	Connection conn = DriverManager.getConnection(jdbc_url,"shun04321", "awstbs421!");
	 	Statement stmt = conn.createStatement();
	 	String sql = "SELECT qa_password FROM qanda WHERE qa_id=" + num;
	 	ResultSet rs = stmt.executeQuery(sql);
	 	System.out.println(pass);
	  
		if(rs.next()){
			qa_password = rs.getString(1);
		   	System.out.println(qa_password);
		}
		  
		if(qa_password.equals(pass) || "adminpw12!".equals(pass)){		// 작성자 or 관리자 비밀번호
%>
	 	<script type="text/javascript">
	 		self.location.href="view.jsp?num=<%=qa_id%>";
	 	</script>
<% 
	 //DB 종료
		 	rs.close();
		 	stmt.close();
		 	conn.close();
		} else{
%>
		<script type="text/javascript">
			self.window.alert("다른 회원의 글을 볼 수 없습니다.");
		  	location.href="pass.jsp";
		</script>
<%
	 	}
	 }catch(SQLException e){
	  	out.println(e.toString());
	 }
%>