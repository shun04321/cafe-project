<!-- 이시윤 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	 //NULL값 체크 후 처리
	 String qa_id = request.getParameter("num");

	 if(qa_id == null || qa_id == ""){ 		//qa_id값이 없을경우 처리 -> list 보내줌
	 	qa_id = "1";
	  	response.sendRedirect("list.jsp");
	 }
	 
	 //qa_id을 숫자로 
	 int num = Integer.parseInt(qa_id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="./css/qanda.css" rel="stylesheet" />
<title>비밀글 보기</title>

<!-- CSS 영역 -->
<style type="text/css">

	.wrapper {
	    display: flex;
		justify-content: center;
		align-items: center;
		min-height: 100vh;
	}
	
	p {
	    color: #757575;
	}
	
	strong {
		color: #222222;
	}
	
	table.list {
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
	    font-weight: 400;
	    border-spacing: 0;
	    border-collapse: collapse;
	    line-height: 60px;
	    color: #4e4c4a;
	    letter-spacing: -0.3px;
	    word-break: break-all;
    	word-wrap: break-word;
	    padding: 30px 0;
	    vertical-align: middle;
	    border-bottom: 0px solid #eeeeee;
	    width: 30%;
	    position: relative;
	    margin: 30px 0 0;
	    border: 0px solid #eeeeee;
	}
	    
	 input.list {
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
	 
	 input.okay {
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
	 
	 input.password {
		width:80%;
		height:20px;;
		border:1px solid #C4C8CC;
		padding-top:6px; 
		font-size: 12px;
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif; 
	}
</style>

<!-- 자바스크립트 -->
<script type="text/javascript">
	 function DeleteCheck(){
	 	var password = document.getElementById('password');
		  
		if(password.value == ""){
			alert("비밀번호를 입력하세요!!");
			password.focus();
			return false;
		}else{
		   	return true; 
		}  
	 }
</script>
</head>
<body>
<div class="wrapper" align="center">
<form name="DeleteForm" method="post" action="pass_ok.jsp" onsubmit="return DeleteCheck()">

<!-- GET 방식 -->
<input type="hidden" id="num" name="num" value="<%=num %>" />

	 <h1><B>VIEW COMMENT</B></h1>
	 <br><br>
	 <p>이 글은 비밀글입니다. <strong>PASSWORD를 입력해주세요.</strong>
	 <br>
	 관리자는 관리자 비밀번호를 입력해주세요.</p>
<table table class="list" border="0" summary="비밀글 보기"> 
	 <colgroup>
		  <col width="300px"/>
		  <col width="800px"/>
	 </colgroup>
	 <tbody>
		  <tr>
		  	<th align="center" color="#222222">PASSWORD</th>
		  	<td>&nbsp&nbsp&nbsp&nbsp
		  	<input class="password" type="password" id="password" name="password" size="70" maxlength="50"></td>
		  </tr>
	 </tbody>
</table>
<br>
<table>
	<tr>
		<td>
			<input class="list" type="button" value="LIST" onclick="history.back(-1)"/>
		</td>
		<td>
			<input class="okay" type="submit" value="OKAY"/>
		</td>
	</tr>
</table>
</form>
</div>
</body>
</html>