<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.*" %>
<%@page import="mvc.model.BoardDTO" %>
<%
	String sessionId=(String)session.getAttribute("sessionId");
	ArrayList boardList=(ArrayList)request.getAttribute("boardlist");
	int total_record = ((Integer)request.getAttribute("total_record")).intValue();
	int pageNum=((Integer)request.getAttribute("pageNum")).intValue();
	int total_page=((Integer)request.getAttribute("total_page")).intValue();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 조회</title>
<script type="text/javascript">
	function checkForm(){
		if(${sessionId == null}){
			alert("로그인 하세요!");
			return false;
		}
		location.href="./BoardWriteForm.do?id=<%=sessionId%>"
	}
</script>
</head>
<body>
	<jsp:include page="../menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">게시판</h1>
		</div>
	</div>
	<div class="container">
		<form action="<c:url value="./BoardListAction.do"/>" method="post">
			<div class="text-right">
				<span class="badge badge-success">전체<%=total_record%>건 </span>
			</div>
			<div style="padding-top:50px">
				<table class="table table-hover table-striped">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>작성자</th>
					</tr>
					<%
						for(int i=0;i<boardList.size();i++){
							BoardDTO notice=(BoardDTO)boardList.get(i);
					%>
					<tr>
						<td><%=notice.getNum() %></td>
						<td><a href="./BoardViewAction.do?num=<%=notice.getNum()%>&pageNum=<%=pageNum%>"><%=notice.getSubject() %></a></td>
						<td><%=notice.getRegdate() %></td>
						<td><%=notice.getHit() %></td>
						<td><%=notice.getName() %></td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<div align="center">
				<c:set var="pageNum" value="<%=pageNum %>"/>
				<c:forEach var="i" begin="1" end="<%=total_page %>">
					<a href="<c:url value="./BoardListAction.do?pageNum=${i }"/>">
						<c:choose>
							<c:when test="${pageNum==i }">
								<font color='4C5317'><b>[${i }]</b></font>
							</c:when>
							<c:otherwise>
								<font color='4C5317'>[${i}]</font>
							</c:otherwise>
						</c:choose>
					</a>
				</c:forEach>
			</div>
<!-- 			검색조건 화면 구성 -->
			<div align="left">
				<table>
					<tr>
						<td width="100%" align="left">&nbsp;&nbsp;
							<select name="items">
								<option value="subject">제목</option>
								<option value="content">내용</option>
								<option value="name">작성자</option>
							</select>
							<input type="text" name="text"/>
							<input type="submit" id="btnAdd" class="btn btn-primary" value="검색"/>
						</td>
<!-- 						게시판 등록 버튼 -->
						<td width="100%" align="right">
							<a href="#" onclick="checkForm(); return false;" class="btn btn-primary">글쓰기</a>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<hr>
	<jsp:include page="../footer.jsp"/>

</body>
</html>