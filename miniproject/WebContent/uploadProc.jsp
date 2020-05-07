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
		String path = application.getRealPath("storage");

		int size = 1024 * 1024 * 7;
		//MultipartRequest(request,경로,크기,인코딩,생략파일중복여부) ;
		MultipartRequest mr = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());

		String fileName = mr.getFilesystemName("file");
	%>
	<script>
	opener.document.getElementById("preview").innerHTML = "<%=fileName%>";
	opener.document.getElementById("attatch").value = "<%=fileName%>";
	window.close();
	</script>
</body>
</html>