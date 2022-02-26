<!-- 이시윤 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!-- 공통파일 INCLUDE -->    
<%@ include file="global.jsp" %>  
<%request.setCharacterEncoding("UTF-8"); %>
<% 
	try{
		nPageNum = Integer.valueOf(request.getParameter("pageNum"));
	}catch(Exception e){
		nPageNum = 1;
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
	
	span {
		background-color: #C4C8CC;
		color: #ffffff;
		font-size: 10px;
	}
	
	table.list {
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
	    font-weight: 400;
	    border-spacing: 0;
	    border-collapse: collapse;
	    line-height: 60px;
	    color: #4e4c4a;
	    font-size: 13px;
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
	
	a.write {
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
	
	a.main {
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
	function goPageMove(pageNum){
		var frm = document.boardForm; 

		frm.pageNum.value = pageNum;
		frm.action="list.jsp";
		frm.submit();
	}
</script>

</head>
<body>
<div align="center">
<!-- FORM START -->
<form name="boardForm" method="post">
	<!-- 게시글 번호 히든 변수 -->
	<input type="hidden" name="num" />
	<input type="hidden" name="pageNum" />
	
	<br><br><br><br><br><br>
	
	<!-- TITLE START -->
	<table class="title" width="800" cellpadding="0" cellspacing="0">
		<tr class="title">
			<td width="800" height="50">
			<h2><%=strProgramTitle %></h2>
			</td>
		</tr>
	</table>
	<!-- TITLE END -->
	
	<br><br><br>
	
	<!-- LIST START -->
	<table class="list" width="800" cellpadding="4" cellspacing="1">
		
<%
			String jdbc_driver = "com.mysql.cj.jdbc.Driver";
			String jdbc_url = "jdbc:mysql://mydbinstance.ctvgpvyuejsa.ap-northeast-2.rds.amazonaws.com:3306/myShoppingmallDB?serverTimezone=UTC";
			
			String id = "shun04321";
			String pw = "awstbs421!";
			
			try{
				Class.forName(jdbc_driver);
				conn = DriverManager.getConnection(jdbc_url, id, pw);
			
			stmt = conn.createStatement();	
			
			strQuery = "SELECT COUNT(qa_id) FROM qanda WHERE (user_id='" + String.valueOf(session.getAttribute("id")) + "' OR user_id='admin') AND qa_password='" + String.valueOf(session.getAttribute("password")) + "'\n";	// 게시물 전체 건수 조회
			stmt.execute(strQuery);
			
			rs = stmt.executeQuery(strQuery);
			
			if(rs.next()){
				nTotalRecord = rs.getInt(1);
			}
			rs.close();
			
			/**
			 * 페이지를 계산한다.
			 * 전체 레코드 % 페이지당 개수가 0이면 nTotalRecord / nSizePerPage
			 * 아니면 한페이지를 더한다.
			 */
			if ((nTotalRecord % nSizePerPage)==0){							
				nTotalPage = nTotalRecord / nSizePerPage;
			}else{
				nTotalPage = (nTotalRecord / nSizePerPage) + 1;
			}
			
%>
		<br><br>
		<tr>
			<td width="50"  align="center" height="30" bgcolor="#C4C8CC"><font color="#ffffff"><b>No.</b></font></td>
			<td width="400" align="center" bgcolor="#C4C8CC"><font color="#ffffff"><b>Title</b></font></td>
			<td width="100" align="center" bgcolor="#C4C8CC"><font color="#ffffff"><b>Name</b></font></td>
			<td width="100" align="center" bgcolor="#C4C8CC"><font color="#ffffff"><b>Date</b></font></td>
			<td width="70" align="center" bgcolor="#C4C8CC"><font color="#ffffff"><b>Hits</b></font></td>
		</tr>
<%			
			nFirstNcno = ((nPageNum -1) * nSizePerPage);

			//out.write("nFirstNcno:" + nFirstNcno + "<br>");			
			
			strQuery = "SELECT";													//게시물 조회 쿼리
			strQuery += " 	 qa_id 			\n";
			strQuery += " 	,qa_title 		\n";
			strQuery += " 	,user_id 		\n";
			strQuery += " 	,qa_date 		\n";
			strQuery += " 	,qa_count		\n";
			strQuery += " 	,qa_content		\n";
			strQuery += " 	,qa_password	\n";
			strQuery += " 	,qa_ref 		\n";
			strQuery += " 	,qa_restep 		\n";
			strQuery += " 	,qa_relevel 	\n";
			strQuery += " 	FROM \n";
			strQuery += " 	qanda \n";
			strQuery += " 	WHERE \n";
			strQuery += " 	(user_id='" + String.valueOf(session.getAttribute("id")) + "' OR user_id='admin') AND qa_password='" + String.valueOf(session.getAttribute("password")) + "'\n";
			strQuery += " 	ORDER BY qa_ref DESC, qa_restep ASC \n";
		 	strQuery += " 	LIMIT "+nSizePerPage+" OFFSET "+nFirstNcno+" \n";
		 	
		 	stmt.execute(strQuery);
		 	
			//out.write("QUERY : " + strQuery);										//화면 DEBUG
			
			rs = stmt.executeQuery(strQuery);
			
			int idx = nTotalRecord - nFirstNcno;									//화면에 출력할 게시물 번호
			
			int relevel = 0;														//답글레벨 얻어어기 위한 변수
				
			while(rs.next()){														//rs.next가 true면 게시물 리스트 출력
				
				String strRE = " ";													//답글계층만큼 [RE]를 붙이기 위한 변수
				relevel = rs.getInt("qa_relevel");
							
				for(int i=1; i <= relevel; i++ ){
					strRE += "&nbsp<span> RE </span>&nbsp";
				}
%>
		<tr border-bottom="1px solid #6d6d6d">
			<!--  글 번호 idx 출력 -->
			<td width="100" height="25" align="center"><%= idx %></td>
			
			<!--  글 제목 출력 -->
			<td width="450">
				&nbsp&nbsp&nbsp<%=strRE%> 
				<a href="pass_ok.jsp?num=<%=rs.getInt("qa_id")%>" target="_self" style="text-decoration:none; color: #6d6d6d;"><%=rs.getString("qa_title")%></a>
				&nbsp<input type="image" src="img/ico_lock.jpg">
			</td>
<%
			String name = rs.getString("user_id");
			if("admin".equals(name))	{
				name = name.replace("admin" , " ");
			}
			else {
				name = name.replaceAll("(?<=.{1})." , "*");
			}

%>
			<td width="100" align="center"><%= name %></td>
			<td width="100" align="center"><%= rs.getString("qa_date").substring(0,10) %></td>
			<td width="50" align="center"><%= rs.getInt("qa_count") %></td>
		</tr>
<%
				idx--;																//화면출력 번호 1씩 감소	
			}
			
			rs.close();																// rs Close 
			stmt.close();															// stmt Close
			conn.close();															// conn Close
		}catch(Exception e){
			out.write(e.getMessage());
			e.printStackTrace();
		}finally{
			if(rs != null){
				try{rs.close();}catch(Exception e){}
			}
			if(stmt != null){
				try{stmt.close();}catch(Exception e){}
			}
			if(conn != null){
				try{conn.close();}catch(Exception e){}
			}
		}
%>  
	</table>
	<!-- LIST END -->
	
	<!-- PAGENATION START -->
	<table width="75%" cellpadding="0" cellspacing="0">
		<tr><td><hr size="1" color="#C4C8CC"><br></td></tr>
		<tr>
		<td>
		<table width="80%" align="center" cellpadding="4">
		<tr>
		<td align="center">
			
<%
		int tmpNum = ((nPageNum - 1) / nPageBlockSize) * nPageBlockSize + 1;
		
		if(nPageNum == 1 && tmpNum == 1){
%>
		<a href="javascript:goPageMove('1')"><img src="img/btn_first.gif" border="0" alt="처음으로"></a>
		<a href="javascript:goPageMove('1')"><img src="img/btn_prev.gif" border="0" alt="이전으로"></a>
<%			
		}else{
%>
		<a href="javascript:goPageMove('1')"><img src="img/btn_first.gif" border="0" alt="처음으로"></a>
		<a href="javascript:goPageMove('<%= nPageNum - 1%>')"><img src="img/btn_prev.gif" border="0" alt="이전으로"></a>
<%		
		}
		
		for(int i=1; i <= nPageBlockSize; i++){
			if(tmpNum == nPageNum){
%>
			&nbsp;&nbsp;<a href="javascript:goPageMove('<%=tmpNum %>');" style="text-decoration:none; color: #6d6d6d;"><b><%=tmpNum %></b></a>
<%					
			}else{
%>
			&nbsp;&nbsp;<a href="javascript:goPageMove('<%=tmpNum %>');" style="text-decoration:none; color: #6d6d6d;"><%=tmpNum %></a>
<%			
			}
			tmpNum += 1;
			
			if (tmpNum > nTotalPage) break;
		}

		if(nPageNum <= nTotalPage){
			if(tmpNum > nTotalPage){
%>
			&nbsp;&nbsp;<a href="javascript:goPageMove('<%=nTotalPage %>');"><img src="img/btn_next.gif" border="0" alt="다음으로"></a>
			<a href="javascript:goPageMove('<%=nTotalPage %>')"><img src="img/btn_last.gif" border="0" alt="끝으로"></a>
<%		
			}else{
%>
			&nbsp;&nbsp;<a href="javascript:goPageMove('<%=tmpNum %>');"><img src="img/btn_next.gif" border="0" alt="다음으로"></a>
			<a href="javascript:goPageMove('<%=nTotalPage %>')"><img src="img/btn_last.gif" border="0" alt="끝으로"></a>
<%				
			}
		}
%>			
			</td>
		</tr>
		</table>
		</td>
		</tr>
		<tr><td><br><hr size="1" color="#C4C8CC"></td></tr>
	</table>
	<!-- PAGENATION END -->
	
	<table width="75%" cellpadding="0" cellspacing="0" >
		<tr>
		<td height="30" align="left">
			<a class="main" href="./mypage.jsp">MYPAGE</a>
		</td>
		<td height="30" align="right">
			<a class="write" href="writeForm.jsp">WRITE</a>
		</td>
		</tr>
	</table>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</form>
</div>
<!-- FORM END -->
</body>
</html>