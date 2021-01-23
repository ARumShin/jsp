<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page import="java.text.SimpleDateFormat" %>

<%

  String id =
      (String) session.getAttribute("sessionId");

	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String birthday = request.getParameter("birthday");
	birthday = birthday.replaceAll("-","");
// 	String mail1 = request.getParameter("mail1");
// 	String mail2 = request.getParameterValues("mail2")[0];
// 	String mail = mail1 + "@" + mail2;
	String mail=request.getParameter("email");
	String phone = request.getParameter("phone");
	String postCd = request.getParameter("postCd"); 
	String address = request.getParameter("address");
	String address2 = request.getParameter("address2");

	//가입일자 처리
	Date now = new Date();
	SimpleDateFormat sf = 
	  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String today = sf.format(now);

%>

<%@include file="setDataSource.jsp" %>

<sql:update dataSource="${dataSource}" 
            var="resultSet">
     
    update member
       set passwd = ?, 
           name = ?,
           gender = ?, 
           birth = ?,
           email = ?,
           phone = ?,
           postcd = ?,
           address = ?,
           address2 = ?,
           moddate = ?
     where id = ?
    
	<sql:param value="<%=password%>" />
	<sql:param value="<%=name%>" />
	<sql:param value="<%=gender%>" />
	<sql:param value="<%=birthday%>" />
	<sql:param value="<%=mail%>" />
	<sql:param value="<%=phone%>" />
	<sql:param value="<%=postCd%>"/>
	<sql:param value="<%=address%>" />
	<sql:param value="<%=address2%>" />
	<sql:param value="<%=today%>" />
	<sql:param value="<%=id%>" />
</sql:update>

<c:redirect url="resultMember.jsp?gubun=update" />


