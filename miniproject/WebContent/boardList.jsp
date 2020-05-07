<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
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

.table td{
	font-size: 11pt;
}
</style>
</head>
<body>
	<%
		//한글 깨짐 방지
		request.setCharacterEncoding("utf-8");

		String bid = request.getParameter("bid");
		if (bid == null || bid.equals("")) {
			String err = "잘못된 접근입니다.";
			response.sendRedirect("error.jsp?ecode=" + URLEncoder.encode(err, "UTF-8"));
			return;
		}

		String pageNum = request.getParameter("page");
		if (pageNum == null || pageNum.equals(""))
			pageNum = "1";
		int pnum = Integer.parseInt(pageNum);

		String keyfield = request.getParameter("keyfield");
		if (keyfield == null || keyfield.equals(""))
			keyfield = "title";

		String keyword = request.getParameter("keyword");
		if (keyword == null || keyword.equals(""))
			keyword = "";

		MiniboardSQL ms = new MiniboardSQL();

		String boardName = ms.getBoardName(bid);
		String boardDesc = ms.getBoardDesc(bid);

		// 페이징 관련 코드
		int stotal = ms.getSearchedTotal(bid, keyfield, keyword);
		int atotal = ms.getTotal(bid);
		int acnt = 15; // 목록 표시 개수
		int lastpage = (int) ((stotal - 1) / acnt) + 1;

		int pageStart = ((pnum - 1) / acnt) * acnt + 1;
		int pageEnd = pageStart + (acnt - 1);

		if (pageEnd > lastpage)
			pageEnd = lastpage;

		if (pnum > lastpage)
			pnum = lastpage;
		
		int menunum = 0;
		if (bid.equals("notice"))
			menunum=2;
		else if (bid.equals("gallery"))
			menunum=4;
		else
			menunum=3;
		
		if (bid.equals("gallery")){
	%>
	<jsp:forward page="boardGallery.jsp">
		<jsp:param value="gallery" name="bid"/>
		<jsp:param value="<%=keyword %>" name="keyword"/>
		<jsp:param value="<%=keyfield %>" name="keyfield"/>
		<jsp:param value="<%=pnum %>" name="page"/>
	</jsp:forward>
	<% } %>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp">
		<jsp:param value="<%= menunum %>" name="active" />
	</jsp:include>
	<div class="card-body">
		<h3><%=boardName%>
			<small><span class="badge badge-secondary"> <%=((stotal == atotal) ? "" : (stotal + " / "))%><%=atotal%>
			</span></small><br>
		</h3>
		<dl><%="- " + boardDesc%></dl>
		<div class="row">
			<div class="col"></div>
			<div class="col">
				<!-- 검색창 -->
				<form name="search" action="boardList.jsp" method="post">
					<input type="hidden" name="bid" value="<%=bid%>">
					<div class="input-group input-group-sm mb-3" style="">
						<div class="input-group-prepend input-group-sm">
							<select name="keyfield" class="custom-select"
								onchange="clearText();">
								<!-- option <%//out.print((keyword.equals("")) ? "selected" : "");%> value="">분류</option -->
								<option value="title"
									<%out.print((keyfield.equals("title") && !(keyword.equals("")) ? "selected" : ""));%>>제목</option>
								<option value="content"
									<%out.print((keyfield.equals("content") ? "selected" : ""));%>>내용</option>
								<option value="wname"
									<%out.print((keyfield.equals("wname") ? "selected" : ""));%>>작성자</option>
							</select>
						</div>
						<input type="text" class="form-control" name="keyword"
							placeholder="검색어를 입력하세요" value=<%=keyword%>>
						<div class="input-group-append input-group-sm">
							<button class="btn btn-primary" type="submit">
								<span class="li_search"></span>
							</button>
						</div>

					</div>
				</form>

			</div>
		</div>
		<table class="table">
			<tr>
				<th style="width: 10%; text-align: center">번호</th>
				<th style="min-width: 45%; text-align: center">제목</th>
				<th style="width: 150px; text-align: center">작성자</th>
				<th style="width: 100px; text-align: center">날짜</th>
				<th style="width: 90px; text-align: center">조회수</th>
			</tr>
			<!-- 목록 출력 -->
			<%
				int end = pnum * acnt;
				int start = end - (acnt - 1);
				ArrayList<ArticleDTO> list = ms.getList(bid, pnum, keyfield, keyword, start, end);
				//System.out.println(new Date().getTime());
				for (int i = 0; i < list.size(); i++) {
					ArticleDTO dto = list.get(i);
					MemberDTO mdto = ms.getMember(dto.getWid());
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					
					SimpleDateFormat nodate = new SimpleDateFormat("HH:mm:ss");
					SimpleDateFormat notime = new SimpleDateFormat("yyyy/MM/dd");
					
					java.util.Date dt = sdf.parse(dto.getWdate());
					long timepassed = (new java.util.Date().getTime() - dt.getTime()) / 60000;
					
					boolean istoday = false;
					if (notime.format(dt).equals(notime.format(new java.util.Date())))
						istoday = true;
			%>
			<tr>
				<td style="text-align: center"><%=dto.getNum()%></td>
				<td><a href="boardView.jsp?bid=<%=bid%>&num=<%=dto.getNum()%>"><%=dto.getTitle()%></a>
					<span class="badge badge-secondary"
					style="display:<%=(dto.getRcnt() > 0) ? "inline-block" : "none"%>"><%=dto.getRcnt()%></span>
					<span class="badge badge-warning text-light"
					style="display:<%=(timepassed<60)?"inline-block":"none"%>">NEW</span></td>
				<td style="text-align: center"><a href="memberinfo.jsp?uid=<%=mdto.getId()%>"><img
					src="./profiles/<%=mdto.getProfile()%>" class="rounded-circle"
					style="width: 25px; height: 25px; border: 1px solid #BDBDBD;"></a>
					<%=dto.getWname()%></td>
				<td style="text-align: center"><%= (istoday) ? nodate.format(dt) : notime.format(dt) %></td>
				<td style="text-align: center"><%=dto.getHit()%></td>
			</tr>
			<%
				}
				if (userLevel <= ms.getBoardWlevel(bid) && logged) {
			%>
			<tr>
				<td colspan="5" style="text-align: right">
					<button class="btn btn-success"
						onclick="location.href='boardWrite.jsp?bid=<%=bid%>'">
						<span class="li_pen"></span> 글쓰기
					</button>
				</td>
			</tr>
			<%
				}
			%>
		</table>



		<!-- 페이징 -->
		<ul class="pagination justify-content-center" style="margin-top: 10px">
			<%
				if (pageStart != 1) {
			%>
			<li class="page-item"><a class="page-link"
				href="boardList.jsp?bid=<%=bid%>&page=<%=pageStart - 10%>&keyfield=<%=keyfield%>&keyword=<%=keyword%>">이전</a></li>
			<%
				}
				int i = 0;
				for (i = pageStart; i <= pageEnd; i++) {
			%>
			<li class="page-item <%=(i == pnum) ? "active " : ""%>"><a
				class="page-link"
				href="boardList.jsp?bid=<%=bid%>&page=<%=i%>&keyfield=<%=keyfield%>&keyword=<%=keyword%>"><%=i%></a></li>
			<%
				}
				if (pageEnd != lastpage) {
			%>
			<li class="page-item"><a class="page-link"
				href="boardList.jsp?bid=<%=bid%>&page=<%=pageStart + 10%>">다음</a></li>
			<%
				}
			%>
		</ul>

	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>