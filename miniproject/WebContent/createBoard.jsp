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
<script>
	function checkBID() {
		window.name = "parent";
		newWin = window
				.open('checkBID.jsp?uid=', 'child',
						'width=500, height=350, left=100, top=500 ,menubar=no, status=no, toolbar=no');
	}
</script>
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
		<h3>새로운 게시판 생성</h3>
		<form action="createBoardProc.jsp">
		<input type="hidden" value="<%=list.size()+1 %>" name="num">
			<table class="table">
				<tr>
					<th>순번</th>
					<td><%=list.size()+1 %></td>
				</tr>

				<tr>
					<th>BID</th>
					<td>
						<div class="input-group input-group-sm"
							style="width: 60%; min-width: 300px;">
							<input type="text" class="form-control" name="bid" id="bid"
								readonly required>
							<div class="input-group-append">
								<button class="btn btn-primary" type="button"
									onclick="checkBID();">중복체크</button>
							</div>
						</div>
					</td>
				</tr>

				<tr>
					<th>게시판 제목</th>
					<td>
						<div class="form-group" style="width: 60%; min-width: 300px;">
							<input type="text" class="form-control form-control-sm"
								name="bname" required>
						</div>
					</td>
				</tr>

				<tr>
					<th>안내말</th>
					<td>
						<div class="form-group" style="width: 80%; min-width: 400px;">
							<input type="text" class="form-control form-control-sm"
								name="bdesc" required>
						</div>
					</td>
				</tr>

				<tr>
					<th>글 작성 권한</th>
					<td>
						<div class="form-check-inline">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="wlevel" value="1">관리자
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="wlevel" value="2" required>일반회원
							</label>
						</div>
					</td>

				</tr>

				<tr>
					<th>목록 표시 여부</th>
					<td>
						<div class="form-check-inline">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="inlist" value="1" required>표시함
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="inlist" value="0">표시안함
							</label>
						</div>
					</td>

				</tr>

				<tr>
					<td style="text-align: center" colspan="2">
						<button class="btn btn-success" type="submit">게시판 생성</button>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>