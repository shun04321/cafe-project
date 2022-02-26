<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.project.dto.*"%>
<%@ page import="com.project.dao.*"%>


<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title>JOIN US</title>
<style>
	body {
		font-size: 12px;
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif; 
	}
	
	label{
		background:#C4C8CC;
		height:30;
		width:100px;
	}
	
	.input {
		width:10%;
		height:20px;;
		border:1px solid #C4C8CC;
		padding-top:5px; 
		font-size: 12px;
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif; 
		vertical-align: middle;
	}
	
	input {
		width:20%;
		height:20px;
		border:1px solid #C4C8CC;
		padding:5px; 
		font-size: 12px;
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif; 
		vertical-align: middle;
	}
	
	input.button {
		width:12%;
		height:30px;
		font-size: 10px;
	}
	
	input.add {
		width:40%;
	}
	
	textarea{
		width:99%;
		height:300px;;
		border:1px solid #C4C8CC;
		padding-top:6px; 
		font-size: 12px;
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif; 
	}
	
	table.list {
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
	    font-weight: 400;
	    border-spacing: 0;
	    border-collapse: collapse;
	    line-height: 60px;
	    color: #4e4c4a;
	    font-size: 12px;
	    letter-spacing: -0.3px;
	    word-break: break-all;
    	word-wrap: break-word;
	    padding: 30px 0;
	    vertical-align: middle;
	    width: 75%;
	    position: relative;
	    margin: 20px 0 0;
	    border: 1px solid #eeeeee;
	}
	
	tr {
		border: 1px solid #eeeeee;
	}
	h2 {
		font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
	    font-size: 25px;
	    line-height: 30px;
	    font-weight: 300;
	    color: rgb(65, 74, 67);
	    font-color: #414a43;
	}
	
	input.joinus {
	    font-family: 'Nunito Sans', 'Noto Sans KR', sans-serif;
	    cursor: pointer;
	    display: inline-block;
	    box-sizing: border-box;
	    border: 1px solid transparent;
	    text-decoration: none;
	    vertical-align: middle;
	    letter-spacing: -0.3px;
	    text-align: center;
	    white-space: nowrap;
	    transition: 0.2s ease-in-out;
	    color: #ffffff;
	    background-color: #222222;
	    word-break: keep-all;
	    word-wrap: break-word;
	    width: 150px;
	    height: 45px;
	    line-height: 30px;
	    padding: 0;
	    font-size: 14px;
	    font-weight: 400;
	}
