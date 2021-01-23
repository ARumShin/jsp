<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	
	
	
// 	ArrayList<Integer> list = new ArrayList<>();
// 	HashSet<Integer> set = new HashSet<>();	//Set 동일한 대상 중복 불가능	
	
	Random rd=new Random();
// 	for(int i=0;i<6;i++){
// 		System.out.print("["+(rd.nextInt(45)+1)+"]\n");
// 	}
// 	for(int j=0; j<20; j++){
		HashSet<Integer> set = new HashSet<>();	//Set 동일한 대상 중복 불가능
// 		int count = 0;
		for(int i=0; set.size()<6; i++){
			Integer x = rd.nextInt(45)+1;
// 			count ++;
// 			System.out.print(x + ", ");
			set.add(x);
			set.
		}
// 		System.out.println("count : " +count);
		System.out.println(set);
// 	}
	
	
	
	
	
	
	%>
</body>
</html>