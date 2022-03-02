<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찾아오시는 길</title>
</head>
<style>
	.map_wrap {
		margin-top: 50px;
		margin-bottom: 50px;
	}
	
	.map1 {
		text-align: left;
	}
</style>
<body>
	<h1>Cafe</h1>
	<div class="map_wrap">
		<table class="map1">
			<tbody>
				<tr>
					<th>주소</th>
					<td>서울특별시 성북구 화랑로13길 60 (하월곡동 23-1)</td>
				</tr>
				<tr>
					<th>지하철</th>
					<td>6호선 월곡역</td>
				</tr>
				<tr>
					<th>TEL</th>
					<td>02-940-4000</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- * Daum 지도 - 지도퍼가기 -->
	<!-- 1. 지도 노드 -->
	<div id="daumRoughmapContainer1526641937116" class="root_daum_roughmap root_daum_roughmap_landing" style="width: 100%; margin-bottom: 210px;"></div>

	<!--2. 설치 스크립트 * 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.-->
	<script charset="UTF-8" class="daum_roughmap_loader_script"
		src="//ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>

	<!-- 3. 실행 스크립트 -->
	<script charset="UTF-8">
		new daum.roughmap.Lander({
			"timestamp" : "1526641937116",
			"key" : "o8ba",
			"mapWidth" : "",
			"mapHeight" : ""
		}).render();
	</script>
</body>
</html>