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
</script>
</head>
<body style="overflow: hidden;">
	<div class="card" style="width: 500px; height: 350px; margin: auto;">
		<div class="card-header">
			<strong>파일 업로드</strong>
		</div>
		<div class="card-body">
			<form action="uploadProc.jsp" enctype="multipart/form-data" method="post">
				<div class="form-group" style="height:45px;">
					<div class="input-group">
						<input type="file" class="form-control" name="file"
							value="" required>
						<div class="input-group-append">
							<button class="btn btn-primary" type="submit">업로드</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>