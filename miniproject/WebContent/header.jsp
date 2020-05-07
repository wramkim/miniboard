<%@page import="board.MiniboardSQL"%>
<%@page import="board.MemberDTO"%>
<%@include file="global.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-bs4.min.js"></script>
<!-- 아이콘 -->
<link rel="stylesheet" href="./assets/lineicons.css">
<style type="text/css">
html, body {
	height: 100%;
	overflow: auto;
}
</style>

</head>
<body>

	<nav class="navbar navbar-expand-sm fixed-top bg-light navbar-light">
		<div class="container">
			<a class="navbar-brand" href="#">사이트 이름</a>
			
			<!-- 로그인 했을 때 -->
			<ul class="navbar-nav"
				style="display: <%=logged ? "block" : "none"%>">
				<li class="nav-item dropdown"><a class="nav-link" href="#"
					id="navbardrop" data-toggle="dropdown"> <b><%=userName%></b>님
						어서오세요! <img src="./profiles/<%=userProfile%>"
						class="rounded-circle"
						style="width: 30px; height: 30px; border: 2px solid #BDBDBD;">
				</a>
					<div class="dropdown-menu"
						style="text-align: center; padding-top: 10px;">
						<img src="./profiles/<%=userProfile%>" class="rounded-circle"
							style="width: 70px; height: 70px; border: 2px solid #BDBDBD;">
						<p class="dropdown-item" style="margin: 0px; padding: 5px;">
							<b><%=userName%></b><br>(<%=userID%>)
						</p>
						<p class="dropdown-item" style="margin: 0px; padding: 5px;"><%=userGrade%></p>

						<%
							if (userLevel == 1) {
						%>
						<a class="dropdown-item" href="admin.jsp" style="margin-botton: 5px;"><strong><span
								class="li_settings"></span> 사이트 관리</strong></a>
						<%
							}
						%>
						<hr>
						<a class="dropdown-item" href="memberinfo.jsp?uid=<%=userID %>" style="margin-botton: 5px;">마이
							페이지</a> <a class="dropdown-item" href="#" style="margin-botton: 5px;">정보
							수정</a>
							<form action="logoutProc.jsp">
						<button class="btn btn-danger" style="width: 93%; margin: 5px;" type="submit">로그아웃</button></form>
					</div></li>
			</ul>
			<!-- 로그인 안했을 때 -->
			<ul class="navbar-nav"
				style="display: <%=logged ? "none" : "block"%>">
				<li class="nav-item dropdown"><a class="nav-link" href="#"
					id="navbardrop" data-toggle="modal" data-target="#loginModal">Member
						Login <img src="./images/anonymous.png" class="rounded-circle"
						style="width: 30px; height: 30px; border-width: 2px; border-style: solid; border-color: gray;">
				</a></li>
			</ul>
		</div>
	</nav>

	<!-- 로그인 다이얼로그 -->
	<div class="modal fade" id="loginModal">
		<div class="modal-dialog modal-sm">
			<form action="loginProc.jsp" method="post">
				<div class="modal-content" style="background: white">
					<div class="modal-header">
						<h4 class="modal-title">로그인</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">

						<div class="form-group">
							<label for="uid">아이디</label> <input type="text"
								class="form-control" name="uid" placeholder="Enter ID">
						</div>
						<div class="form-group">
							<label for="pwd">비밀번호</label> <input type="password"
								class="form-control" name="pwd" placeholder="Enter password">
						</div>

						<button class="btn btn-success" style="width: 100%">
							<span class="li_user"></span> 로그인
						</button>
					</div>
					<div class="modal-footer">
						<p style="text-algin: center">
							회원이 아니신가요? <a href="memberJoin.jsp">회원가입</a>
						</p>
					</div>
				</div>

			</form>
		</div>
	</div>

	<div class="container-fluid"
		style="background: url('./images/background.jpg') no-repeat fixed #eee; padding-top: 100px; padding-bottom: 50px; min-height: 100%">
		<div class="container">
			<div class="card">
			
			
</body>
</html>