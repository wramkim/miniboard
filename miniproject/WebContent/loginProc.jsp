<%@page import="java.net.URLEncoder"%>
<%@page import="board.MemberDTO"%>
<%@page import="board.MiniboardSQL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		String uid = request.getParameter("uid");
		String pwd = request.getParameter("pwd");

		try {
			MiniboardSQL ms = new MiniboardSQL();
			if (ms.loginCheck(uid, pwd)){
				MemberDTO dto = ms.getMember(uid);
				session.setAttribute("id", uid);
				response.sendRedirect(request.getHeader("referer"));
				
			} else {
				String err = "잘못된 정보입니다.";
				response.sendRedirect("error.jsp?ecode="+URLEncoder.encode(err, "UTF-8"));
			}
		} catch (Exception e) {
			response.sendRedirect("error.jsp?ecode="+e.toString());
		}
	%>
	
</body>
</html>