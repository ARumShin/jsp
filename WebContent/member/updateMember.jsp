<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<script src="../resources/js/validation.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script>
	$(document)
			.ready(
					function() {
						$(function() {
							$('.phone')
									.keydown(
											function(event) {
												var key = event.charCode
														|| event.keyCode || 0;
												$text = $(this);
												if (key !== 8 && key !== 9) {
													if ($text.val().length === 3) {
														$text.val($text.val()
																+ '-');
													}
													if ($text.val().length === 8) {
														$text.val($text.val()
																+ '-');
													}
												}

												return (key == 8
														|| key == 9
														|| key == 46
														|| (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
												// Key 8번 백스페이스, Key 9번 탭, Key 46번 Delete 부터 0 ~ 9까지, Key 96 ~ 105까지 넘버패트
												// 한마디로 JQuery 0 ~~~ 9 숫자 백스페이스, 탭, Delete 키 넘버패드외에는 입력못함
											})
						});
					});
</script>

<script>
	$(function() {
		$("#birthday").datepicker(
				{
					changeMonth : true,
					changeYear : true,
					dateFormat : "yy-mm-dd",
					prevText : "이전 달",
					nextText : "다음 달",
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
							'8월', '9월', '10월', '11월', '12월' ],
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
					dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
					dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
					showMonthAfterYear : true,
					yearSuffix : '년'
				});
	});
</script>

<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function Postcode() {
		new daum.Postcode({
			oncomplete : function(data) {
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
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
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

<meta charset="UTF-8">
<title>회원정보 수정</title>
</head>
<body onload="init()">
	<%
		//정상 로그인시 session id 값을 가져온다
	String sessionId = (String) session.getAttribute("sessionId");
	%>
	<!-- db 접속 설정 -->
<%-- 	<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver" --%>
<%-- 		url="jdbc:mysql://localhost:3306/ap" user="root" password="1234" /> --%>
<%@include file="setDataSource.jsp" %>

	<!-- member테이블에서 정보를 가져오기 위해
	     sql 쿼리 정의-->
	<sql:query dataSource="${dataSource}" var="resultSet">
		select * from member where id = ?
		<sql:param value="<%=sessionId%>" />
	</sql:query>

	<!-- 폼 수정 -->
	<jsp:include page="../menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 수정</h1>
		</div>
	</div>

	<!-- member 테이블 자료를 가져온다 -->
	<c:forEach var="row" items="${resultSet.rows}">

		<c:set var="mail" value="${row.mail}" />
		<!-- 메일자료를 @ 기준으로 분리 -->
		<c:set var="mail1" value="${mail.split('@')[0]}" />
		<c:set var="mail2" value="${mail.split('@')[1]}" />

		<div class="container">
			<form name="newMember" class="form-horizontal"
				action="processUpdateMember.jsp" method="post"
				onsubmit="return checkForm()">
				<div class="form-group  row">
					<label class="col-sm-2 ">아이디</label>
					<div class="col-sm-3">
						<input name="id" type="text" class="form-control"
							placeholder="아이디입력" readonly="readonly"
							value="<c:out value='${row.id}'/>">
					</div>
				</div>
				<div class="form-group  row">
					<label class="col-sm-2">비밀번호</label>
					<div class="col-sm-3">
						<input name="password" type="password" class="form-control"
							placeholder="비밀번호 입력" value="<c:out value='${row.passwd}'/>">
					</div>
				</div>
				<div class="form-group  row">
					<label class="col-sm-2">비밀번호확인</label>
					<div class="col-sm-3">
						<input name="password_confirm" type="password"
							class="form-control" placeholder="비밀번호 확인 입력"
							value="<c:out value='${row.passwd}'/>">
					</div>
				</div>
				<div class="form-group  row">
					<label class="col-sm-2">이름</label>
					<div class="col-sm-3">
						<input name="name" type="text" class="form-control"
							placeholder="이름 입력" value="<c:out value='${row.name}'/>">
					</div>
				</div>
				<div class="form-group  row">
					<label class="col-sm-2">성별</label>
					<div class="col-sm-10">
						<c:set var="gender" value="${row.gender}" />
						<input name="gender" type="radio" value="남"
							<c:if test="${gender.equals('남')}"><c:out value="checked"/></c:if> />남자
						<input name="gender" type="radio" value="여"
							<c:if test="${gender.equals('여')}"><c:out value="checked"/></c:if> />여자
					</div>
				</div>

				<div class="form-group  row">
					<label class="col-sm-2">생일</label>
					<div class="col-sm-3">
						<input id="birthday" name="birthday" type="text"
							class="form-control" placeholder="생일 입력"
							value="<c:out value='${fn:substring(row.birth,0,4)}${"-"}${fn:substring(row.birth,4,6)}${"-"}${fn:substring(row.birth,6,9)}'/>">
					</div>
				</div>

				<div class="form-group  row ">
					<label class="col-sm-2">이메일</label>
					<div class="col-sm-10">
					<input type="text" id="email" name="email" value="<c:out value='${row.email}'/> ">
<%-- 						<input type="text" name="mail1" value="${mail1}" maxlength="50">@ --%>
<!-- 						<select id="mail2" name="mail2"> -->
<!-- 							<option>naver.com</option> -->
<!-- 							<option>daum.net</option> -->
<!-- 							<option>gmail.com</option> -->
<!-- 							<option>nate.com</option> -->
<!-- 						</select> -->
					</div>
				</div>
				<div class="form-group  row">
					<label class="col-sm-2">전화번호</label>
					<div class="col-sm-3">
						<input class="phone" name="phone" type="text" class="form-control"
							placeholder="0000-0000-0000"
							value="<c:out value='${row.phone}'/>">

					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">우편번호</label>
					<div class="col-sm-2">
						<input id="postCd" name="postCd" type="text"
							value="<c:out value='${row.postcd}'/>" class="form-control" /> <input
							type="button" value="우편번호 찾기" onclick="Postcode()" />
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">주소</label>
					<div class="col-sm-7">
						<input id="addressName" name="address" type="text"
							readonly="readonly" value="<c:out value='${row.address}'/>"
							class="form-control" />
					</div>
				</div>

				<div class="form-group row">
					<label class="col-sm-2">상세주소</label>
					<div class="col-sm-7">
						<input id="addressName2" name="address2" type="text"
							value="<c:out value='${row.address2}'/>" class="form-control" />
					</div>
				</div>
				<div class="form-group  row">
					<div class="col-sm-offset-2 col-sm-10 ">
						<input type="button" class="btn btn-primary" value="수정"
							onclick="CheckAddMember()"> <input type="reset"
							class="btn btn-primary" value="취소" onclick="reset()"> <a
							href="deleteMember.jsp" class="btn btn-success">회원탈퇴</a>
					</div>
				</div>
			</form>
		</div>
	</c:forEach>
</body>
</html>

<script>
	function init() {
		selectUrl("${mail2}");
	}

	function selectUrl(val) {
		var selectUrl = document.getElementById('mail2');

		for (i = 0; i < selectUrl.length; i++) {
			if (selectUrl.options[i].value == val) {
				selectUrl.options[i].selected = true;
				break;
			}
		}
	}
</script>