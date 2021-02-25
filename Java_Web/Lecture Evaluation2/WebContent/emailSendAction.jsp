  
<%@page import="user.UserDAO"%>
<%@page import="javax.mail.internet.InternetAddress"%>

<%@page import="javax.mail.internet.MimeMessage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="javax.mail.*"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.util.Properties"%>	<!-- 속성을 정리할 때 쓰는 라이브러리  -->
<%@ page import="util.Gmail"%>
<%@ page import="java.io.PrintWriter"%>

<%
	UserDAO userDAO = new UserDAO();
String userID = null;
if(session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}
if(userID == null) {
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('로그인을 해주세요.');");
	wr.println("location.href = 'userLogin.jsp'");
	wr.println("</script>");
	wr.close();
	return;
	
}
boolean emailChecked = userDAO.getUserEmailChecked(userID);
if(emailChecked == true) {
	
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('이미 인증 된 회원입니다.');");
	wr.println("location.href = 'index.jsp'");
	wr.println("</script>");
	wr.close();
	return;
}

String host = "http://localhost:9999/Lecture_Evaluation2/";
String from = "ohejoh@gmail.com";	//구글 이메일 계정
String to = userDAO.getUserEmail(userID);
String subject = "강의 평가를 위한 이메일 인증 메일 입니다.";
String content = "다음 링크에 접속하여 이메일 인증을 진행하세요." + "<a href='" + host + "emailCheckAction.jsp?code="
		+ new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";
		
		
// 메일 환경 변수 설정 (smtp에 접속하기위한)
Properties props = new Properties();
// 메일 프로토콜은 gmail를 이용할 것이기 떄문에 smtp로 사용한다.
props.setProperty("mail.transport.protocol", "smtp");
// 메일 호스트 주소를 설정합니다.
props.setProperty("mail.host", "smtp.gmail.com");
//ID, Password 설정이 필요합니다.
props.put("mail.smtp.auth", "true");
//port는 465이다.(고정된 값)
props.put("mail.smtp.port", "465");
// ssl를 사용할 경우 설정
props.put("mail.smtp.socketFactory.port", "465");
props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
props.put("mail.smtp.socketFactory.fallback", "flase");
props.setProperty("mail.smtp.quitwait", "false");

 try {
	 Authenticator auth = new Gmail();
	 Session ses = Session.getInstance(props, auth);
	 ses.setDebug(true);
	 
	 MimeMessage msg = new MimeMessage(ses);
	 msg.setSubject(subject);
	 
	 Address formAddr = new InternetAddress(from);
		msg.setFrom(formAddr);
		
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		msg.setContent(content, "text/html; charset=utf-8");
		Transport.send(msg);

	 
 } catch(Exception e) {
	 e.printStackTrace();
	 PrintWriter wr = response.getWriter();
		wr.println("<script>");
		wr.println("alert('오류가 발생했습니다.');");
		wr.println("history.back();");
		wr.println("</script>");
		wr.close();
		return;
 }
%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>강의평가 웹 사이트</title>
<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="./css/custom.css">
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<ul class="navbar-nav mr-auto">
			<div id="navbar" class="collapse navbar-collapse">
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp">메인</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" id="dropdown"
					data-toggle="dropdown"> 회원관리 </a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
					
					<%
					if(userID == null) {
						
					%>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a> 
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a> 
						
						<%
					} else {
						%>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
					<%
					}
					%>
					
					</div></li>
		</ul>
		<form class="form-inline my-2 my-lg-0">
			<input class="form-control mr-sm-2" type="search"
				placeholder="내용을 입력하세요." aria-label="Search">
			<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
		</form>
		</div>
	</nav>
	<section class="container mt-3" style="max-width: 560px;">
	<div class="container mt-3" style="max-width: 560;">
	이메일 주소 인증 메일이 전송되었습니다. 회원가입시 입력했던 이메일에 들어가셔서 인증해주세요.
	</div>
		


	</section>


	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
	Copyright &copy; 2021 오은지 All Rights Reserved.
	</footer>


	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="./js/pooper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>

</body>
</html>