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
		font-family:"굴림";
		font-size:"5pt"; 
		font-weight:"bold"; 
	}

	.hidden {
	
	    display:none;
	
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
	
	input.write {
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
	
	a.cancel {
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

<script type="text/javascript">
	function fnUpdate(num){
		var frm = document.boardForm;
		frm.num.value = num;
		frm.action = "qandaProc.jsp";
		frm.submit();
	}
	
    function validate() {
        if(boardForm.content.value=="") {
            alert("내용을 입력하세요.");
            boardForm.content.focus();
            return false;
        }
        
        if(boardForm.password.value=="") {
            alert("비밀번호를 입력하세요.");
            boardForm.password.focus();
            return false;
        }
    }
</script>

</head>
<body>
<div align="center">
<form name="boardForm" method="post" onsubmit="return validate();" action="javascript:fnUpdate('<%=num %>');">
	<input type="hidden" name="command" value="Update"/>
	<input type="hidden" name="num" value="<%=num %>">
	
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
		
		strQuery = "SELECT * FROM qanda WHERE qa_id="+num+" ORDER BY qa_id DESC";
		
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(strQuery);
		
		//해당 게시물이 있으면...
		if(rs.next()){
%>	
	<!-- CONTENT START -->
	<table class="list" width="800" cellpadding="3" cellspacing="1">
	
		<tr class="hidden">
			<td width="80" class="label" align="center" ><font color="#ffffff"><b>작성자</b></font></td>
			<td width="800" style="border:1px solid;" >
			<input type="text" name="writer" value="<%= rs.getString("user_id") %>"  class="input">
			</td>
		</tr>
		<tr>
			<td width="80" class="label" align="center"><font color="#ffffff"><b>Title</b></font></td>
			<td width="800" style="border:0px solid;">
			&nbsp&nbsp&nbsp&nbsp<input type="text" name="title" value="<%= rs.getString("qa_title") %>" class="input" style="vertical-align:middle;" readonly>
			</td>
		<tr>
			<td colspan='2' width="680" style="border:0px solid;">
			<textarea name="content" class="textarea"><%=rs.getString("qa_content") %></textarea>
			</td>
		</tr>
		<tr class="hidden">
			<td width="80" class="label" align="center"><font color="#ffffff"><b>PASSWORD</b></font></td>
			<td width="800" style="border:1px solid;">
			<input type="password" name="password" value="<%= rs.getString("qa_password") %>" class="input">
			</td>
		<tr>
		<tr>
			<td width="80" class="label" align="center" ><font color="#ffffff"><b>SECRET</b></font></td>
			<td width="800" style="border:0px solid;" >
			&nbsp&nbsp&nbsp&nbsp<input name="secret" type="radio" value="Y" onclick="return false">공개글
			&nbsp<input name="secret" type="radio" value="N" checked onclick="return false">비밀글
			</td>
		</tr>
	</table>
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
	<!-- 기능버튼 -->
	<table width="75%" cellpadding="3" cellspacing="1">
		<tr>
			<td width="80" height="30" bgcolor=""></td>
			<td width="800" align="right">
				<input class="write" type="submit" value="WRITE" border="0">
				<a class="cancel" href="list.jsp" target="_self">CANCEL</a>
			</td>
		</tr>
	</table>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</form>
</div>
</body>
</html>