<%@page import="board.BoardsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.MiniboardSQL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.nav a {
	color: #777;
}

.nav a:focus, .nav a:hover {
	color: #333;
}
</style>
</head>
<body>
	<%
		int active = Integer.parseInt(request.getParameter("active"));
	%>
	<ul class="nav nav-tabs nav-justified ">
		<li class="nav-item"><a
			class="nav-link <%=(active == 1) ? "active" : ""%>" href="index.jsp"> <span
				class="li_note" style="font-size: 1.5em"></span><br>메인화면
		</a></li>
		<li class="nav-item"><a
			class="nav-link <%=(active == 2) ? "active" : ""%>" href="boardList.jsp?bid=notice"><span
				class="li_megaphone" style="font-size: 1.5em"></span><br>공지사항</a></li>
		<li class="nav-item dropdown"><a
			class="nav-link dropdown-toggle <%=(active == 3) ? "active" : ""%>"
			data-toggle="dropdown" href="#"><span class="li_bubble"
				style="font-size: 1.5em"></span><br>게시판</a>
			<div class="dropdown-menu" style="width: 100%;">
				<%
					MiniboardSQL ms = new MiniboardSQL();
					ArrayList<BoardsDTO> list = ms.getBoards();

					for (int i = 0; i < list.size(); i++) {
						BoardsDTO dto = list.get(i);
						if (dto.getInlist() == 1) {
				%>
				<a class="dropdown-item" href="boardList.jsp?bid=<%=dto.getBid()%>"><%=dto.getBname()%></a>
				<%
					}
					}
				%>

			</div></li>


		<li class="nav-item"><a
			class="nav-link <%=(active == 4) ? "active" : ""%>" href="boardList.jsp?bid=gallery"><span
				class="li_photo" style="font-size: 1.5em"></span><br>갤러리</a></li>
	</ul>
</body>
</html>