<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../menu.jsp" %>

<html>
<head>
<!-- <script src="../resources/js/validation.js"></script> -->
<!-- <link rel="stylesheet" href="../resources/css/bootstrap.min.css" /> -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script>
	$(document).ready(function () {
	   $(function () {
	            $('.phone').keydown(function (event) {
	             var key = event.charCode || event.keyCode || 0;
	             $text = $(this); 
	             if (key !== 8 && key !== 9) {
	                 if ($text.val().length === 3) {
	                     $text.val($text.val() + '-');
	                 }
	                 if ($text.val().length === 8) {
	                     $text.val($text.val() + '-');
	                 }
	             }
	
	             return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
				 // Key 8번 백스페이스, Key 9번 탭, Key 46번 Delete 부터 0 ~ 9까지, Key 96 ~ 105까지 넘버패트
				 // 한마디로 JQuery 0 ~~~ 9 숫자 백스페이스, 탭, Delete 키 넘버패드외에는 입력못함
	         })
	   });	   
	});
</script>

<script>
	$(function(){
		$("#birthday").datepicker({
			changeMonth:true,
			changeYear:true,
			dateFormat:"yy-mm-dd",
			prevText:"이전 달",
			nextText:"다음 달",
			monthNames:['1월','2월','3월','4월',
						'5월','6월','7월','8월',
						'9월','10월','11월','12월'
				       ],
			monthNamesShort:['1월','2월','3월','4월',
							'5월','6월','7월','8월',
							'9월','10월','11월','12월'
					       ],
			dayNames:['일','월','화','수','목','금','토'],
			dayNamesShort:['일','월','화','수','목','금','토'],
			dayNamesMin:['일','월','화','수','목','금','토'],
			showMonthAfterYear:true,
			yearSuffix:'년'
		});
	});
</script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function Postcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("addressName2").value = extraAddr;
                
                } else {
                    document.getElementById("addressName2").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postCd').value = data.zonecode;
                document.getElementById("addressName").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("postCd").focus();
            }
        }).open();
    }
</script>
<script type="text/javascript">
	var request = new XMLHttpRequest();
// 	var newMember = document.newMember;
// 	var id = newMember.id.value;

	
	function checkId(){
		//console.log(document.getElementById("searchId").value);
		request.open("Get", "${pageContext.request.contextPath}/SearchServlet?userId=" + encodeURIComponent(document.getElementById("id").value),true);				
// 		console.log("step1");
		request.onreadystatechange = nextProcess;
// 		console.log("step2");
		request.send(null);
	}

	function nextProcess(){
// 		console.log(nextProcess);
		if(request.readyState == 4 && request.status == 200){
			console.log("request.responseText : " + request.responseText);
			var object = eval('(' + request.responseText + ')');
// 			console.log("object : " + object);
			var result = object.result;
			console.log("result : " + result);
			if(result>0){
				$("#idCheck").html("<span style='color:red'>이미 등록된 아이디입니다.</span>");
			}else{
				$("#idCheck").html("<span style='color:green'>사용 가능한 아이디입니다.</span>");
// 				if(id.length<4){
// 					$("#idCheck").html("<span style='color:green'>아이디는 최소 4자 이상 입력하세요.</span>");
// 				}else{
// 					$("#idCheck").html("<span style='color:green'>사용 가능한 아이디입니다.</span>");					
// 				}
			}			
		}		
	}
