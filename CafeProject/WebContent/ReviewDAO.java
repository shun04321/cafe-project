package com.project.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.*;
import com.project.dto.*;

public class ReviewDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs;

	private String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	private String jdbc_url = "jdbc:mysql://mydbinstance.ctvgpvyuejsa.ap-northeast-2.rds.amazonaws.com:3306/myShoppingmallDB?serverTimezone=UTC";

	private String id = "shun04321";
	private String pw = "awstbs421!";


	public ReviewDAO() {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}

	// review 테이블에서 가장 큰 review_id + 1 인 수를 반환하는 함수
	public int getNext() {
		// review 테이블에서 review_id를 내림차순하여 반환
		String sql = "select review_id from review order by review_id desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // review 테이블에 데이터가 없는 경우 1 반환
		}catch (Exception e) {
			e.printStackTrace();
		}
		return 1; // review 테이블에 데이터가 없는 경우 1 반환
	}

	// review 테이블에 insert 하는 함수 
	public void write(ReviewDTO review, String userID) { 
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);

			String sql = "insert into review values(?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, getNext());
			pstmt.setInt(2, review.getOrderID());
			pstmt.setInt(3, review.getProductID());
			pstmt.setString(4, userID);
			pstmt.setString(5, review.getReview_content());
			pstmt.setTimestamp(6, review.getDate());
			pstmt.setInt(7, review.getGrade());

			int update = pstmt.executeUpdate();

			if(update == 0) System.out.println("DB 업데이트 성공");
			else System.out.println("DB 업데이트 실패");
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

	// 리뷰를 썼으면 order_detail의 write_review를 1로 만들어주는 함수 ( write_review가 0인 주문건만 리뷰 작성 가능)
	public void changeStatus(int orderID, String userID, int productID) {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);

			String sql = "update order_detail set write_review=1 where order_id = ? and user_user_id = ? and product_id = ?;";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, orderID);
			pstmt.setString(2, userID);
			pstmt.setInt(3, productID);

			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	// review_id를 내림차순으로 nFirstNcn부터 10개의 review를 리스트로 반환하는 함수
	public List<ReviewDTO> reviewList(int nSizePerPage, int nFirstNcno){		
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);

			String sql = "select review_id, product_name, grade, user_id, review_date from review as r join product as p where r.product_id=p.product_id order by review_id desc limit ? offset ?;";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, nSizePerPage);
			pstmt.setInt(2, nFirstNcno);			
			rs = pstmt.executeQuery();

			List<ReviewDTO> list = new ArrayList<ReviewDTO>();

			while(rs.next()) {
				ReviewDTO review_dto = new ReviewDTO();

				review_dto.setReviewID(rs.getInt("review_id"));
				review_dto.setProductName(rs.getString("product_name"));
				review_dto.setGrade(rs.getInt("grade"));
				review_dto.setUserID(rs.getString("user_id"));
				review_dto.setDate(rs.getTimestamp("review_date"));
				list.add(review_dto);
			}
			return list;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// review 테이블 전체를 리스트로 반환하는 함수
	public List<ReviewDTO> showReview(int reviewID) {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);

			String sql = "select review_id, product_name, grade, review_content, user_id, review_date from review as r join product as p where r.product_id=p.product_id and review_id =?;";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, reviewID);
			rs = pstmt.executeQuery();

			List<ReviewDTO> list = new ArrayList<ReviewDTO>();

			while(rs.next()) {
				ReviewDTO review_dto = new ReviewDTO();

				review_dto.setReviewID(rs.getInt("review_id"));
				review_dto.setProductName(rs.getString("product_name"));
				review_dto.setGrade(rs.getInt("grade"));
				review_dto.setReview_content(rs.getString("review_content"));
				review_dto.setUserID(rs.getString("user_id"));
				review_dto.setDate(rs.getTimestamp("review_date"));
				list.add(review_dto);
			}
			return list;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;		
	}
}