<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Footer</title>
<script>
		function changeView(value){
			if(value=="0")
				location.href="index.jsp?contentPage=terms_of_use.jsp";
			else if(value=="1")
				location.href="https://www.instagram.com/dongduk_w_univ";
			else if(value=="2")
				location.href="index.jsp?contentPage=road.jsp";
			else if(value=="3")
				location.href="index.jsp?contentPage=index_notice.jsp";	
		}
</script>
</head>
<body>
	<footer class="foot">
	
		<div align="center" class="text-box">
			<span class="footer-menu" onclick="changeView(0)">이용약관</span>
			<span class="footer-menu" onclick="changeView(1)">커뮤니티</span>
			<span class="footer-menu" onclick="changeView(2)">찾아오시는길</span>
			<span class="footer-menu" onclick="changeView(3)">공지사항</span>
		</div>
		
        <div class="copyright">
              <span>Copyright ⓒ 2022 DongDuk.Computer_Science.</span>
              <span>All Rights Reserved.</span>
        </div>
	</footer>
	
</body>
</html>