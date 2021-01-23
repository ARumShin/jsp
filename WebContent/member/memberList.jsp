<%@page import="mvc.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@include file="../dbconn.jsp" %>

<%
		//정상 로그인시 session id 값을 가져온다
	String sessionId = (String) session.getAttribute("sessionId");
	PreparedStatement pstmt=null;
	ResultSet rs= null;
	if(sessionId==null){response.sendRedirect(request.getContextPath()+"/welcome.jsp");}
	try{
		String sql="select grade from member where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,sessionId);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			System.out.print("rs.getInt(grade)"+rs.getInt("grade"));
			if(rs.getInt("grade")<3){
				response.sendRedirect(request.getContextPath()+"/welcome.jsp");
			}
			
		}
	}catch(SQLException e){
// 		e.getMessage();
		e.printStackTrace();
	}
	String sql="select * from member";
	pstmt=conn.prepareStatement(sql);
	rs= pstmt.executeQuery();
// 	while(rs.next()){
	
%>
<html>
<script type="text/javascript">
	function updateM(){
		/* alert("수정"); */
		var update=confirm("수정");
		if(update){
		location.href=("AupdateMember.jsp");
		}else{return false;}
		
	}
<!--

//-->
</script>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
</head>
<body>
<jsp:include page="../menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 목록</h1>
		</div>
	</div>
	<div class="container">
<%-- 		<form action="<c:url value="./BoardListAction.do"/>" method="post"> --%>
			<div class="text-right">
				<span class="badge badge-success">전체<%--=--%>건 </span>
			</div>
			<div style="padding-top:50px">
				<table class="table table-hover table-striped">
					<tr>
						<th>ID</th>
						<th>비밀번호</th>
						<th>이름</th>
						<th>성별</th>
						<th>생년월일</th>
						<th>메일</th>
						<th>전화</th>
						<th>우편번호</th>
						<th>주소</th>
						<th>가입일</th>
						<th>회원등급</th>
						<th>탈퇴여부</th>
						<th>탈퇴일</th>
						<th>수정</th>
					</tr>
					<%--
						for(int i=0;i<memberList.size();i++){
							MemberDTO notice=(MemberDTO)memberList.get(i);
					--%>
					<%
					while(rs.next()){
					%>
					<tr>
<%-- 						<td <% if(notice.getAuthority()==2){%>style="font-weight: bold" <%}%> ><%=notice.getName() %></td> --%>
						<td id="memberId"><%=rs.getString("id") %></td>
						<td><%=rs.getString("passwd") %></td>
						<td><%=rs.getString("name") %></td>
						<td><%=rs.getString("gender") %></td>
						<td><%=rs.getString("birth") %></td>
						<td><%=rs.getString("email") %></td>
						<td><%=rs.getString("phone") %></td>
						<td><%=rs.getString("address")+rs.getString("address2") %></td>
						<td><%=rs.getString("regdate") %></td>
						<td><%=rs.getString("postcd") %></td>
						<td><%=rs.getString("grade") %></td>
						<td><%=rs.getString("deleteYn") %></td>
						<td><%=rs.getString("deldate") %></td>
						<td>
<!-- 						<a href="#" onclick="updateM()" class="btn btn-danger">수정</a> -->
						<a href="AupdateMember.jsp?memberId=<%=rs.getString("id") %>" class="btn btn-danger">수정</a>
						</td>
					</tr>

 					<%
					}
					if(rs!=null)rs.close();
					if(pstmt!=null)pstmt.close();
					if(conn!=null)conn.close();
					%>
				</table>
			</div>
			<div align="center">
				<c:set var="pageNum" value="<%--=pageNum --%>"/>
<%-- 				<c:forEach var="i" begin="1" end="<%--=total_page --%>
<%-- 					<a href="<c:url value="./BoardListAction.do?pageNum=${i }"/>"> --%>
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${pageNum==i }"> --%>
<%-- 								<font color='4C5317'><b>[${i }]</b></font> --%>
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
<%-- 								<font color='4C5317'>[${i}]</font> --%>
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose> --%>
<!-- 					</a> -->
<%-- 				</c:forEach> --%>
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
<!-- 		</form> -->
	</div>
	<hr>
	<jsp:include page="../footer.jsp"/>

</body>
</html>