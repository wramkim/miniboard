<%@page import="board.BoardsDTO"%>
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
		
		int num = Integer.parseInt(request.getParameter("num"));
		String bid = request.getParameter("bid");
		String bname = request.getParameter("bname");
		String bdesc = request.getParameter("bdesc");
		int wlevel = Integer.parseInt(request.getParameter("wlevel"));
		int inlist = Integer.parseInt(request.getParameter("inlist"));
		
		
		
		//try {
			
			BoardsDTO dto = new BoardsDTO();
			
			dto.setNum(num);
			dto.setBid(bid);
			dto.setBname(bname);
			dto.setBdesc(bdesc);
			dto.setWlevel(wlevel);
			dto.setInlist(inlist);
			
			MiniboardSQL ms = new MiniboardSQL();
			ms.insertBoard(dto);
			
			response.sendRedirect("admin.jsp");
			
		//} catch (Exception e) {
			//String err = e.toString();
			//response.sendRedirect("error.jsp?ecode="+URLEncoder.encode(err, "UTF-8"));
		//}
		
	%>
	
</body>
</html>