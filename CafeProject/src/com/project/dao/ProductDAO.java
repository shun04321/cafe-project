package com.project.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.project.dto.*;

public class ProductDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs;
	
	//mysql ��������
	private String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	private String jdbc_url = "jdbc:mysql://mydbinstance.ctvgpvyuejsa.ap-northeast-2.rds.amazonaws.com:3306/myShoppingmallDB?serverTimezone=UTC";
	
	private String id = "shun04321";
	private String pw = "awstbs421!";
	
	public ProductDAO() {}
	
	//DB ���� method
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
	
	//�޴��� insert - ����
	public void ProductInsert(ProductDTO product) {
		connect();
		
		String sql = "insert into product values(?, ?, ?, ?, ?, ?, (now()), ?)";
		try {
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, product.getProductID());
			pstmt.setString(2, product.getProductNAME());
			pstmt.setString(3, product.getProductCATEGORY());
			pstmt.setInt(4, product.getProductPRICE());
			pstmt.setInt(5, product.getProductSTOCK());
			pstmt.setString(6, product.getProductINTRO());
			pstmt.setString(7, product.getProductIMG());
			
			int update = pstmt.executeUpdate();
			
			if(update == 0) System.out.println("DB ������Ʈ ����");
			else System.out.println("DB ������Ʈ ����");
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
	
	//Ư�� �޴� �������� - ����
	public ProductDTO getProduct(int product_id) {
		connect();

		String sql = "select * from product where product_id=?";
		ProductDTO product = new ProductDTO();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();
						
			rs.next();
			product.setProductID(rs.getInt("product_id"));
			product.setProductNAME(rs.getString("product_name"));
			product.setProductCATEGORY(rs.getString("product_category"));
			product.setProductPRICE(rs.getInt("product_price"));
			product.setProductSTOCK(rs.getInt("product_stock"));
			product.setProductINTRO(rs.getString("product_intro"));
			product.setProductIMG(rs.getString("product_img"));
			rs.close();
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		finally {
			disconnect();
		}
		return product;
	}
	
	
	//Ŀ�� ����� �������� method - ����
	public ArrayList<ProductDTO> getProductCoffeeList(){
		connect();
		ArrayList<ProductDTO> coffeeList = new ArrayList<ProductDTO>();
		
		try {
			String sql = "select * from product where product_category='coffee';";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product = new ProductDTO();
				
				product.setProductID(rs.getInt("product_id"));
				product.setProductNAME(rs.getString("product_name"));
				product.setProductCATEGORY(rs.getString("product_category"));
				product.setProductPRICE(rs.getInt("product_price"));
				product.setProductSTOCK(rs.getInt("product_stock"));
				product.setProductINTRO(rs.getString("product_intro"));
				product.setProductIMG(rs.getString("product_img"));
				
				coffeeList.add(product);
			}
			rs.close();
		}catch (Exception e) {
			System.out.println(e);
		}finally {
			disconnect();
		}
		return coffeeList;
	}

	
	//����Ʈ ����� �������� method - ����
	public ArrayList<ProductDTO> getProducts_dessertlist() { //��ǰ���

        ArrayList<ProductDTO> dessertList = new ArrayList<ProductDTO>();
        try {

            Class.forName(jdbc_driver);
            conn = DriverManager.getConnection(jdbc_url, id, pw);

            String sql = "SELECT * FROM product where product_category='dessert'";
            pstmt = conn.prepareStatement(sql);

            rs = pstmt.executeQuery();

            while(rs.next()) {

    			ProductDTO product = new ProductDTO();
    			
    			product.setProductID(rs.getInt("product_id"));
    			product.setProductNAME(rs.getString("product_name"));
    			product.setProductCATEGORY(rs.getString("product_category"));
    			product.setProductPRICE(rs.getInt("product_price"));
    			product.setProductSTOCK(rs.getInt("product_stock"));
    			product.setProductINTRO(rs.getString("product_intro"));
    			product.setProductIMG(rs.getString("product_img"));
    			
    			dessertList.add(product);
    		
    			}
    		rs.close();

    }catch (Exception e) {
        System.out.println(e);
    }
    return dessertList;
    } 
	
	public ArrayList<ProductDTO> getCoffeeDESC(){//coffee ���� ���ݼ�
        
		
        ArrayList<ProductDTO> coffeeDESC = new ArrayList<ProductDTO>();

        try {
    		Class.forName(jdbc_driver);
    		conn = DriverManager.getConnection(jdbc_url, id, pw);
    		
            String sql = "select * from product where product_category='coffee' order by product_price desc";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                ProductDTO product = new ProductDTO();

                product.setProductID(rs.getInt("product_id"));
                product.setProductNAME(rs.getString("product_name"));
                product.setProductCATEGORY(rs.getString("product_category"));
                product.setProductPRICE(rs.getInt("product_price"));
                product.setProductSTOCK(rs.getInt("product_stock"));
                product.setProductINTRO(rs.getString("product_intro"));
                product.setProductIMG(rs.getString("product_img"));

                coffeeDESC.add(product);
            }
            rs.close();
        }catch (Exception e) {
            System.out.println(e);
        }
        return coffeeDESC;
    }
	
	public ArrayList<ProductDTO> getdessertDESC() { //dessert ���� ���ݼ�

		ArrayList<ProductDTO> desserDESC = new ArrayList<ProductDTO>();
		try {
			
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
			
			String sql = "select * from product where product_category='dessert' order by product_price desc";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();

			while(rs.next()) {

			ProductDTO product = new ProductDTO();
			
			product.setProductID(rs.getInt("product_id"));
			product.setProductNAME(rs.getString("product_name"));
			product.setProductCATEGORY(rs.getString("product_category"));
			product.setProductPRICE(rs.getInt("product_price"));
			product.setProductSTOCK(rs.getInt("product_stock"));
			product.setProductINTRO(rs.getString("product_intro"));
			product.setProductIMG(rs.getString("product_img"));
			
			desserDESC.add(product);
		
			}
		rs.close();

	}catch (Exception e) {
        System.out.println(e);
	}
   
	return desserDESC;

	}
	
	public ArrayList<ProductDTO> getCoffeeASC(){//coffee ���� ���ݼ�
        
		
        ArrayList<ProductDTO> coffeeASC = new ArrayList<ProductDTO>();

        try {
    		Class.forName(jdbc_driver);
    		conn = DriverManager.getConnection(jdbc_url, id, pw);
    		
            String sql = "select * from product where product_category='coffee' order by product_price";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                ProductDTO product = new ProductDTO();

                product.setProductID(rs.getInt("product_id"));
                product.setProductNAME(rs.getString("product_name"));
                product.setProductCATEGORY(rs.getString("product_category"));
                product.setProductPRICE(rs.getInt("product_price"));
                product.setProductSTOCK(rs.getInt("product_stock"));
                product.setProductINTRO(rs.getString("product_intro"));
                product.setProductIMG(rs.getString("product_img"));

                coffeeASC.add(product);
            }
            rs.close();
        }catch (Exception e) {
            System.out.println(e);
        }
        return coffeeASC;
    }
	
	public ArrayList<ProductDTO> getdessertASC() { //dessert ���� ���ݼ�

		ArrayList<ProductDTO> dessertASC = new ArrayList<ProductDTO>();
		try {
			
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
			
			String sql = "select * from product where product_category='dessert' order by product_price";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();

			while(rs.next()) {

			ProductDTO product = new ProductDTO();
			
			product.setProductID(rs.getInt("product_id"));
			product.setProductNAME(rs.getString("product_name"));
			product.setProductCATEGORY(rs.getString("product_category"));
			product.setProductPRICE(rs.getInt("product_price"));
			product.setProductSTOCK(rs.getInt("product_stock"));
			product.setProductINTRO(rs.getString("product_intro"));
			product.setProductIMG(rs.getString("product_img"));
			
			dessertASC.add(product);
		
			}
		rs.close();

	}catch (Exception e) {
        System.out.println(e);
	}
   
	return dessertASC;

	}
	
	public String imageSrc(String productName) {
		String src = null;
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
			
			String sql = "select product_img from product where product_name=?;";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, productName);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				src=rs.getString(1);
			}
			return src;
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return src;
	}
	
	public String productIntro(String productName) {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
			
			String sql = "select product_intro from product where product_name=?;";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, productName);
			rs = pstmt.executeQuery();
			
			String intro=null;
			while(rs.next()) {
				intro=rs.getString("product_intro");
			}
			return intro;
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public int findProductID(String productName) {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
			
			String sql = "select product_id from product where product_name = ?;";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, productName);
			rs = pstmt.executeQuery();
			
			int productId = -1;
			while(rs.next()) {
				productId=rs.getInt("product_id");
			}
			return productId;
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
	// �޴� �̸� ��ȯ�ϴ� �Լ�
	public String findProductName(int productId) {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
			
			String sql = "select product_name from product where product_id = ?;";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, productId);
			rs = pstmt.executeQuery();
			
			String productName = null;
			while(rs.next()) {
				productName=rs.getString(1);
			}
			return productName;
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return null; // �����ͺ��̽� ����
	}
	
	// �޴� ���� * ������ ��ȯ�ϴ� �Լ�
	public int getPrice(String productName, int productQty) {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, id, pw);
			
			String sql = "select product_price from product where product_name = ?;";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, productName);
			rs = pstmt.executeQuery();
			
			int price = 0;
			while(rs.next()) {
				price=rs.getInt(1);
			}
			return price*productQty;
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return -1; // �����ͺ��̽� ����			
	}
}
