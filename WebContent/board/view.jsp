<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="mvc.model.BoardDTO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 관리</title>
</head>
<body>
	<%
		BoardDTO notice = (BoardDTO) request.getAttribute("board");
	int num = (Integer) request.getAttribute("num");
	int nowpage = (Integer) request.getAttribute("page");
	%>
	<jsp:include page="../menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">게시판 보기</h1>
		</div>
	</div>
	<div class="container">
		<form name="newUpdate"
			action="${pageContext.request.contextPath}/BoardUpdateAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"
			class="form-horizontal" method="post">
			<div class="form-group row">
				<label class="col-sm-2 control-label">제목</label>
				<div class="col-sm-5">
					<input name="subject" class="form-control"
						value="<%=notice.getSubject()%>">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label">내용</label>
				<div class="col-sm-6" style="word-break: break-all;">
<!-- 				줄바꿈 속성:word-break 옵션1)break-all:문자단위로 줄바꿈 
											2)keep-all:단어단위로 줄바꿈-->
					<textarea name="content" class="form-control" cols="50" rows="5"><%=notice.getContent()%>
					</textarea>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label">작성자</label>
				<div class="col-sm-3">
					<input name="name" class="form-control"
						value="<%=notice.getName()%>" readonly="readonly">
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<c:set var="userId" value="<%=notice.getId()%>" />
					<c:if test="${sessionId == userId}">
						<p>
							<input type="submit" class="btn btn-success" value="수정 ">
							<a
								href="./BoardDeleteAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"
								class="btn btn-danger">삭제</a>
					</c:if>
					<a href="./BoardListAction.do?pageNum=<%=nowpage%>"
						class="btn btn-primary">목록</a>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>