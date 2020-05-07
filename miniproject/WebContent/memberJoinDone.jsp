<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<%
		String name = request.getParameter("name");
	%>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp">
		<jsp:param value="0" name="active" />
	</jsp:include>
	<div class="card-body" style="text-align: center; padding: 50px;">
		<h1>
			<span class="li_like"></span>
		</h1>
		<h2>
			<br>회원가입 성공
		</h2>

		<p>
			<br> <br> <strong><%=name%></strong>님 가입을 환영합니다!
		</p>
		<p></p>
	</div>
</body>
</html>