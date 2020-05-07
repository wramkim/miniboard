<%@page import="board.ReplyDTO"%>
<%@page import="board.ArticleDTO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="board.MiniboardSQL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="global.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		//한글 깨짐 방지
		request.setCharacterEncoding("utf-8");
		
		String bid = request.getParameter("bid");
		int num = Integer.parseInt(request.getParameter("num"));
		int anum = Integer.parseInt(request.getParameter("anum"));
		String content = request.getParameter("content");
		
		ReplyDTO dto = new ReplyDTO();
		
		dto.setNum(num);
		dto.setContent(content);
		
		try {
			MiniboardSQL ms = new MiniboardSQL();
			ms.modifyReply(bid, dto);
			response.sendRedirect("boardView.jsp?bid=" + bid + "&num=" + anum  + "&hit=false");

		} catch (Exception e) {
			String err = e.toString();
			response.sendRedirect("error.jsp?ecode=" + URLEncoder.encode(err, "UTF-8"));
		}
	%>

</body>
</html>