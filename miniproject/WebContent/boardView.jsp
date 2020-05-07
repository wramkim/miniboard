<%@page import="board.ArticleDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.pagination>li>a {
	background-color: white;
	color: #777;
}

.pagination>li>a:focus, .pagination>li>a:hover, .pagination>li>span:focus,
	.pagination>li>span:hover {
	color: #333;
	background-color: #eee;
	border-color: #ddd;
}

.pagination>.active>a {
	color: white;
	background-color: #777 !Important;
	border: solid 1px #777 !Important;
}

.pagination>.active>a:hover {
	background-color: #777 !Important;
	border: solid 1px #777;
}
</style>
</head>
<body>
	<%
		//한글 깨짐 방지
		request.setCharacterEncoding("utf-8");

		//조회수
		String hit = request.getParameter("hit");

		if (hit == null) {
			hit = "true";
		}

		String bid = request.getParameter("bid");
		String number = request.getParameter("num");

		if (bid == null || bid.equals("") || number == null || number.equals("")) {
			String err = "잘못된 접근입니다.";
			response.sendRedirect("error.jsp?ecode=" + URLEncoder.encode(err, "UTF-8"));
			return;
		}

		int num = Integer.parseInt(number);

		MiniboardSQL ms = new MiniboardSQL();

		String boardName = ms.getBoardName(bid);
		String boardDesc = ms.getBoardDesc(bid);

		ArticleDTO adto = ms.getArticle(bid, num, hit);

		String profile = ms.getMember(adto.getWid()).getProfile();
		int menunum = 0;
		if (bid.equals("notice"))
			menunum=2;
		else if (bid.equals("gallery"))
			menunum=4;
		else
			menunum=3;
	%>
	<jsp:include page="header.jsp"></jsp:include>

	<jsp:include page="menu.jsp">
		<jsp:param value="<%= menunum %>" name="active" />
	</jsp:include>
	<div class="card-body">
		<h3><%=boardName%>
			<small></small><br>
		</h3>
		<hr>
		<table class="table table-borderless">
			<tr>
				<td colspan="2" style="text-align: center">
					<h2>
						"
						<%=adto.getTitle()%>
						"
					</h2>
				</td>
			</tr>
			<tr>
				<td><a href="memberinfo.jsp?uid=<%=adto.getWid()%>"><img src="./profiles/<%=profile%>" class="rounded-circle"
					style="width: 60px; height: 60px; border: 2px solid #BDBDBD;"></a>
					<strong> <%=adto.getWname()%></strong></td>

				<td style="text-align: right"><%=adto.getWdate()%><br> 조회
					: <%=adto.getHit()%></td>
			</tr>

		</table>
		<% if (!adto.getAttatch().equals("nofile")) { %>
		<div class="card-body">
			<img src="./storage/<%= adto.getAttatch() %>" style="width:100%">
		</div>
		<% } %>
		<div class="card">

			<div class="card-body"><%=adto.getContent()%></div>
			<%
				if (userID.equals(adto.getWid())||userLevel==1) {
			%>
			<div class="btn-group" style="width: 150px; margin: 20px auto;">
				<button class="btn btn-light"
					onclick="location.href='boardModify.jsp?bid=<%=bid%>&num=<%=num%>'">수정</button>
				<button class="btn btn-light" data-toggle="modal"
					data-target="#deletearticle">삭제</button>
			</div>
			<!-- 삭제다이얼로그 -->
			<div class="modal fade" id="deletearticle">
				<div class="modal-dialog modal-dialog-centered modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">데이터 삭제</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body" style="text-align: center">정말
							삭제하시겠습니까?</div>

						<!-- Modal footer -->
						<div class="modal-footer" style="text-align: center">

							<button type="button" class="btn btn-danger"
								onclick="location.href='boardDelete.jsp?num=<%=num%>&bid=<%=bid%>'">예</button>

							<button type="button" class="btn btn-success"
								data-dismiss="modal">아니오</button>
						</div>

					</div>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<table class="table table-borderless">
			<tr>
				<td style="text-align: right">
					<button class="btn btn-primary"
						onclick="location.href='boardList.jsp?bid=<%=bid%>'">목록으로</button>
				</td>
			</tr>
		</table>

		<jsp:include page="boardReply.jsp">
			<jsp:param value="<%=bid%>" name="bid" />
			<jsp:param value="<%=num%>" name="anum" />
		</jsp:include>



	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>