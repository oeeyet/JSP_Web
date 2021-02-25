<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	// 요청 받은 정보
request.setCharacterEncoding("UTF-8");
String code = null;
if (request.getParameter("code") != null) {
	code = request.getParameter("code");
}
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
String userEmail = userDAO.getUserEmail(userID);
boolean isRight = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false;
if (isRight == true) {
	userDAO.setUserEmailChecked(userID);
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('인증에 성공했습니다.');");
	wr.println("location.href = 'index.jsp'");
	wr.println("</script>");
	wr.close();
	return;
} else {
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('유효하지 않은 코드입니다.');");
	wr.println("location.href = 'index.jsp'");
	wr.println("</script>");
	wr.close();
	return;
}
%>