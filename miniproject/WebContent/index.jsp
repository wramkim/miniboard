<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.ArticleDTO"%>
<%@page import="board.BoardsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어서오세요</title>
<style>
.table td {
	font-size: 11pt;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp">
		<jsp:param value="0" name="active" />
	</jsp:include>
	<div class="card-body">
		<!-- 최근공지 1건 -->
		<p>
		<span class="badge badge-warning text-light">notice</span>
		<%
			MiniboardSQL ms = new MiniboardSQL();
			ArticleDTO ndto = ms.getNotice();
		%>
		<a href="boardView.jsp?bid=notice&num=<%=ndto.getNum() %>"><%=ndto.getTitle() %></a>
		</p>
		<hr>
		<!-- 검색창 -->
		<div style="text-align: center; width: 500px; margin: 50px auto">
			<h2 style="margin-bottom: 50px">
				<span class="li_search"></span><br> <small>전체 게시판 검색</small>
			</h2>
			<form name="search" action="boardList.jsp" method="post">
				<div class="input-group mb-3" style="">
					<div class="input-group-prepend">

						<select name="bid" class="custom-select" onchange="clearText();">
							<%
								ArrayList<BoardsDTO> blist = ms.getBoards();

								for (int i = 0; i < blist.size(); i++) {
									BoardsDTO dto = blist.get(i);
							%>
							<option value="<%=dto.getBid()%>"><%=dto.getBname()%></option>
							<%
								}
							%>

						</select>
					</div>
					<input type="text" class="form-control" name="keyword"
						placeholder="검색어를 입력하세요">
					<div class="input-group-append input-group-sm">
						<button class="btn btn-primary" type="submit">검색</button>
					</div>
				</div>
				<div class="form-check-inline">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="keyfield" value="title"
						checked="checked">제목
					</label>
				</div>
				<div class="form-check-inline">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="keyfield" value="content">내용
					</label>
				</div>
				<div class="form-check-inline">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="keyfield" value="wname">작성자
					</label>
				</div>
			</form>
		</div>
		<hr>
		<!-- 최근 게시물 15건 -->
		<h5>최근 게시글</h5>
		<table class="table table-sm">
			<tr style="text-align:center;">
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
			</tr>
			<%
				ArrayList<ArticleDTO> alist = ms.getRecentArticles();

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				SimpleDateFormat nodate = new SimpleDateFormat("HH:mm:ss");
				SimpleDateFormat notime = new SimpleDateFormat("yyyy/MM/dd");

				for (int i = 0; i < alist.size(); i++) {
					ArticleDTO adto = alist.get(i);
					MemberDTO mdto = ms.getMember(adto.getWid());
					java.util.Date dt = sdf.parse(adto.getWdate());
					long timepassed = (new java.util.Date().getTime() - dt.getTime()) / 60000;

					boolean istoday = false;
					if (notime.format(dt).equals(notime.format(new java.util.Date())))
						istoday = true;
			%>
			<tr>
				<td><span class="text-info">[<%=ms.getBoardName(adto.getBid())%>]
				</span> <a
					href="boardView.jsp?bid=<%=adto.getBid()%>&num=<%=adto.getNum()%>">
						<%=adto.getTitle()%></a> <span class="badge badge-secondary"
					style="display:<%=(adto.getRcnt() > 0) ? "inline-block" : "none"%>"><%=adto.getRcnt()%></span>
					<span class="badge badge-warning text-light"
					style="display:<%=(timepassed < 60) ? "inline-block" : "none"%>">new</span></td>
				<td style="text-align: center"><a
					href="memberinfo.jsp?uid=<%=mdto.getId()%>"><img
						src="./profiles/<%=mdto.getProfile()%>" class="rounded-circle"
						style="width: 25px; height: 25px; border: 1px solid #BDBDBD;"></a>
					<%=mdto.getName()%></td>
				<td style="text-align:center"><%=(istoday) ? nodate.format(dt) : notime.format(dt)%></td>
			</tr>
			<%
				}
			%>
		</table>

	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>