</style>
<script language="javascript">
function idCheck() {
	var id = join.id.value;
	var url = "./idCheck.jsp?id=" + id;
	window.open(url, "get", "height = 180, width = 300");
}
            function validate() {
                var re1 = /^[a-z0-9]{4,16}$/ // 아이디가 적합한지 검사할 정규식
                var re2 = /^[a-zA-Z0-9#?!@$%^&*-]{8,16}$/ // 비밀번호가 적합한지 검사할 정규식
                var re3 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
                // 이메일이 적합한지 검사할 정규식
                var re4 = /^[0-9]{4}$/ // 전화번호가 적합한지 검사할 정규식
 
                var user_id = document.getElementById("id");
                var user_pwd = document.getElementById("pwd");
                var user_email = document.getElementById("email");
                var user_phone1 = document.getElementById("phone1");
                var user_phone2 = document.getElementById("phone2");
                var user_phone3 = document.getElementById("phone3");
                var user_phonenum = user_phone1 + user_phone2 + user_phone3;
                var user_addr1= document.getElementById("addr1");
                var user_addr2= document.getElementById("addr2");
                var user_addr3= document.getElementById("addr3");
                var user_address = user_addr1 + " " + user_addr2 + " " + user_addr3;
 
                // ------------ 이메일 까지 -----------
 
	 			
                if(!check(re1,user_id,"아이디는 4~16자의 영문 소문자,숫자로만 입력")) {
                    return false;
                }
 
                if(!check(re2,user_pwd,"비밀번호는 8~16자의 영문 대소문자,숫자,특수문자로만 입력")) {
                    return false;
                }
 
                if(join.pwd.value != join.checkpwd.value) {
                    alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
                    join.checkpwd.value = "";
                    join.checkpwd.focus();
                    return false;
                }
 
                if(join.email.value=="") {
                    alert("이메일을 입력해 주세요");
                    join.email.focus();
                    return false;
                }
 
                if(!check(re3, user_email, "적합하지 않은 이메일 형식입니다.")) {
                    return false;
                }
 
                if(join.name.value=="") {
                    alert("이름을 입력해 주세요");
                    join.name.focus();
                    return false;
                }
                
                if(join.phone2.value=="") {
                    alert("전화번호를 입력해 주세요");
                    join.phone2.focus();
                    return false;
                }
                
                if(join.phone3.value=="") {
                    alert("전화번호를 입력해 주세요");
                    join.phone3.focus();
                    return false;
                }
                
                if(!check(re4,user_phone2,"전화번호는 4자리 숫자로만 입력")) {
                    return false;
                }
                
                if(!check(re4,user_phone3,"전화번호는 4자리 숫자로만 입력")) {
                    return false;
                }
                
                if(join.addr1.value=="") {
                    alert("주소를 입력해 주세요");
                    join.addr1.focus();
                    
                    return false;
                }
                
                if(join.addr2.value=="") {
                    alert("주소를 입력해 주세요");
                    join.addr2.focus();
                    return false;
                }
                
                if(join.addr2.value=="") {
                    alert("주소를 입력해 주세요");
                    join.addr2.focus();
                    return false;
                }
            }
            
            function check(re1, what, message) {
                if(re1.test(what.value)) {
                    return true;
                }
                alert(message);
                what.value = "";
                what.focus();
                //return false;
            }
            
            function idCheck() {
            	var id = join.id.value;
            	var url = "./idCheck.jsp?id=" + id;
                var width = "300";
                var height = "180";
                var left = Math.ceil(( window.screen.width - width )/2);
                var top = Math.ceil(( window.screen.height - height )/2); 
             
            	window.open(url, "get", "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top);
            }
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
                //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
                function sample4_execDaumPostcode() {
                    new daum.Postcode({
                        oncomplete: function(data) {
                            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                            var roadAddr = data.roadAddress; // 도로명 주소 변수
                            var extraRoadAddr = ''; // 참고 항목 변수
                            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                            
                            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                extraRoadAddr += data.bname;
                            }
                            // 건물명이 있고, 공동주택일 경우 추가한다.
                            if(data.buildingName !== '' && data.apartment === 'Y'){
                               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                            if(extraRoadAddr !== ''){
                                extraRoadAddr = ' (' + extraRoadAddr + ')';
                            }
                            // 우편번호와 주소 정보를 해당 필드에 넣는다.
                            document.getElementById('sample4_postcode').value = data.zonecode;
                            document.getElementById("sample4_roadAddress").value = roadAddr;
                            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                     
                            document.getElementById("sample4_engAddress").value = data.addressEnglish;
                                   
                            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                            if(roadAddr !== ''){
                                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                            } else {
                                document.getElementById("sample4_extraAddress").value = '';
                            }
                            var guideTextBox = document.getElementById("guide");
                            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                            if(data.autoRoadAddress) {
                                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                                guideTextBox.innerHTML = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp(예상 도로명 주소 : ' + expRoadAddr + ')';
                                guideTextBox.style.display = 'block';
                            } else if(data.autoJibunAddress) {
                                var expJibunAddr = data.autoJibunAddress;
                                guideTextBox.innerHTML = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp(예상 지번 주소 : ' + expJibunAddr + ')';
                                guideTextBox.style.display = 'block';
                            } else {
                                guideTextBox.innerHTML = '';
                                guideTextBox.style.display = 'none';
                            }
                        }
                    }).open();
                }
</script>
</head>

<body>

<!-- 정민지 -->

	<%
		UserDAO udao = new UserDAO();

		String user_id = null;
		if(session.getAttribute("id") != null) 
			user_id = (String)session.getAttribute("id");
		
		UserDTO udto = udao.getUser(user_id);
	%>
	
<div align="center">
		<form name="join" onsubmit="return validate();" method="post" action="./../mypage/modify_action.jsp">
		<br><br><br><br><br><br>
	
		<!-- TITLE START -->
		<table width="800" cellpadding="0" cellspacing="0">
			<tr>
				<td width="800" height="50">
				<h2>Modify</h2>
				</td>
			</tr>
		</table>
		<!-- TITLE END -->
		
		<br><br><br><br><br>
		<!--<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>"/>-->
		<table class="list" border="1" align="center">
	<tr>
		<td align="center" width="150" height="50" bgcolor="#eeeeee">아이디<font color="blue">*</font></td>
		<td>
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<input name="id" id="id" type="text" value="<%=udto.getUserID()%>" readonly="readonly" size="15" maxlength="16">
		&nbsp *변경불가능
		</td>
	</tr>
	<tr>
		<td align="center" width="150" height="50" bgcolor="#eeeeee">비밀번호<font color="blue">*</font></td>
		<td>
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<input name="pwd" id="pwd"type="password" size="15" maxlength="16">
		&nbsp<font size="1">(영문 대소문자/숫자/특수문자, 8~16자)</font>
		</td>
	</tr>
	<tr>
		<td align="center" width="150" height="50" bgcolor="#eeeeee">비밀번호 확인<font color="blue">*</font></td>
		<td>
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<input name="checkpwd" id="checkpwd" type="password" size="15" maxlength="16">
		</td>
	</tr>
	<tr>
		<td align="center" width="150" height="50" bgcolor="#eeeeee">이름<font color="blue">*</font></td>
		<td>
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<input name="name" id="name" value="<%=udto.getUserName()%>" type="text" size="15"> 
		</td>
	</tr>
	<tr>
		<td align="center" width="150" height="50" bgcolor="#eeeeee">휴대전화<font color="blue">*</font></td>
		<td>
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<select name="phone1" class="input" style="height:30px;">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="019">019</option>
		</select>
		-
		<input name="phone2" class="input" id="phone2" type="text" size="4" maxlength="4">
		-
		<input name="phone3" class="input" id="phone3" type="text" size="4" maxlength="4">
		</td>
	</tr>
	<tr>
		<td align="center" width="150" height="50" bgcolor="#eeeeee">이메일<font color="blue">*</font></td>
		<td>
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<input name="email" id="email" type="text" size="30" value="<%=udto.getUser_email()%>">
		</td>
	</tr>
		<tr>
		<td align="center" width="150" height="100" bgcolor="#eeeeee">주소<font color="blue">*</font></td>
		<td>
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<input type="text" id="sample4_postcode" name="addr1" placeholder="우편번호">
		&nbsp&nbsp<input class="button" type="button"  onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<input class="add" type="text" id="sample4_roadAddress" name="addr2" placeholder="도로명주소" size="50" ><br>
		<input type="hidden" id="sample4_jibunAddress" placeholder="지번주소" size="50">
		<span id="guide" style="color:#999; display:none"></span>
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<input class="add" type="text" id="sample4_detailAddress" name="addr3" placeholder="상세주소"  size="50">
		<input type="hidden" id="sample4_extraAddress" placeholder="참고항목" size="50">
		<input type="hidden" id="sample4_engAddress" placeholder="영문주소" size="50" >
		</td>
	</tr> 
	</table>
	<br><br>
		<h3 align="center"><input class="joinus" type="submit" value="Modify"></h3>
	</form>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</div>
</body>
</html>
