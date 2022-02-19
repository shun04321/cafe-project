<!-- 이시윤 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="global.jsp" %> 

<%
	

	request.setCharacterEncoding("utf-8");

	int ref 		= 0;
	int restep 		= 1;
	int relevel 	= 1;
	int retVal		= 0;
	int maxnum 		= 1;
	
	
	/*
	 * command를 파라메터로 받아서 값에 따라 명령을 처리한다.
	 * Write : 등록 
	 * Update: 수정 
	 * Delete: 삭제
	 * Reply : 답글 등록
	 */
	
	if(request.getParameter("command") != null){
		command	= request.getParameter("command");					
	}
	
	if(request.getParameter("num") != null){
		num = Integer.valueOf(request.getParameter("num"));				// 게시글 번호		
	}
	
	if(request.getParameter("title") != null){
		title 	= request.getParameter("title");						// 제목
	}
	
	if(request.getParameter("ref") != null){
		ref = Integer.valueOf(request.getParameter("ref"));				// 참조 번호 (답글의 부모번호)
	}
	
	if(request.getParameter("restep") != null){
		restep = Integer.valueOf(request.getParameter("restep"));		// 답글 단계
	}
	
	if(request.getParameter("relevel") != null){
		relevel = Integer.valueOf(request.getParameter("relevel"));		// 답글 레벨
	}
	
	if(request.getParameter("writer") != null){
		writer = request.getParameter("writer");						// 등록자
	}
	
	if(request.getParameter("content") != null){
		content = request.getParameter("content");						// 내용
	}
	
	if(request.getParameter("password") != null){
		password = request.getParameter("password");					// 비밀번호
	}

	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://mydbinstance.ctvgpvyuejsa.ap-northeast-2.rds.amazonaws.com:3306/myShoppingmallDB?serverTimezone=UTC";
	
	String id = "shun04321";
	String pw = "awstbs421!";
	
	try{
		Class.forName(jdbc_driver);
		conn = DriverManager.getConnection(jdbc_url, id, pw);
		stmt = conn.createStatement();
		
		if( command.equals("Write"))									// 글쓰기 처리
		{															
			maxnum = 1;
			
			strQuery = "SELECT MAX(qa_id) FROM qanda";
			
			rs = stmt.executeQuery(strQuery);
			
			if(rs.next()){
				maxnum = rs.getInt(1);
			}
			rs.close();
			 
			strQuery  = "INSERT INTO qanda(qa_id,qa_title,user_id,qa_date,qa_content,qa_count,qa_password,qa_ref,qa_restep,qa_relevel) ";
			strQuery += "VALUES("+(maxnum+1)+",'"+title+"','"+writer+"',sysdate(),'"+content+"',0,'"+password+"',"+(maxnum+1)+",1,0)";
			
			retVal = stmt.executeUpdate(strQuery);
			
		}
		else if(command.equals("Reply"))								//답글 처리
		{																
			strQuery = "SELECT MAX(qa_id) FROM qanda";					//답글의 등록을 위해 MAX번호를 받아온다.
			
			rs = stmt.executeQuery(strQuery);
			
			if(rs.next()){												//ResultSet이 있으면
				maxnum = rs.getInt(1);									//maxnum 받아오기
			}
			rs.close();
			
			//현재 qa_restep보다 큰 qa_restep를 1씩 증가
			strQuery = "UPDATE qanda SET qa_restep= qa_restep + 1 where qa_ref="+ref+" and qa_restep > "+restep+"";
			retVal = stmt.executeUpdate(strQuery);
			
			//답글 저장
			strQuery  = "INSERT INTO qanda(qa_id,qa_title,user_id,qa_date,qa_content,qa_count,qa_password,qa_ref,qa_restep,qa_relevel) ";
			strQuery += "VALUES("+(maxnum+1)+",'"+title+"','"+writer+"',sysdate(),'"+content+"',0,'"+password+"',"+ref+","+(restep+1)+","+(relevel+1)+")";

			retVal = stmt.executeUpdate(strQuery);
			
		}
		else if(command.equals("Update"))								//글수정 처리
		{								
			strQuery = "UPDATE qanda SET qa_title='"+title+"'";
			strQuery += ",user_id='"+writer+"'";
			strQuery += ",qa_date=SYSDATE()";
			strQuery += ",qa_content='"+content+"' ";
			strQuery += ",qa_password='"+password+"' ";
			strQuery += "WHERE qa_id="+num+"";

			retVal = stmt.executeUpdate(strQuery);
			
		}
		else if(command.equals("Delete"))
		{																//글삭제 처리
			strQuery = "DELETE FROM qanda WHERE qa_id=" + num;			//질문만 삭제
			retVal = stmt.executeUpdate(strQuery);
		}
		
		stmt.close();
		conn.close();
	}catch(Exception e){
		out.write("exception : " + e.getMessage());
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
	
	response.sendRedirect("list.jsp");

%>