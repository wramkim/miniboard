<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>

<!-- include libraries(jQuery, bootstrap, fontawesome) -->
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.css"
	rel="stylesheet">


<!-- include summernote css/js-->
<link href="./summernote/summernote-bs4.css" rel="stylesheet">
<script src="./summernote/summernote-bs4.js"></script>
<script>
	function openFile() {
		
		var popupX = (window.screen.width / 2) - (500 / 2);
		var popupY = (window.screen.height / 2) - (180 / 2);
		
		window.name = "parent";
		newWin = window
				.open('upload.jsp?', 'child',
						'width=500, height=180, left='+popupX+', top='+popupY+', menubar=no, status=no, toolbar=no');
	}
</script>
</head>



<body>
	<%
		String bid = request.getParameter("bid");
		if (bid == null || bid.equals("")) {
			String err = "잘못된 접근입니다.";
			response.sendRedirect("error.jsp?ecode=" + URLEncoder.encode(err, "UTF-8"));
			return;
		}

		MiniboardSQL ms = new MiniboardSQL();
		String boardName = ms.getBoardName(bid);

		int menunum = 0;
		if (bid.equals("notice"))
			menunum = 2;
		else if (bid.equals("gallery"))
			menunum = 4;
		else
			menunum = 3;
	%>
	<jsp:include page="header.jsp"></jsp:include>

	<jsp:include page="menu.jsp">
		<jsp:param value="<%=menunum%>" name="active" />
	</jsp:include>
	<div class="card-body">
		<h3>
			게시글 작성 <small>: <%=boardName%></small>
		</h3>
		<hr>
		<form action="boardWriteProc.jsp" method="post">
			<input type="hidden" name="bid" value="<%=bid%>">
			<table class="table table-borderless">
				<tr>
					<td><img src="./profiles/<%=userProfile%>"
						class="rounded-circle"
						style="width: 50px; height: 50px; border: 2px solid #BDBDBD;">
						<strong><%=userName%></strong></td>
				</tr>
				<tr>
					<td>
						<div class="form-group" style="width: 100%;">
							<input type="text" class="form-control form-control-sm"
								name="title" placeholder="제목" required>
						</div>
					</td>
				</tr>
				<tr>
					<td><textarea id="summernote" name="content" required></textarea>
						<script>
							$(document)
									.ready(
											function() {
												$('#summernote')
														.summernote(
																{
																	height : 300,
																	toolbar : [
																			// [groupName, [list of button]]
																			[
																					'style',
																					[
																							'bold',
																							'italic',
																							'underline',
																							'clear' ] ],
																			[
																					'font',
																					[
																							'strikethrough',
																							'superscript',
																							'subscript' ] ],
																			[
																					'fontsize',
																					[ 'fontsize' ] ],
																			[
																					'color',
																					[ 'color' ] ],
																			[
																					'para',
																					[
																							'ul',
																							'ol',
																							'paragraph' ] ],
																			[
																					'height',
																					[ 'height' ] ] ]
																}

														);
											});
						</script></td>
				</tr>
				<%
					if (bid.equals("gallery")) {
				%>
				<tr>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text"><span class="li_clip"></span></span>
							</div>
							<div class="form-control" id="preview"></div>
							<div class="input-group-append">
								<button class="btn btn-info" type="button" onclick="openFile()">첨부</button>
							</div>
						</div>
					</td>
				</tr>
				<%
					}
				%>
				<tr>
					<td style="text-align: center;"><input type="hidden"
						name="attatch" id="attatch" value="nofile">
						<button type="submit" class="btn btn-success" style="width: 200px">
							<span class="li_pen"></span> 작성
						</button></td>
				</tr>
			</table>
		</form>

	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>