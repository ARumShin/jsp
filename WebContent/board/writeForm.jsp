<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String name = (String) request.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 등록</title>
</head>
<script>
	function cancel(){
		location.href="${pageContext.request.contextPath}/BoardListAction.do";
	}
</script>
<body>
<%-- 	<jsp:include page="../menu.jsp" /> --%>
	<%@ include file="../menu.jsp" %>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">게시판 등록</h1>
		</div>
	</div>
	<div class="container">
		<form name="newWrite" action="./BoardWriteAction.do"
			class="form-horizontal" method="post">
			<input name="id" type="hidden" class="form-control"
				value="${sessionId}">
			<div class="form-group row">
				<label class="col-sm-2 control-label">제목</label>
				<div class="col-sm-5">
					<input name="subject" type="text" class="form-control"
						placeholder="제목 ">
				</div>				
				<c:choose>
					<c:when test="${grade >=2 }">
						<label class="col-sm-1 control-label">분류</label>
						<div class="col-sm-4">
							<select name="authority">
								<option value="1">일반</option>
								<option value="2">공지</option>
							</select>
						</div>
					</c:when>
					<c:otherwise>
						<input type="hidden" name="authority" value="1">
					</c:otherwise>
				</c:choose>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label">내용</label>
				<div class="col-sm-8">
					<textarea name="content" cols="50" rows="5" class="form-control"
						placeholder="내용 "></textarea>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label">작성자</label>
				<div class="col-sm-3">
					<input name="name" type="text" class="form-control"
						value="<%=name%>" readonly="readonly">
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="submit" class="btn btn-primary" value="등록 ">
					<input type="reset" class="btn btn-warning" value="리셋">
					<input type="button" class="btn btn-warning" onclick="cancel()" value="취소 ">
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>