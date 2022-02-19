<!-- 이시윤 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="global.jsp" %>  

<%
	try{
		num = Integer.valueOf(request.getParameter("num"));	
	}catch(Exception e){
		num = 1;
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="./css/qanda.css" rel="stylesheet" />
<title><%=strProgramTitle %></title>
<style>  
	h2 {
	    font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
	    font-size: 25px;
	    line-height: 30px;
	    font-weight: 300;
	    color: rgb(65, 74, 67);
	    font-color: #414a43;
	}
	
	.body{
		font-family:'Nunito Sans', 'Noto Sans KR', sans-serif;
		font-size:"5pt"; 
		font-weight:"bold"; 
	}
	
	table.list {
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
	    font-weight: 400;
	    border-spacing: 0;
	    border-collapse: collapse;
	    line-height: 40px;
	    color: #4e4c4a;
	    font-size: 12px;
	    letter-spacing: -0.3px;
	    word-break: break-all;
    	word-wrap: break-word;
	    padding: 30px 0;
	    vertical-align: middle;
	    border-bottom: 1px solid #eeeeee;
	    width: 75%;
	    position: relative;
	    margin: 30px 0 0;
	    border: 1px solid #eeeeee;
	}
	
	tr {
		border: 1px solid #eeeeee;
	}
	a.reply {
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
	    cursor: pointer;
	    display: inline-block;
	    box-sizing: border-box;
	    padding: 0 11px;
	    border: 1px solid transparent;
	    font-size: 13px;
	    font-weight: 300;
	    text-decoration: none;
	    vertical-align: middle;
	    letter-spacing: -0.3px;
	    text-align: center;
	    white-space: nowrap;
	    transition: 0.2s ease-in-out;
	    color: #ffffff;
	    background-color: #222222;
	    height: 40px;
	    line-height: 40px;
	    word-break: keep-all;
	    word-wrap: break-word;
	    margin-left: 6px;
	    width: 100px;
	}
	
	a.modify {
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
	    cursor: pointer;
	    display: inline-block;
	    box-sizing: border-box;
	    padding: 0 11px;
	    border: 1px solid transparent;
	    font-size: 13px;
	    font-weight: 300;
	    text-decoration: none;
	    vertical-align: middle;
	    letter-spacing: -0.3px;
	    color: #4e4c4a;
	    text-align: center;
	    white-space: nowrap;
	    transition: 0.2s ease-in-out;
	    background-color: #eeeeee;
	    height: 40px;
	    line-height: 40px;
	    word-break: keep-all;
	    word-wrap: break-word;
	    margin-left: 6px;
	    width: 100px;
	}
	
	a.list, a.delete {
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
	    cursor: pointer;
	    display: inline-block;
	    box-sizing: border-box;
	    padding: 0 11px;
	    font-size: 13px;
	    font-weight: 300;
	    text-decoration: none;
	    vertical-align: middle;
	    letter-spacing: -0.3px;
	    color: #4e4c4a;
	    text-align: center;
	    white-space: nowrap;
	    transition: 0.2s ease-in-out;
	    background-color: transparent;
	    border: 1px solid #eeeeee;
	    height: 40px;
	    line-height: 40px;
	    word-break: keep-all;
	    word-wrap: break-word;
	    margin-left: 6px;
	    width: 100px;
	}
</style>
</head>
<body>
<div align="center">
<form>
	<br><br><br><br><br><br>
	
	<!-- TITLE START -->
	<table width="800" cellpadding="0" cellspacing="0">
		<tr>
			<td width="800" height="50">
			<h2><%=strProgramTitle %></h2>
			</td>
		</tr>
	</table>
	<!-- TITLE END -->
	
	<br><br><br>
<%
		String jdbc_driver = "com.mysql.cj.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://mydbinstance.ctvgpvyuejsa.ap-northeast-2.rds.amazonaws.com:3306/myShoppingmallDB?serverTimezone=UTC";
		
		String id = "shun04321";
		String pw = "awstbs421!";
		
		try{
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
			stmt = conn.createStatement();		
			
			//조회수를 1씩 증가
			strQuery = "UPDATE qanda SET qa_count=qa_count+1 WHERE qa_id=" + num;
			stmt.executeUpdate(strQuery);
			
			
			strQuery = "SELECT * FROM qanda WHERE qa_id="+num+" ORDER BY qa_id DESC";
			stmt.execute(strQuery);
			
			rs = stmt.executeQuery(strQuery);
			
			//해당 게시물이 있으면...
			if(rs.next()){
%>	
	<!-- CONTENT START -->
	<table class="list" width="800" cellpadding="3" cellspacing="1">
		<tr>
			<td width="80" bgcolor="#C4C8CC" align="center"><font color="#ffffff"><b>Date</b></font></td>
			<td width="650" style="border:0px solid;">
			&nbsp&nbsp&nbsp&nbsp<%= rs.getString("qa_date") %>
			</td>
		</tr>
		
		<tr>
			<td width="80" bgcolor="#C4C8CC" align="center"><font color="#ffffff"><b>Hits</b></font></td>
			<td width="650" style="border:0px solid;">
			&nbsp&nbsp&nbsp&nbsp<%= rs.getString("qa_count") %>
			</td>
		</tr>
		
		<tr>
			<td width="80" bgcolor="#C4C8CC" align="center"><font color="#ffffff"><b>Title</b></font></td>
			<td width="650" style="border:0px solid;">
			&nbsp&nbsp&nbsp&nbsp<%= rs.getString("qa_title") %>
			</td>
		</tr>
		
		<tr>
			<td colspan='2' width="730" style="border:0px solid;" align="center" overflow="hidden" height="auto">
			<br><%=rs.getString("qa_content").replaceAll("\n","<br>") %><br><br>
			</td>
		</tr>
	</table>
	<table width="75%" cellpadding="3" cellspacing="1">
		<tr>
			<td width="80"align="left">
				<a class="list" href="list.jsp">LIST</a>
			</td>
			<td width="650" align="right">
				<a class="delete" href="qandaProc.jsp?command=Delete&num=<%=rs.getString("qa_id") %>">DELETE</a>
				<a class="modify" href="updateForm.jsp?num=<%=rs.getString("qa_id") %>">MODIFY</a>
				<a class="reply" href="replyForm.jsp?num=<%=rs.getString("qa_id") %>">REPLY</a>
			</td>
		</tr>
	</table>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<!-- CONTENT END -->
<%
			}
			rs.close();
			stmt.close();
			conn.close();
		}catch(Exception e){
			out.write("VIEW PAGE ERROR : " + e.getMessage());
		}
%>		
</form>
</div>
</body>
</html>