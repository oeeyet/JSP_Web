<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.mail.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="util.Gmail"%>
<%@ page import="user.UserDTO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
UserDAO userDAO = new UserDAO();
String userID = null;
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}
if (userID == null) {
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('로그인을 해주세요.');");
	wr.println("location.href = 'userLogin.jsp'");
	wr.println("</script>");
	wr.close();
	return;
}
request.setCharacterEncoding("utf-8");
String reportTitle = null;
String reportContent = null;
if (request.getParameter("reportTitle") != null) {
	reportTitle = request.getParameter("reportTitle");
}
if (request.getParameter("reportContent") != null) {
	reportContent = request.getParameter("reportContent");
}
if (reportTitle == null || reportContent == null) {
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('입력이 안 된 사항이 있습니다.');");
	wr.println("history.back();");
	wr.println("</script>");
	wr.close();
	return;
}
String host = "http://localhost:8080/Lecture_Evaluation/";
String from = "jeaho0613@gmail.com";
String to = userDAO.getUserEmail(userID);
String subject = "강의평가 사이트에서 접수된 신고 메일입니다.";
String content = "신고자 : " + userID + "<br>제목: " + reportTitle + "<br>제목: " + reportContent;
//메일 환경 변수 설정입니다.
Properties props = new Properties();
//메일 프로토콜은 gmail를 이용할 것이기 때문에 smtp로 사용합니다.
props.setProperty("mail.transport.protocol", "smtp");
//메일 호스트 주소를 설정합니다.
props.setProperty("mail.host", "smtp.gmail.com");
//ID, Password 설정이 필요합니다.
props.put("mail.smtp.auth", "true");
//port는 465입니다.
props.put("mail.smtp.port", "465");
//ssl를 사용할 경우 설정합니다.
props.put("mail.smtp.socketFactory.port", "465");
props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
props.put("mail.smtp.socketFactory.fallback", "false");
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
} catch (Exception e) {
	e.printStackTrace();
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('오류가 발생했습니다.');");
	wr.println("history.back();");
	wr.println("</script>");
	wr.close();
	return;
}
PrintWriter wr = response.getWriter();
wr.println("<script>");
wr.println("alert('정상적으로 신고되었습니다.');");
wr.println("history.back();");
wr.println("</script>");
wr.close();
return;
%>