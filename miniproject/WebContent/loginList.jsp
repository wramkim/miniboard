<%@ page language="java" contentType="text/html; charset=UTF-8"   %>
<%@ include file="ssi.jsp" %>
<!DOCTYPE html>
<html> <head>
<title> [loginList.jsp]</title>
   <style type="text/css">
	  *{font-size:14pt; font-weight:bold;  font-family: Comic Sans MS ; margin-left: 10px; }
	  a{font-size:14pt; text-decoration:none; font-weight:bold; color:blue;  font-family: Comic Sans MS ; }
	  a:hover{font-size:16pt; text-decoration:underline; color:green;  font-family: Comic Sans MS ; }
   </style>
</head>
<body>
 <p><br>
 <div align="center">
   <img src="images/a1.png">
 </div>
<%
  //loginList.jsp
   String a = request.getParameter("userid");
   String b = request.getParameter("pwd");
  try{
   msg="select count(*) as cnt from login where userid =? and pwd =? ";
   PST=CN.prepareStatement(msg);
   		PST.setString(1, a);
   		PST.setString(2, b);
   RS=PST.executeQuery();
  }catch(Exception ex){ System.out.println(ex); }
 if(RS.next()==true){ Gtotal=RS.getInt("cnt"); }
 if( Gtotal>0){	 
	 session.setAttribute("naver", a); //userid값을 가짜변수 naver에 넘김
	 response.sendRedirect("glist.tis");
	 
	 //Cookie ck=new Cookie("google", a); //쿠키내장클래스 객체화 
	 //response.addCookie(ck); //쿠키추가등록
	 //response.sendRedirect("main.jsp");
 }else{
%>	 
  <script type="text/javascript">
     alert("로그인문서로 이동합니다\UserID,PWD데이터를 입력하세요");
     location.href="login.jsp";
  </script>	 
<%}%>	
</body>
</html>







