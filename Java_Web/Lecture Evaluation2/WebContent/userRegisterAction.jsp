<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
// 요청 받은 정보
request.setCharacterEncoding("UTF-8");
String userID = null;
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}
if (userID != null) {
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('로그인이 된 상태입니다..');");
	wr.println("location.href = 'index.jsp'");
	wr.println("</script>");
	wr.close();
	return;
}
String userPassword = null;
String userEmail = null;
if (request.getParameter("userID") != null) {
	userID = request.getParameter("userID");
}
if (request.getParameter("userPassword") != null) {
	userPassword = request.getParameter("userPassword");
}
if (request.getParameter("userEmail") != null) {
	userEmail = request.getParameter("userEmail");
}
if (userID == null || userPassword == null || userEmail == null) {
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('입력이 안 된 사항이 있습니다.');");
	wr.println("history.back();");
	wr.println("</script>");
	wr.close();
	return;
}
UserDAO userDAO = new UserDAO();
int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));
if (result == -1) {
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('이미 존재하는 아이디입니다.');");
	wr.println("history.back();");
	wr.println("</script>");
	wr.close();
	return;
} else {
	session.setAttribute("userID", userID);
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("location.href = 'emailSendAction.jsp'");
	wr.println("</script>");
	wr.close();
	return;
}
%>