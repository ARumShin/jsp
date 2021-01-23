<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<title>회원 정보</title>
</head>
<body>

	<jsp:include page="/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원정보</h1>
		</div>
	</div>
	<div class="container" align="center">
		<%

			String gubun = request.getParameter("gubun");

			if(gubun.equals("insert")){
				out.println("<h2 class='alert alert-danger'>회원가입을 축하드립니다.</h2>");
			}else if(gubun.equals("update")){
				out.println("<h2 class='alert alert-danger'>정상적으로 수정되었습니다</h2>");				
			}else if(gubun.equals("delete")){
				out.println("<h2 class='alert alert-danger'>정상적으로 삭제되었습니다</h2>");				
			}else if(gubun.equals("login")){
				out.println("<h2 class='alert alert-danger'>정상적으로 로그인</h2>");
			}else if(gubun.equals("loginError")){
				out.println("<h2 class='alert alert-danger'>아이디 혹은 비밀번호를 확인하세요</h2>");				
			}
		%>
	</div>	
</body>
</html>