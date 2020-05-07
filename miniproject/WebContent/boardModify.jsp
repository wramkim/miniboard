<%@page import="board.ArticleDTO"%>
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

</head>



<body>
	<%
		String bid = request.getParameter("bid");
		int num = Integer.parseInt(request.getParameter("num"));

		MiniboardSQL ms = new MiniboardSQL();
		String boardName = ms.getBoardName(bid);

		ArticleDTO dto = ms.getArticle(bid, num, "false");
		
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
			게시글 수정 <small>: <%=boardName%></small>
		</h3>
		<hr>
		<form action="boardModifyProc.jsp" method="post">
			<input type="hidden" name="num" value="<%=num%>"> <input
				type="hidden" name="bid" value="<%=bid%>">
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
								name="title" placeholder="제목" value="<%=dto.getTitle()%>"
								required>
						</div>
					</td>
				</tr>
				<tr>
					<td><textarea id="summernote" name="content" required><%=dto.getContent()%></textarea>
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
				<!--tr>
								<td>
									<div class="input-group mb-3" style="height: 45px;">
										<div class="input-group-prepend">
											<span class="input-group-text"><span class="li_clip"></span></span>
										</div>
										<input type="file" class="form-control" name="attatch" style="height: 100%;">
									</div>
								</td>
							</tr-->
				<tr>
					<td style="text-align: center;">
						<button type="submit" class="btn btn-success" style="width: 200px">
							<span class="li_pen"></span> 수정
						</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>