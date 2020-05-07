<%@page import="board.ReplyDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script>
	function showReply(n, m){
		for (var i=0; i<m;i++){
			document.getElementById("replyform"+i).style.display="none";
		}
		document.getElementById("replyform"+n).style.display="table-row";
	}
	
	function hideReply(n) {
		document.getElementById("replyform"+n).style.display="none";
	}
	
	
	function showModify(n, m) {
		for (var i=0; i<m;i++){
			document.getElementById("mainreply"+i).style.display="table-row";
			document.getElementById("modifyform"+i).style.display="none";
		}
		document.getElementById("mainreply"+n).style.display="none";
		document.getElementById("modifyform"+n).style.display="table-row";
	}
	
	function hideModify(n) {
		document.getElementById("mainreply"+n).style.display="table-row";
		document.getElementById("modifyform"+n).style.display="none";
	}
	
	function showReplyModify(k, n, m) {
		for (var i=0; i<m;i++){
			document.getElementById("sub"+k+"reply"+n).style.display="table-row";
			document.getElementById("reply"+k+"modifyform"+n).style.display="none";
		}
		document.getElementById("sub"+k+"reply"+n).style.display="none";
		document.getElementById("reply"+k+"modifyform"+n).style.display="table-row";
	}
	
	function hideReplyModify(k, n) {
		document.getElementById("sub"+k+"reply"+n).style.display="table-row";
		document.getElementById("reply"+k+"modifyform"+n).style.display="none";
	}
