<!-- 인나현 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MENU INSERT</title>
<link href="./../css/admin.css" rel="stylesheet" type="text/css" />
</head>
<body>
	
	<div class="menu-insert-form">
		<h1 class="menu-insert-form">MENU INSERT FORM</h1>
		
		<form action="./menu_insert_action.jsp" method="post" enctype="multipart/form-data">
			<table class="menu-insert-table">
				<tr>
					<th>menu number</th>
					<td><input type="text" name="menu_id"></td>
				</tr>
				<tr>
					<th>menu</th>
					<td><input type="text" name="menu_name"></td>
				</tr>
				<tr>
					<th>menu category</th>
					<td>
						<select name="menu_category">
							<option name="coffee">coffee</option>
							<option name="dessert">dessert</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>menu price</th>
					<td><input type="text" name="menu_price"></td>
				</tr>
				<tr>
					<th>menu stock</th>
					<td><input type="text" name="menu_stock"></td>
				</tr>
				<tr>
					<th>menu description</th>
					<td><textarea cols="50" rows="10" name="menu-intro" style="width: 446px; height: 150px;"></textarea></td>
				</tr>
				<tr>
					<th>menu image</th>
					<td><input type="file" name="menu_img"></td>
				</tr>
			</table>
		
			<h1 class="menu-insert-form"><input class="menu-insert-btn" type="submit" value="submit"></h1>
		</form>
	</div>
	
</body>
</html>