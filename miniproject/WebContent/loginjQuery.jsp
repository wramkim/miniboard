<%@ page language="java" contentType="text/html; charset=UTF-8"   %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
   <meta name="description" content="html5">
   <meta name="author" content="author">
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title> [loginjQuery.jsp]</title>
   <style type="text/css">
	  *{font-size:20pt; font-weight:bold;  font-family: Comic Sans MS ; margin-left: 10px; }
	  a{font-size:20pt; text-decoration:none; font-weight:bold; color:blue;  font-family: Comic Sans MS ; }
	  a:hover{font-size:24pt; text-decoration:underline; color:green;  font-family: Comic Sans MS ; }
	  #LOG_IN{  
	    font-size:30pt; 
	    font-weight:bold;  
	    height:150px;
	    background:lightgreen;  
	   }
   </style>
   
   
  <script type="text/javascript">
   
 </script> 
</head>
<body>
 <font color=blue> [loginjQuery.jsp문서] </font><br>
 <table width=500 border=1 cellspacing=0 cellpadding=0>
   <form name="form">
   <tr>
   	 <td>UID:</td>
   	 <td width=200> <input type=text name="userid"  value="blue"> </td>
   	 <td rowspan="2"  align="center">
   	 	<input type="submit" value="LOG_IN" id="LOG_IN"> 
   	 </td>
   </tr>
   
   <tr>
   	  <td>PWD:</td>
   	  <td> <input type="password" name="pwd"  value="1234"> </td>
   </tr>
   </form>
 </table>


	<p>
	<a href="index.jsp"> [index]</a>
	<a href="guestWrite.jsp"> [입력화면]</a>
	<a href="glist.tis"> [전체출력]</a>
</body>
</html>