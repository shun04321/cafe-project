package com.project.dao;

import java.sql.Connection;


import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import com.project.dto.*;

public class OrderDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs;

	private String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	private String jdbc_url = "jdbc:mysql://mydbinstance.ctvgpvyuejsa.ap-northeast-2.rds.amazonaws.com:3306/myShoppingmallDB?serverTimezone=UTC";

	private String id = "shun04321";
	private String pw = "awstbs421!";

	public OrderDAO() {

		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
		}
		catch(Exception e) {
			System.out.println(e);
		}

	}

	
	// 주문일자 메소드
	public String getDate() {
		String sql = "select now()";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}

	
	// 주문번호(order_id) 부여 메소드
	public int getNext() {
		//현재 리뷰 게시판을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String sql = "select order_id from orders order by order_id desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물인 경우
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	// order_detail 테이블에 개별 주문 상품 등록
	public int insertOrderDetail(OrderDetailDTO orderdetail, String userId, int orderId) {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);

			String sql = "insert into order_detail values(?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, orderdetail.getDetailNUM());
			pstmt.setString(2, userId);
			pstmt.setInt(3, orderId);
			pstmt.setInt(4, orderdetail.getProductID());
			pstmt.setInt(5, 0);
			
			return pstmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return -1; // 데이터 베이스 오류
	}
	
	// 주문 등록 메소드
	public int insertOrder(String userId) {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);

			String sql = "insert into order values(?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			int orderId = getNext();
			pstmt.setInt(1, orderId);
			pstmt.setString(2, getDate());
			pstmt.setString(3, userId);
			
			int update = pstmt.executeUpdate();
			
			if(update == 0) System.out.println("DB 업데이트 실패");
			else System.out.println("DB 업데이트 성공");
			
			return orderId;
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return -1; // 데이터 베이스 오류
	}

	// 구매기록 있는데 작성한 리뷰가 없는지 검사
	public int isBought(String userId) {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);

			String sql = "select count(*) from order_detail where order_user_user_id= ? and write_review=0;";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
					
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt(1) == 0) return 0; // 구매 X or 작성할 리뷰 X
				else return 1; // 리뷰 작성 가능
			}
			return -1; //존재하지 않는 아이디
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return -1; // 데이터 베이스 오류
	}
	
	// write_review가 0인 orderDetail 데이터가 담긴 list를 반환
	public List<OrderDetailDTO> orderList(String userId){	
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);

			String sql = "select * from order_detail where order_user_user_id= ? and write_review=0;";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			ArrayList<OrderDetailDTO> list = new ArrayList<OrderDetailDTO>();
			
			while(rs.next()) {
				OrderDetailDTO detail = new OrderDetailDTO();
				
				detail.setDetailNUM(rs.getInt("detail_num"));
				detail.setUserID(rs.getString("order_user_user_id"));
				detail.setOrderID(rs.getInt("order_order_id"));
				detail.setProductID(rs.getInt("product_product_id"));
				detail.setWriteREVIEW(rs.getInt("write_review"));
				list.add(detail);
			}		
			return list;
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String findProductName(int productId) {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);

			String sql = "select * from product as p join order_detail as d on p.product_id=d.product_product_id where p.product_id=?;";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, productId);
			
			rs = pstmt.executeQuery();
			
			String productName=null;
			while(rs.next()) {
				productName = rs.getString("product_name");
			}
			
			return productName;
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int findOrderID(String userId, int productId) {
		// order_detail 테이블에서 product_id가 같고 write_review가 0인 항목이 여러개일때 order_id가 가장 작은 것을 반환
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);

			String sql = "select min(order_order_id) \r\n"
					+ "from `order_detail` \r\n"
					+ "where order_user_user_id = ? and write_review=0 and product_product_id=?\r\n"
					+ "group by order_user_user_id;";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			pstmt.setInt(2, productId);			
			rs = pstmt.executeQuery();
			
			int minOrderId = -1;
			while(rs.next()) {
				minOrderId = rs.getInt(1);
			}
			
			return minOrderId;
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}




