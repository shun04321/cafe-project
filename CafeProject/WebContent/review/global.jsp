<!-- 정채원 -->
<%@ page language="java" 
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>

<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
    
   
<%
	/** Connection **/
	Connection conn = null;
	
	/** Statement **/
	Statement stmt = null;
	
	/** ResultSet **/
	ResultSet rs = null;
	
	/** MYSQL URL **/
	String strJdbcUrl = "jdbc:mysql://localhost:3306/myShoppingmallDB";
	
	/** MYSQL Driver 문자열 정보 **/
	String strJdbcDriver = "com.mysql.jdbc.Driver";
	
	/** 쿼리문 **/
	String strQuery = "";

	/** 게시글 번호 **/
	int num = 1;
	
	/** 게시물 전체 건수 **/
	int nTotalRecord = 0;
	
	/** 페이지(리스트/게시물) **/
	int nTotalPage = 1;
	
	/** 페이지 당 출력 개수 **/
	int nSizePerPage = 10;
	
	/** 페이지 블럭(이전, 다음) **/
	int nPageBlockSize = 10;
	
	/** 현재 페이지 **/
	int nPageNum = 1;
	
	/** 조회시 첫번째로 가지고올 위치 **/
	int nFirstNcno = 1;
	
	/** 처음 시작 번호 **/
	int nDocStartNum = 1;

%>