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
		int anum = Integer.parseInt(request.getParameter("anum"));
		String wid = request.getParameter("wid");
		String content = request.getParameter("content");
		int step = Integer.parseInt(request.getParameter("step"));
		int sup = Integer.parseInt(request.getParameter("sup"));
		
		ReplyDTO dto = new ReplyDTO();
		
		dto.setAnum(anum);
		dto.setWid(wid);
		dto.setContent(content);
		dto.setStep(step);
		dto.setSup(sup);

		try {

			MiniboardSQL ms = new MiniboardSQL();
			ms.insertReply(bid, dto);
			response.sendRedirect("boardView.jsp?bid=" + bid + "&num=" + anum + "&hit=false");

		} catch (Exception e) {
			String err = e.toString();
			response.sendRedirect("error.jsp?ecode=" + URLEncoder.encode(err, "UTF-8"));
		}
	%>

</body>
</html>