<!-- 인나현 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.project.dto.ProductDTO"%>
<%@ page import="com.project.dao.ProductDAO"%>

	<%
		request.setCharacterEncoding("utf-8");
	
		try{
			String path = this.getClass().getResource("").getPath();
			path = path.substring(1,path.indexOf(".metadata"))+"cafe\\src\\main\\webapp\\images";
			MultipartRequest multi = new MultipartRequest(request, path, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
			
			ProductDTO product_dto = new ProductDTO();
			ProductDAO product_dao = new ProductDAO();

			Integer product_id = Integer.parseInt(multi.getParameter("menu_id"));
			String product_name = multi.getParameter("menu_name");
			String product_category = multi.getParameter("menu_category");
			Integer product_price = Integer.parseInt(multi.getParameter("menu_price"));
			Integer product_stock  = Integer.parseInt(multi.getParameter("menu_stock"));
			String product_intro = multi.getParameter("menu-intro");
			String fileName = multi.getOriginalFileName("menu_img"); // 이전 클래스 name = "menu_img" 실제 사용자가 저장한 실제 네임
			String fileRealName = multi.getFilesystemName("menu_img"); //실제 서버에 업로드 된 파일시스템 네임
			
			product_dto.setProductID(product_id);
			product_dto.setProductNAME(product_name); 
			product_dto.setProductCATEGORY(product_category);
			product_dto.setProductPRICE(product_price );
			product_dto.setProductSTOCK(product_stock);
			product_dto.setProductINTRO(product_intro);
			product_dto.setProductIMG(fileRealName);
			
			product_dao.ProductInsert(product_dto);
			
		}catch(Exception e){
			System.out.println(e);
		}
		
	%>
	
	<script>
      	alert("상품 등록 성공");
      	history.back();
    </script>