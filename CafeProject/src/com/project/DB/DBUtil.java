package com.project.DB;

import java.sql.*;

public class DBUtil {

	  public static Connection getMySQLConnection(){
	    Connection conn = null;

	    try {
	      Class.forName("com.mysql.jdbc.Driver");
	      String url = "jdbc:mysql://127.0.0.1:3306/___?useUnicode=true&characterEncoding=UTF-8";
	      conn = DriverManager.getConnection(url, "root", "___");
	      System.out.println("Connect Ok!!<br/>");
	    } catch(ClassNotFoundException e) {
	      System.out.println("MySQL ����̹��� �����ϴ�.<br/>");
	    } catch(SQLException e){
	      System.out.println("����� ���� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.<br/>");
	    }
	    return conn;
	  }
	  public static void close(Connection conn){
	    try{if(conn != null){conn.close();} }catch(Exception e){e.printStackTrace();}
	  }
	  public static void close(Statement stmt){
	    try{if(stmt != null){stmt.close();} }catch(Exception e){e.printStackTrace();}
	  }
	  public static void close(PreparedStatement pstmt){
	    try{if(pstmt != null){pstmt.close();} }catch(Exception e){e.printStackTrace();}
	  }
	  public static void close(ResultSet rs){
	    try{if(rs != null){rs.close();} }catch(Exception e){e.printStackTrace();}
	  }
	}