// 	var isPW=/^[A-Za-z0-9'\-=\\\[\];',\./~!@#\$%\^&\*(\)_\+|\{\}:"<>\?]{4,10}$/;
// 	var isPW= RegExp(/^[0-9]*$/);
	var isPW=RegExp(/^[A-Za-z0-9`\-=\\\[\];',\./~!@#\$%\^&\*\(\)_\+|\{\}:"<>\?]{4,10}$/);
	//영문 대소문자 숫자 특수문자4자~10자
// 	var passwd=newMember.password.value;
	
	var passwd;
	function checkPw(){
		passwd =document.getElementById("password");
		console.log("value : "  + passwd.value);		
		if(!isPW.test(passwd.value)){
// 			alert("비밀번호는 영문 대소문자 특수문자를 조합하여 4자~10자로 입력해주세요!");
			$("#pwCheck").html("<span style='color:red'>비밀번호는 영문 대소문자 숫자 특수문자를 조합하여 4~10자로 입력해라!</span>");

		}else{
			$("#pwCheck").html("<span style='color:green'>됐다!</span>");			
		}
		$("#pwCheck2").html("<span style='color:red'>비밀번호 입력 후 확인 필요</span>");
		
		
		
	}
	
	var passwd2;
	function checkPw2(){
		passwd2=document.getElementById("password2");
		if(passwd.value!=passwd2.value){
			$("#pwCheck2").html("<span style='color:red'>비밀번호랑 달라!</span>");			
		}else{
			$("#pwCheck2").html("<span style='color:green'>됐다!</span>");			
			
		}
	}
	var isName = RegExp(/^[가-힣]{2,6}$/);
	var n;
	function checkName(){
		n=document.getElementById("name");
		console.log(n.value);
		if(!isName.test(n.value)){
			$("#nameCheck").html("<span style='color:red'>이름은 한글 2~6자로 입력해라!</span>");

		}else{
			$("#nameCheck").html("<span style='color:green'>됐다!</span>");
			
		}
	}
	
	var isBirth=RegExp(/^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/);
	var birth;
	
	$(".ui-state-default").on("click",function(){
		checkBirth();
	});
	
	function checkBirth(){
		birth=document.getElementById("birthday");
		if(!isBirth.test(birth.value)){
			$("#birthCheck").html("<span style='color:red'>올바른 날짜 형식으로 입력해라!(yyyy-MM-dd)</span>");
		}else{			
			var birthDate = new Date(birth.value);
			var bDay = new Date(birthDate.getFullYear() + "-" + (birthDate.getMonth()+1) + "-" + birthDate.getDate())
			var now = new Date();
			var today = new Date(now.getFullYear() + "-" + (now.getMonth()+1) + "-" + now.getDate());
			
			
// 			now.setFullYear(now.getFullYear());
// 			now.setMonth(now.getMonth());
// 			now.setDate(now.getDate());
			var birth100 = new Date((bDay.getFullYear()+100) +"-"+ (bDay.getMonth()+1) +"-"+ bDay.getDate());
			
			console.log("today : " + today);
			console.log("birthDate : " + birthDate);
			console.log("bDay : " + bDay);
			console.log("now : " + now);
			console.log("birth100 : " + birth100);
			console.log("----------------------")
// 			console.log(birthDate>now);
// 			console.log(birthDate<now);
			console.log(today==birthDate)
			
			console.log("----------------------")
// 			console.log("now<birthDate : " + now.getTime()<birthDate.getTime());
// 			console.log("now>birthDate : " + now.getTime()>birthDate.getTime());
// 			console.log("now>birthDate+100 : " + now.getTime()> (birthDate.getFullYear()+100));			
			console.log(bDay.getTime());
			console.log(today.getTime());
			
			
			if(today<bDay){
				$("#birthCheck").html("<span style='color:red'>아직 태어나지 않았구나</span>");			
			}else if(today.getTime()==bDay.getTime()){
				$("#birthCheck").html("<span style='color:red'>신생아니!!!빵살!!</span>");				
			}else if(today>birth100){
				$("#birthCheck").html("<span style='color:red'>살아있나</span>");					
			}else{
				$("#birthCheck").html("<span style='color:green'>됐다!</span>");	
			}			
		}
		
	}
	
	 function showErrorMsg(obj, msg) {
	        obj.attr("style", "color:red");
	        obj.html(msg);
	        obj.show();
	    }
	 function showokMsg(obj, msg) {
	        obj.attr("style", "color:blue");
	        obj.html(msg);
	        obj.show();
	    }
	function checkEmail() {
        var id = $("#id").val();
        var email = $("#email").val();
        var oMsg = $("#emailCheck");

        var isEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        var isHan = /[ㄱ-ㅎ가-힣]/g;
        if (!isEmail.test(email) || isHan.test(email)) {
            showErrorMsg(oMsg,"이메일 주소를 다시 확인해주세요.");
            return false;
        }else{
        	showokMsg(oMsg,"ㅇㅋ.");        	
        }

    }
// 	function isCellPhone(p) {
//         var regPhone = /^((01[1|6|7|8|9])[1-9][0-9]{6,7})$|(010[1-9][0-9]{7})$/;
//         return regPhone.test(p);
//     }
	
// 	var isPhone=RegExp( /^((01[1|6|7|8|9])-[1-9]-[0-9]{7,8})$ | (010-[1-9]-[0-9]{8})$/);
// var isPhone=RegExp(/^\d{3}-\d{3,4}-\d{4}$/);
var isPhone=RegExp(/^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/);
	var p
	function checkPhone(){
		p=document.getElementById("phone");
		console.log("phone"+p.value);
		if(!isPhone.test(p.value)){
			console.log("형식");
			$("#phoneCheck").html("<span style='color:red'>전화번호 재대로 입력해라</span>");

		}else{
			$("#phoneCheck").html("<span style='color:green'>됐다!</span>");
			
		}
	}
	
	
	function checkAddMember(){
		
		if($("#idCheck").children("span").text()!="사용 가능한 아이디입니다."){			
			if (document.getElementById("id").value == ""){
				$("#idCheck").html("<span style='color:red'>아이디 입력해!</span>");
			}
			document.getElementById("id").focus();		
			return false;
		}
		
		if($("#pwCheck").children("span").text()!="됐다!"){
			$("#pwCheck").html("<span style='color:red'>입력해라!</span>");
			document.getElementById("password").focus();		
			return false;
		}
		if($("#pwCheck2").children("span").text()!="됐다!"){
			$("#pwCheck2").html("<span style='color:red'>똑바로 입력해라!</span>");
			document.getElementById("password2").focus();		
			return false;
		}
		if($("#nameCheck").children("span").text()!="됐다!"){
			$("#nameCheck").html("<span style='color:red'>입력해라!</span>");
			document.getElementById("name").focus();		
			return false;
		}
		
		var newMember = document.newMember;
		console.log("newMember : " + newMember);
		var gender = newMember.gender;
		console.log("newMember.gender : " + newMember.gender);
		var gender = newMember.gender.value;
		console.log("newMember.gender.value : " + newMember.gender.value);
		
		if (gender == "") {
			$("#genderCheck").html("<span style='color:red'>성별을 선택해라!</span>");
// 			("성별을 선택하세요.");
//			newMember.gender.select();
//			newMember.gender.focus();
			return false;
		}
		if($("#birthCheck").children("span").text()=="아직 태어나지 않았구나"){
			document.getElementById("birthday").focus();		
			return false;
		}
		if($("#emailCheck").text()!="ㅇㅋ."){
			document.getElementById("email").focus();		
			return false;
		}
		if($("#phoneCheck").children("span").text()!="됐다!"){
			document.getElementById("phone").focus();		
			return false;
		}
		var postCd = newMember.postCd.value;
		var address = newMember.address.value;
		var address2 = newMember.address2.value;
		if (newMember.address.value == "") {
			$("#genderCheck").html("<span style='color:red'>우편번호 찾기를 실행해라!</span>");
// 			alert("우편번호 찾기를 실행하세요");
			newMember.address.select();
			newMember.address.focus();
			return false;
		}

		if (newMember.address2.value == "") {
			$("#genderCheck").html("<span style='color:red'>상세주소내역을 입력해라!</span>");
// 			alert("상세주소내역을 입력하세요");
			newMember.address2.select();
			newMember.address2.focus();
			return false;
		}
		newMember.submit();
	}
</script>
<title>회원 가입</title>
</head>
<body>
	<%-- <jsp:include page="/menu.jsp" /> --%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 가입</h1>
		</div>
	</div>

	<div class="container">
		<form name="newMember" 
		      class="form-horizontal"  
		      action="processAddMember.jsp" 
		      method="post">
			<div class="form-group  row">
				<label class="col-sm-2">아이디</label>
				<div class="col-sm-3">
					<input id="id" name="id" type="text"  class="form-control" placeholder="아이디입력"  onkeyup="checkId()" >
				</div>
				<div id="idCheck"></div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input id="password" name="password" type="password" class="form-control" placeholder="비밀번호 입력" onkeyup="checkPw()" >
				</div>
				<div id="pwCheck"></div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호확인</label>
				<div class="col-sm-3">
					<input id="password2" name="password_confirm" type="password" class="form-control" placeholder="비밀번호 확인 입력" onkeyup="checkPw2()">
				</div>
				<div id="pwCheck2"></div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">이름</label>
				<div class="col-sm-3">
					<input id="name" name="name" type="text" class="form-control" placeholder="이름 입력" onkeyup="checkName()">
				</div>
				<div id="nameCheck"></div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">성별</label>
				<div class="col-sm-10">
					<input name="gender" type="radio" value="남" /> 남 
					<input name="gender" type="radio" value="여" /> 여
				</div>
				<div id="genderCheck"></div>
			</div>

			<div class="form-group  row">
				<label class="col-sm-2">생일</label>
				<div class="col-sm-3">
					<input name="birthday" id="birthday" type="text" class="form-control" placeholder="생일 입력"  onkeyup="checkBirth()" onchange="checkBirth()" >
				</div>
				<div id="birthCheck"></div>
			</div>
			


			<div class="form-group row">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-10">
					<input type="text" id="email" name="email" maxlength="50" placeholder="이메일 입력" onkeyup="checkEmail()">
					 
<!-- 					<select name="mail2"> -->
<!-- 						<option>naver.com</option> -->
<!-- 						<option>daum.net</option> -->
<!-- 						<option>gmail.com</option> -->
<!-- 						<option>nate.com</option> -->
<!-- 					</select> -->
				</div>	
				<div id="emailCheck"></div>			
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">전화번호</label>
				<div class="col-sm-3">
					<input class="phone" 
					id="phone"
					       name="phone" 
					       type="text" 
					       class="form-control"
					       maxlength="13" 
					       size="13" 
					       placeholder="000-0000-0000" 
					       onkeyup="checkPhone()">

				</div>
				<div id="phoneCheck"></div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>					
				<div class="col-sm-6"> 
					<input class="col-sm-2" 
					       id="postCd" 
					       name="postCd" 
					       type="text"
					       readonly 
					       class="form-control" />
					<input class="col-sm-4" type="button" value="우편번호 찾기" onclick="Postcode()"/>       
				</div>	
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소</label>					
				<div class="col-sm-7">
					<input id="addressName" name="address" type="text" readonly="readonly"
					       class="form-control" />
				</div>				
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">상세주소</label>					
				<div class="col-sm-7">
					<input id="addressName2" name="address2"  type="text"  class="form-control" />
				</div>				
			</div>
			<div class="form-group  row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="button" class="btn btn-primary " value="등록 " onclick="checkAddMember()"> 
					<input type="reset" class="btn btn-primary " value="취소 " onclick="reset()">
				</div>
			</div>
		</form>
	</div>
</body>

</html>