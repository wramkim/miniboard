<%@page import="java.net.URLEncoder"%>
<%@page import="board.MemberDTO"%>
<%@page import="board.MiniboardSQL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%
		boolean logged = true;

		String userID = (String) session.getAttribute("id");
		String userName = "";
		String userProfile = "";

		int userLevel = 0;
		String userGrade = "";

		if (userID == null || "".equals(userID)) {
			logged = false;
			userID = " ";
		} else {
			try {
				MiniboardSQL ms = new MiniboardSQL();
				MemberDTO dto = ms.getMember(userID);

				userName = dto.getName();
				userProfile = dto.getProfile();
				userLevel = dto.getLevel();

				switch (userLevel) {
				case 1:
					userGrade = "관리자";
					break;
				case 2:
					userGrade = "일반 회원";
					break;
				}
			} catch (Exception e) {
				String err = e.toString();
				response.sendRedirect("error.jsp?ecode=" + URLEncoder.encode(err, "UTF-8"));
			}
		}
	%>

</body>
</html>