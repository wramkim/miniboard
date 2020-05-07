<%@page import="board.ArticleDTO"%>
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
<style>
.smallfont {
	font-size: 11pt;
}
</style>
</head>
<body>
	<%
		String uid = request.getParameter("uid");
		MiniboardSQL ms = new MiniboardSQL();
		MemberDTO dto = ms.getMember(uid);
	%>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp">
		<jsp:param value="0" name="active" />
	</jsp:include>
	<div class="card-body">
		<button class="btn btn-primary" onclick="history.back()"
			style="margin-bottom: 15px;">&lt; 돌아가기</button>
		<table class="table">
			<tr>
				<td colspan="2"><span class="li_user"></span><strong>
						<%=dto.getName()%></strong>님 상세 정보</td>
			</tr>

			<tr>
				<td colspan="2">
					<table class="table table-borderless">
						<tr>
							<td style="width: 200px; text-align: center"><img
								src="./profiles/<%=dto.getProfile()%>" class="rounded-circle"
								style="width: 180px; height: 180px; border: 4px solid #BDBDBD;">
							</td>
							<td style="vertical-align: middle"><h3><%=dto.getName()%><br>
									<small>(<%=uid%>)
									</small>
								</h3></td>
						</tr>
					</table>
				</td>
			</tr>

			<tr>
				<td>회원 등급</td>
				<td>
					<%
						int level = dto.getLevel();
						String grade = "";

						switch (level) {
						case 1:
							grade = "관리자";
							break;
						case 2:
							grade = "일반 회원";
							break;
						}
					%> <%=grade%> (<%=level%>)
				</td>
			</tr>

			<tr>
				<td>이메일 주소</td>
				<td><%=dto.getEmail()%></td>
			</tr>
			<tr
				style="display:<%=((userID != null && userID.equals(dto.getId())) ? "table-row" : "none")%>">
				<td>주소</td>
				<td><%=dto.getAddress1()%><br><%=dto.getAddress2()%></td>
			</tr>
			<tr>
				<td>가입일</td>
				<td><%=dto.getJdate()%></td>
			</tr>


		</table>
		<div class="card" style="padding: 10px">
			<table class="table table-sm table-borderless">
				<tr>
					<td><span class="li_note"></span><strong> <%=dto.getName()%></strong>님의
						최근 게시물</td>
				</tr>
				<%
					ArrayList<ArticleDTO> recent = ms.getRecentArticles(dto.getId());

					for (int i = 0; i < recent.size(); i++) {
						ArticleDTO adto = recent.get(i);
				%>
				<tr>
					<td class="smallfont"><span class="text-info">[<%=ms.getBoardName(adto.getWid())%>]
					</span> <a
						href="boardView.jsp?bid=<%=adto.getWid()%>&num=<%=adto.getNum()%>"><%=adto.getTitle()%></a>
						<span class="badge badge-secondary"
						style="display:<%=(adto.getRcnt() > 0) ? "inline-block" : "none"%>"><%=adto.getRcnt()%></span></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>