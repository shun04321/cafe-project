package com.project.dao;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.project.dto.*;

public class CartDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs;

	//mysql 연결정보
	private String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	private String jdbc_url = "jdbc:mysql://mydbinstance.ctvgpvyuejsa.ap-northeast-2.rds.amazonaws.com:3306/myShoppingmallDB?serverTimezone=UTC";

	private String id = "shun04321";
	private String pw = "awstbs421!";

	public CartDAO() {}

	//DB 연결 method
	void connect() {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
		}catch (Exception e) {
			System.out.println(e);
		}
	}

	void disconnect() {
		if(pstmt != null) {
			try{
				pstmt.close();
			}catch(Exception ignored){}
		}
		if(conn != null) {
			try{
				conn.close();
			}catch(Exception ignored){}
		}
	}

	public int getNext() {
		String sql = "select cart_id from cart order by cart_id desc";
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

	public int isinCart(CartDTO cart){
		try {
			connect();

			String sql = "select product_qty from cart where user_id=? and product_id=?;";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cart.getUser_id());
			pstmt.setInt(2, cart.getProduct_id());
			rs = pstmt.executeQuery();

			if(rs.next()) {
				if(rs.getInt(1) == 0) return 0; // 구매 X or 작성할 리뷰 X
				else return 1; // 이미 장바구니에 존재
			}
			return -1; //존재하지 않는 아이디
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return -1; // 데이터 베이스 오류
	}

	// cart에 해당 메뉴가 있는 경우 실행할 함수
	public void CartUpdate(CartDTO cart) {
		try {
			connect();

			// 실제로 수정후 장바구니 페이지에도 변화 반영되는지 체크하기
			String sql = "update cart set product_qty = ? where user_id = ? and product_id = ?;";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart.getProduct_qty());
			pstmt.setString(2, cart.getUser_id());
			pstmt.setInt(3,  cart.getProduct_id());
			
			int update = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	// cart에 해당 메뉴가 없는 경우 실행할 함수
	public void CartInsert(CartDTO cart) throws SQLException {
		connect();

		int flag = isinCart(cart);

		if(flag==1) {
			CartUpdate(cart);  
			return;
		}
		try {
			int cartId = getNext();
			String sql = "insert into cart values(?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, cartId);
			pstmt.setString(2, cart.getUser_id());
			pstmt.setInt(3, cart.getProduct_id());
			pstmt.setInt(4, cart.getProduct_qty());

			int update = pstmt.executeUpdate();

			if(update == 0) System.out.println("DB 업데이트 실패");
			else System.out.println("DB 업데이트 성공");

		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		finally {
			disconnect();
		}

	}

	// cart 테이블의 모든 레코드를 반환하는 함수
	public List<CartDTO> cartList(String userId){
		try {
			connect();

			String sql = "select product_id, product_qty from cart where user_id = ?;";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();

			List<CartDTO> list = new ArrayList<CartDTO>();

			while(rs.next()) {
				CartDTO cart_dto = new CartDTO();

				cart_dto.setProduct_id(rs.getInt("product_id"));
				cart_dto.setProduct_qty(rs.getInt("product_qty"));			
				list.add(cart_dto);
			}
			return list;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;		
	}

	// cart 테이블에서 해당 product_id인 레코드를 삭제
	public void CartDelete(String userId, int productId) {
		connect();

		String sql = "delete from cart where user_id = ? and product_id = ?;";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);
			pstmt.setInt(2,  productId);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public CartDTO cartByProductID(String userId, int productId){
		try {
			connect();

			String sql = "select product_id, product_qty from cart where user_id = ? and product_id = ?;";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);
			pstmt.setInt(2, productId);
			rs = pstmt.executeQuery();

			CartDTO cart_dto = new CartDTO();
			
			while(rs.next()) {
				cart_dto.setProduct_id(rs.getInt("product_id"));
				cart_dto.setProduct_qty(rs.getInt("product_qty"));			
			}
			return cart_dto;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;		
	}
}