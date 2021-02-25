<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>

   <% // 자바 영역
   	Date now = new Date();
   %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hello(현재시각 출력)</title>
</head>
<body>
현재 시각은 <%= now %> 입니다.
</body>
</html>