</script>
</head>
<body>
	<%
		int anum = Integer.parseInt(request.getParameter("anum"));
		int rtotal = 0;
		String bid = request.getParameter("bid");

		MiniboardSQL ms = new MiniboardSQL();

		ArrayList<ReplyDTO> mainList = ms.getReply(bid, anum, 0, 0);
		rtotal = mainList.size();
	%>


	<!-- 댓글 없을 때 -->

	<!-- 댓글 목록 -->
	<div class="container-fluid">

		<table class="table table-borderless" style="border-spacing: 0px;">
			<tr style="display:<%=((logged) ? "table-row" : "none")%>">
				<th colspan="3">댓글 작성</th>
			</tr>
			<!-- 댓글 입력 폼 -->

			<tr style="display:<%=((logged) ? "table-row" : "none")%>">
				<!-- 프로필이미지 -->
				<td style="width: 100px; text-align: center;"><img
					src="./profiles/<%=userProfile%>" class="rounded-circle"
					style="width: 60px; height: 60px; border: 2px solid #BDBDBD;">
					<p>
						<%=userName%></p></td>
				<!-- 폼 -->
				<td colspan="2">
					<form action="boardReplyWrite.jsp">
						<input type="hidden" name="bid" value="<%=bid%>"> <input
							type="hidden" name="wid" value="<%=userID%>"> <input
							type="hidden" name="anum" value="<%=anum%>"> <input
							type="hidden" name="sup" value="0"> <input type="hidden"
							name="step" value="0">
						<div class="input-group">
							<textarea class="form-control" rows="4" placeholder="내용을 입력하세요."
								name="content" required></textarea>
							<div class="input-group-append">
								<button class="btn btn-success" type="submit">작성</button>
							</div>
						</div>
					</form>
				</td>
			</tr>

			<tr style="display:<%=(rtotal > 0) ? "table-row" : "none"%>">
				<th colspan="3">댓글 목록</th>
			</tr>

			<%
				for (int i = 0; i < mainList.size(); i++) {
					ReplyDTO mainDTO = mainList.get(i);
					MemberDTO mainWriter = ms.getMember(mainDTO.getWid());
			%>

			<!-- 메인 댓글 -->
			<tr>
				<td colspan="3"
					style="border-spacing: 0px; margin: 0px; padding: 0px;">
					<hr>
				</td>
			</tr>
			<tr id="mainreply<%=i%>" style="display: table-row;">
				<!-- 프로필이미지 -->
				<td style="width: 100px; text-align: center;"><a href="memberinfo.jsp?uid=<%=mainWriter.getId()%>"><img
					src="./profiles/<%=mainWriter.getProfile()%>"
					class="rounded-circle"
					style="width: 60px; height: 60px; border: 2px solid #BDBDBD;"></a>
					<p>
						<%=mainWriter.getName()%></p></td>

				<!-- 댓글 내용 -->
				<td colspan="2">
					<div class="card">
						<table class="table table-borderless">
							<tr>
								<td style="vertical-algin: middle"><%=mainDTO.getWdate()%></td>
								<td style="text-align: right">
									<div class="btn-group btn-group-sm">
										<button class="btn btn-light"
											style="display:<%=(userID.equals(mainDTO.getWid())||userLevel==1) ? "block" : "none"%>"
											onclick="showModify(<%=i%>, <%=rtotal%>)">수정</button>
										<button class="btn btn-light"
											style="display:<%=(userID.equals(mainDTO.getWid())||userLevel==1) ? "block" : "none"%>"
											data-toggle="modal"
											data-target="#delete<%=mainDTO.getNum()%>">삭제</button>
										<button class="btn btn-light"
											style="display:<%=(logged) ? "block" : "none"%>"
											onclick="showReply(<%=i%>, <%=rtotal%>);">답글</button>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3"><%=mainDTO.getContent()%></td>
							</tr>

						</table>
					</div> <!-- 삭제다이얼로그 -->
					<div class="modal fade" id="delete<%=mainDTO.getNum()%>">
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
										onclick="location.href='boardReplyDelete.jsp?bid=<%=bid%>&anum=<%=anum%>&num=<%=mainDTO.getNum()%>'">예</button>

									<button type="button" class="btn btn-success"
										data-dismiss="modal">아니오</button>
								</div>

							</div>
						</div>
					</div>
				</td>

			</tr>
			<!-- 메인 댓글 수정 폼 -->
			<tr id="modifyform<%=i%>" style="display:none">
				<td style="width: 100px; text-align: center;"><img
					src="./profiles/<%=userProfile%>" class="rounded-circle"
					style="width: 60px; height: 60px; border: 2px solid #BDBDBD;">
					<p>
						<%=userName%></p></td>
				<td colspan="2">
					<form action="boardReplyModify.jsp">
						<input type="hidden" name="num" value="<%=mainDTO.getNum()%>">
						<input type="hidden" name="anum" value="<%=anum%>"> <input
							type="hidden" name="bid" value="<%=bid%>">
						<div class="input-group">
							<textarea class="form-control" rows="4" placeholder="내용을 입력하세요."
								name="content"><%=mainDTO.getContent()%></textarea>
							<div class="input-group-append">
								<div class="btn-group btn-group-sm">
									<button class="btn btn-info" type="submit">수정</button>
									<button class="btn btn-danger" type="button"
										onclick="hideModify(<%=i%>)">취소</button>
								</div>
							</div>
						</div>
					</form>
					<hr>
				</td>
			</tr>
			<%
				ArrayList<ReplyDTO> subList = ms.getReply(bid, anum, mainDTO.getNum(), 1);
					int subtotal = subList.size();
			%>
			<!-- 메인 댓글 답변 폼 -->
			<tr id="replyform<%=i%>" style="display: none">
				<td></td>
				<td>
					<form action="boardReplyWrite.jsp">
						<input type="hidden" name="bid" value="<%=bid%>"> <input
							type="hidden" name="wid" value="<%=userID%>"> <input
							type="hidden" name="anum" value="<%=anum%>"> <input
							type="hidden" name="sup" value="<%=mainDTO.getNum()%>"> <input
							type="hidden" name="step" value="1">
						<div class="input-group">
							<textarea class="form-control" rows="4" placeholder="내용을 입력하세요."
								name="content" required></textarea>
							<div class="input-group-append">
								<div class="btn-group btn-group-sm">
									<button class="btn btn-info" type="submit">작성</button>
									<button class="btn btn-danger" onclick="hideReply(<%=i%>)">취소</button>
								</div>
							</div>
						</div>
					</form>
					<hr>
				</td>
				<td style="width: 100px; text-align: center;"><img
					src="./profiles/<%=userProfile%>" class="rounded-circle"
					style="width: 60px; height: 60px; border: 2px solid #BDBDBD;">
					<p>
						<%=userName%></p></td>
			</tr>
			<!-- 서브 댓글 -->
			<%
				for (int j = 0; j < subtotal; j++) {
						ReplyDTO subDTO = subList.get(j);
						MemberDTO subWriter = ms.getMember(subDTO.getWid());
			%>
			<tr id="sub<%=i%>reply<%=j%>">

				<td></td>

				<!-- 서브 댓글 내용 -->
				<td>
					<div class="card">
						<table class="table table-borderless">
							<tr>
								<td style="vertical-algin: middle"><%=subDTO.getWdate()%></td>
								<td style="text-align: right">
									<div class="btn-group btn-group-sm">
										<button class="btn btn-light"
											style="display:<%=(userID.equals(subDTO.getWid())||userLevel==1) ? "block" : "none"%>"
											onclick="showReplyModify(<%=i%>,<%=j%>, <%=subtotal%>)">수정</button>
										<button class="btn btn-light"
											style="display:<%=(userID.equals(subDTO.getWid())||userLevel==1) ? "block" : "none"%>"
											data-toggle="modal" data-target="#delete<%=subDTO.getNum()%>">삭제</button>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3"><%=subDTO.getContent()%></td>
							</tr>

						</table>
					</div> <!-- 삭제다이얼로그 -->
					<div class="modal fade" id="delete<%=subDTO.getNum()%>">
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
										onclick="location.href='boardReplyDelete.jsp?bid=<%=bid%>&anum=<%=anum%>&num=<%=subDTO.getNum()%>'">예</button>

									<button type="button" class="btn btn-success"
										data-dismiss="modal">아니오</button>
								</div>

							</div>
						</div>
					</div>
				</td>

				<!-- 프로필 이미지 -->
				<td style="width: 80px; text-align: center;"><a href="memberinfo.jsp?uid=<%=subWriter.getId()%>"><img
					src="./profiles/<%=subWriter.getProfile()%>" class="rounded-circle"
					style="width: 60px; height: 60px; border: 2px solid #BDBDBD;"></a>
					<p>
						<%=subWriter.getName()%></p></td>
			</tr>
			<!-- 서브 댓글 수정 -->
			<tr id="reply<%=i%>modifyform<%=j%>" style="display: none">
				<td></td>
				<td>
					<form action="boardReplyModify.jsp">
						<input type="hidden" name="num" value="<%=subDTO.getNum()%>">
						<input type="hidden" name="bid" value="<%=bid%>"> <input
							type="hidden" name="anum" value="<%=anum%>">
						<div class="input-group">
							<textarea class="form-control" rows="4" placeholder="내용을 입력하세요."
								name="content"><%=subDTO.getContent()%></textarea>
							<div class="input-group-append">
								<div class="btn-group btn-group-sm">
									<button class="btn btn-info" type="submit">수정</button>
									<button class="btn btn-danger" type="button"
										onclick="hideReplyModify(<%=i%>,<%=j%>)">취소</button>
								</div>
							</div>
						</div>
					</form>
					<hr>
				</td>
				<td style="width: 100px; text-align: center;"><img
					src="./profiles/<%=userProfile%>" class="rounded-circle"
					style="width: 60px; height: 60px; border: 2px solid #BDBDBD;">
					<p>
						<%=userName%></p></td>
			</tr>
			<%
				}
				}
			%>
		</table>
		<%
			if (rtotal > 0) {
		%>
		<table class="table table-borderless">
			<tr>
				<td style="text-align: right">
					<button class="btn btn-primary"
						onclick="location.href='boardList.jsp?bid=<%=bid%>'">목록으로</button>
				</td>
			</tr>
		</table>
		<%
			}
		%>
	</div>
</body>
</html>