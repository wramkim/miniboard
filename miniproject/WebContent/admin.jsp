<%@page import="board.BoardsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.MemberDTO"%>
<%@page import="board.MiniboardSQL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if (userLevel != 1) {
			String err = "잘못된 접근입니다.";
			response.sendRedirect("error.jsp?ecode=" + URLEncoder.encode(err, "UTF-8"));
			return;
		}

		MiniboardSQL ms = new MiniboardSQL();
		ArrayList<BoardsDTO> list = ms.getBoards();
	%>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp">
		<jsp:param value="0" name="active" />
	</jsp:include>
	<div class="card-body">
		<!-- 게시판 추가 -->
		<button class="btn btn-primary" onclick="location.href='createBoard.jsp'">새 게시판 추가</button>
		<!-- 게시판 목록 -->
		<table class="table table-sm">
			<tr>
			</tr>
			<tr>
				<td colspan="7">사용중인 게시판 <span class="badge badge-info"><%=list.size()%></span>
				</td>
			</tr>
			<tr style="text-align: center">
				<th>순번</th>
				<th>BID</th>
				<th>제목</th>
				<th>안내말</th>
				<th>권한</th>
				<th>표시</th>
				<th>관리</th>
			</tr>

			<%
				for (int i = 0; i < list.size(); i++) {
					BoardsDTO dto = list.get(i);
					
					int level = dto.getWlevel();
					String grade = "";

					switch (level) {
					case 1:
						grade = "관리자";
						break;
					case 2:
						grade = "일반 회원";
						break;
					}
			%>
			<tr style="text-align: center">
				<td><%=dto.getNum()%></td>
				<td><%=dto.getBid()%></td>
				<td><%=dto.getBname()%></td>
				<td><%=dto.getBdesc()%></td>
				<td><%=grade%></td>
				<td><%=(dto.getInlist()==1)?"true":"false"%></td>
				<td><div class="btn-group btn-group-sm">
						<button class="btn btn-info" type="submit">수정</button>
						<button class="btn btn-danger" type="button" onclick="">삭제</button>
					</div></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>