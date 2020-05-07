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
		String ecode = request.getParameter("ecode");
	%>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp">
		<jsp:param value="0" name="active" />
	</jsp:include>
	<div class="card-body">
		<div class="alert alert-danger"
			style="text-align: center; margin: 50px;">
			<h2 style="margin-top: 30px;">
				<span class="li_bulb"></span>오류<br>
			</h2>

			<p style="margin: 40px;"><%=ecode%></p>
		</div>
	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>