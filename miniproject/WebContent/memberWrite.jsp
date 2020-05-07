<%@page import="java.net.URLEncoder"%>
<%@page import="board.MemberDTO"%>
<%@page import="board.MiniboardSQL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.io.File"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		String path = application.getRealPath("profiles");

		int size = 1024 * 1024 * 7;
		//MultipartRequest(request,경로,크기,인코딩,생략파일중복여부) ;
		MultipartRequest mr = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());

		try {
			MiniboardSQL ms = new MiniboardSQL();
			MemberDTO dto = new MemberDTO();

			dto.setId(mr.getParameter("uid"));
			dto.setPwd(mr.getParameter("pwd"));
			dto.setName(mr.getParameter("name"));
			dto.setEmail(mr.getParameter("email"));
			dto.setZipcode(mr.getParameter("zipcode"));
			dto.setAddress1(mr.getParameter("address1"));
			dto.setAddress2(mr.getParameter("address2"));
			dto.setProfile(mr.getFilesystemName("profile"));

			ms.createMember(dto);
			
			String name = mr.getParameter("name");
			System.out.print(name);

			response.sendRedirect("memberJoinDone.jsp?name="+URLEncoder.encode(name, "UTF-8"));
			
		} catch (Exception e) {
			response.sendRedirect("error.jsp?ecode="+e.toString());
		}

		
		File ff = mr.getFile("profile");
	%>
	
</body>
</html>