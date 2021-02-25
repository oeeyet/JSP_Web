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
String userPassword = null;
if (request.getParameter("userID") != null) {
	userID = request.getParameter("userID");
}
if (request.getParameter("userPassword") != null) {
	userPassword = request.getParameter("userPassword");
}
if (userID == null || userPassword == null) {
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('입력이 안 된 사항이 있습니다.');");
	wr.println("history.back();");
	wr.println("</script>");
	wr.close();
	return;
}
UserDAO userDAO = new UserDAO();
int result = userDAO.login(userID, userPassword);
if (result == 1) {
	session.setAttribute("userID", userID);
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("location.href = 'index.jsp'");
	wr.println("</script>");
	wr.close();
	return;
} else if (result == 0) {
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('비밀번호가 틀립니다.');");
	wr.println("history.back();");
	wr.println("</script>");
	wr.close();
	return;
} else if (result == -1) {
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('존재하지 않는 아이디입니다.');");
	wr.println("history.back();");
	wr.println("</script>");
	wr.close();
	return;
} else if (result == -2) {
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('데이터베이스 오류가 발생했습니다.');");
	wr.println("history.back();");
	wr.println("</script>");
	wr.close();
	return;
}
%>