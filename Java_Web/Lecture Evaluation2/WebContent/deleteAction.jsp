<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="user.UserDAO"%>
<%@page import="evaluation.EvaluationDAO"%>
<%@ page import="likey.LikeyDTO"%>
<%@ page import="java.io.PrintWriter"%>

<%

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
String evaluationID = null;
if (request.getParameter("evaluationID") != null) {
	evaluationID = request.getParameter("evaluationID");
}
EvaluationDAO evaluationDAO = new EvaluationDAO();
if(userID.equals(evaluationDAO.getUserID(evaluationID))) {
	int result = new EvaluationDAO().delete(evaluationID);
	if (result == 1) {
		PrintWriter wr = response.getWriter();
		wr.println("<script>");
		wr.println("alert('삭제가 완료되었습니다.');");
		wr.println("location.href = 'index.jsp'");
		wr.println("</script>");
		wr.close();
		return;
	} else {
		PrintWriter wr = response.getWriter();
		wr.println("<script>");
		wr.println("alert('자신이 쓴 글만 삭제 가능합니다.');");
		wr.println("history.back()");
		wr.println("</script>");
		wr.close();
		return;
	}
}

%>