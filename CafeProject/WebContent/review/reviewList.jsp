<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.project.dto.*"%>
<%@ page import="com.project.dao.*"%>
<%@ page import="java.util.*"%>
<%@ include file="global.jsp"%>

<% 
	request.setCharacterEncoding("UTF-8");

	try{
		nPageNum = Integer.valueOf(request.getParameter("pageNum"));
	}catch(Exception e){
		nPageNum = 1;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<style>
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
		text-align: center;
	}
	
	.list tr {
		border: 1px solid #eeeeee;
		text-align: center;
	}
	
	.write {
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
<script>
	function writeForm(){
		location.href="index.jsp?contentPage=../review/chooseProduct.jsp";
	}
	
	function viewReview(reviewId){
		location.href="../index/index.jsp?contentPage=../review/viewReview.jsp?reviewId="+reviewId;
	}
	
	function goPageMove(pageNum){
		var frm = document.board; 

		frm.pageNum.value = pageNum;
		frm.action="../index/index.jsp?contentPage=../review/reviewList.jsp";
		frm.submit();
	}
</script>
<%
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://mydbinstance.ctvgpvyuejsa.ap-northeast-2.rds.amazonaws.com:3306/myShoppingmallDB?serverTimezone=UTC";
			
	String id = "shun04321";
	String pw = "awstbs421!";
	String struQuery = null;
	
	try{
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
				
			stmt = conn.createStatement();
				
			strQuery = "SELECT COUNT(review_id) FROM review";								// 게시물 전체 건수 조회
				
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
<body>
	<br><br>
	<div class="reviewList" width=100% align="center">
		<p style="font-size: 25px;">Review</p>
		<br>

		<!-- 게시글 목록 부분 -->
		<form name="board" method="post">
			<!-- 게시글 번호 히든 변수 -->
			<input type="hidden" name="num" />
			<input type="hidden" name="pageNum" />
			<table class="list" width="800" cellpadding="4" cellspacing="1">
				<tr height="50" style="background-color: #C4C8CC; color: #ffffff;">
					<td>No.</td>
					<td>Menu</td>
					<td>Grade</td>
					<td>Name</td>
					<td>Date</td>
				</tr>
<%			
		nFirstNcno = ((nPageNum -1) * nSizePerPage);
		
		ReviewDAO review_dao = new ReviewDAO();
		List<ReviewDTO> list = new ArrayList<ReviewDTO>();
		
		list = review_dao.reviewList(nSizePerPage, nFirstNcno);		// DB review Table의 데이터를 list로 가져오기
		request.setAttribute("list", list);
	
			
		int idx = nTotalRecord - nFirstNcno;									//화면에 출력할 게시물 번호
%>
				<c:forEach var="list" items="${list}">
				<tr height="40" style="cursor: pointer;"onclick="viewReview(${list.reviewID})" border-bottom="1px solid #6d6d6d">
					<td>${list.reviewID}</td>
					<td>${list.productName}</td>
					<td>${list.grade}</td>
					<td>${list.userID}</td>
					<td>${list.date}</td>
				</tr>
				<% idx--;%>
				</c:forEach>
<%
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
	
	<br> <br> <br>

	<!-- PAGENATION START -->
	<table width="75%" cellpadding="0" cellspacing="0" style="font-size: 12px; font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;">
		<tr><td><hr size="1" color="#C4C8CC"><br></td></tr>
		<tr>
		<td>
		<table width="80%" align="center" cellpadding="4">
		<tr>
		<td  style="padding-left: 55%;">
			
<%
		int tmpNum = ((nPageNum - 1) / nPageBlockSize) * nPageBlockSize + 1; 
		
		if(nPageNum == 1 && tmpNum == 1){
%>
		<a href="javascript:goPageMove('1')"><img src="../review/img/btn_first.gif" border="0" alt="처음으로"></a>
		<a href="javascript:goPageMove('1')"><img src="../review/img/btn_prev.gif" border="0" alt="이전으로"></a>
<%			
		}else{
%>
		<a href="javascript:goPageMove('1')"><img src="../review/img/btn_first.gif" border="0" alt="처음으로"></a>
		<a href="javascript:goPageMove('<%= nPageNum-1 %>')"><img src="../review/img/btn_prev.gif" border="0" alt="이전으로"></a>
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
			&nbsp;&nbsp;<a href="javascript:goPageMove('<%=nTotalPage %>');"><img src="../review/img/btn_next.gif" border="0" alt="다음으로"></a>
			<a href="javascript:goPageMove('<%=nTotalPage %>')"><img src="../review/img/btn_last.gif" border="0" alt="끝으로"></a>
<%		
			}else{
%>
			&nbsp;&nbsp;<a href="javascript:goPageMove('<%=tmpNum %>');"><img src="../review/img/btn_next.gif" border="0" alt="다음으로"></a>
			<a href="javascript:goPageMove('<%=nTotalPage %>')"><img src="../review/img/btn_last.gif" border="0" alt="끝으로"></a>
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
	
	<!-- 글쓰기 버튼 -->
	<br>
		<table width="75%" cellpadding="0" cellspacing="0">
			<tr>
				<td height="30" align="left"><a class="main" href="../index/index.jsp">MAIN</a></td>
				<td height="30" align="right"><input type="button" class="write" value="Write" onclick="writeForm()"></td>
			</tr>
		</table>
	<br><br>
	</form>
	</div>	
</body>
</html>