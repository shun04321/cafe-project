<!-- 인나현, 정채원 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
    String contentPage=request.getParameter("contentPage");
	if(contentPage==null)
		contentPage="firstview.jsp";
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>index</title>
<link href="./../css/index.css" rel="stylesheet" type="text/css" />
</head>

<body onload="javascript:openPopup('popup.html')">
	<%-- 팝업창으로 영업시간 띄우기 --%>
	<script>
		function getCookie(name) {
			var cookie = document.cookie;
			if (document.cookie != "") {
				var cookie_array = cookie.split(";");
				for ( var index in cookie_array) {
					var cookie_name = cookie_array[index].split("=");
					if (cookie_name[0] == "popupYN") {
						return cookie_name[1];
					}
				}
			}
			return;
			
		}
		
		function openPopup(url) {
			var cookieCheck = getCookie("popupYN");
			if (cookieCheck != "N") window.open("popup.html",'popup','width=450,height=270,left=0,top=0')
		}
		
	</script>

	<div id="wrap">
		<div id="header_inclu">
			<jsp:include page="./index_header.jsp"/>
		</div>
		<div id="main">
			<jsp:include page="<%=contentPage%>" />
		</div>
		<div id="footer">
			<jsp:include page="./footer.jsp" />
		</div>
	</div>

</body>
</html>