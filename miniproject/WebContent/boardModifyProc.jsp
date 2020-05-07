<%@page import="board.ArticleDTO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="board.MemberDTO"%>
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
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int num = Integer.parseInt(request.getParameter("num"));
		
		ArticleDTO dto = new ArticleDTO();
		
		
		dto.setTitle(title);
		dto.setContent(content);
		dto.setAttatch("nofile");
		
		try {
			
			MiniboardSQL ms = new MiniboardSQL();
			ms.updateArticle(bid, dto, num);
			response.sendRedirect("boardList.jsp?bid="+bid);
			
		} catch (Exception e) {
			String err = e.toString();
			response.sendRedirect("error.jsp?ecode="+URLEncoder.encode(err, "UTF-8"));
		}
		
	%>
	<%=title%><br>
	<hr>
	<br>
	<%=content%>

</body>
</html>