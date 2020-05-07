<%@page import="board.MiniboardSQL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<!-- 아이콘 -->
<link rel="stylesheet" href="./assets/lineicons.css">
<script>
	function checkDone() {
		opener.document.getElementById("uid").value = "<%=request.getParameter("uid")%>";
		window.close();
	}
</script>
</head>
<body style="overflow: hidden;">
	<div class="card" style="width: 500px; height: 350px; margin: auto;">
		<div class="card-header">
			<strong>ID 중복체크</strong>
		</div>
		<div class="card-body">
			<form action="checkID.jsp">
				<div class="form-group">
					<label for="userID">아이디</label>
					<div class="input-group">
						<input type="text" class="form-control" name="uid"
							value="<%=request.getParameter("uid")%>">
						<div class="input-group-append">
							<button class="btn btn-primary" type="submit">중복체크</button>
						</div>
					</div>
				</div>
			</form>
		</div>
		<div class="card-body" style="text-align: center">
			<%
				String uid = request.getParameter("uid");

				if (uid == null || uid.equals("")) {
			%>
			<div class="alert alert-danger">ID를 입력해주세요.</div>
			<%
				return;
				}

				for (int i = 0; i < uid.length(); i++) {
					char c = uid.charAt(i);
					if ((c < '0' || c > '9') && (c < 'a' || c > 'z') && c != '-') {
			%>
			<div class="alert alert-danger">ID는 영어 소문자(a-z)와 숫자(0-9),
				하이픈(-)으로만 구성되어야 합니다.</div>
			<%
				return;
					}

					if (i == 0 && (c < 'a' || c > 'z')) {
			%>
			<div class="alert alert-danger">첫 글자는 영어 소문자(a-z)만 가능합니다.</div>
			<%
				return;
					}
				}

				MiniboardSQL ms = new MiniboardSQL();
				if (ms.checkID(uid)) {
			%>
			<div class="alert alert-success">사용 가능한 ID입니다.</div>
			<button class="btn btn-success" type="button" onclick="checkDone();">사용하기</button>
			<%
				} else {
			%>
			<div class="alert alert-danger">이미 사용중인 ID입니다.</div>
			<%
				}
			%>
		</div>
	</div>
</body>
</html>