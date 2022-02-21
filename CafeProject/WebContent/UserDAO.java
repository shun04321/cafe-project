package com.project.dao;

import java.sql.*;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.project.dto.*;

public class UserDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs;
	
	private String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	private String jdbc_url = "jdbc:mysql://mydbinstance.ctvgpvyuejsa.ap-northeast-2.rds.amazonaws.com:3306/myShoppingmallDB?serverTimezone=UTC";
	
	private String id = "shun04321";
	private String pw = "awstbs421!";
	
	public UserDAO() {
		
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
	}
	
	public void UserInsert(UserDTO user) {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
			
			String sql = "insert into user values(?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPW());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUser_address());
			pstmt.setString(5, user.getUser_phone());
			pstmt.setString(6, user.getUser_email());
			
			int update = pstmt.executeUpdate();
			
			if(update == 0) System.out.println("DB 업데이트 실패");
			else System.out.println("DB 업데이트 성공");
		}
		catch(Exception e) {
			System.out.println(e);
		}finally{
			try{
				pstmt.close();
			}catch(Exception ignored){}
			try{
				conn.close();
			}catch(Exception ignored){}
		}
	}
	
	//로그인 진행하는 함수
	public int login(String user_id, String user_pwd) {
		String sql = "SELECT user_pwd FROM user where user_id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(user_pwd)) return 1; //로그인 성공
				else return 0; //비밀번호 불일치
			}
			return -1; //존재하지 않는 아이디
		}catch (Exception e) {
			System.out.println(e);// TODO: handle exception
		}
		return -2; //데이터 베이스 오류
	}
	
	public boolean resign(String user_id, String user_pwd) {
		
		String sql = "DELETE FROM user WHERE user_id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			
			int i = pstmt.executeUpdate();
			
			if(i==1) {
				Boolean flag = true;
			}
			else {
				Boolean flag = false;
			}
		}catch (Exception e) {
			System.out.println(e);// TODO: handle exception
		}
		return false;
	}
	
	//아이디 중복체크 함수
	public int idCheck(String user_id){
		  int rst = 0;
		  Connection conn = null;
		  PreparedStatement ps = null;
		  ResultSet rs = null;
		  
		  try{
			   conn = DriverManager.getConnection(jdbc_url, id, pw);
			   String sql = "select * from user where user_id=?";
			   ps = conn.prepareStatement(sql);
			   ps.setString(1, user_id);
			   rs = ps.executeQuery();
			   if(rs.next()){
				   rst = 1;
			   }
		  }catch(Exception e){
			   e.printStackTrace();
		  }finally{
				try{
					conn.close();
				}catch(Exception ignored){}
		  }
		  return rst;
	}
}