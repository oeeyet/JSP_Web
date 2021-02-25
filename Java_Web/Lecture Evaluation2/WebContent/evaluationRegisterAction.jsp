<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
// 요청 받은 정보
request.setCharacterEncoding("UTF-8");
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
String lectureName = null;
String professorName = null;
int lectureYear = 0;
String semesterDivide = null;
String lectureDivide = null;
String evaluationTitle = null;
String evaluationContent = null;
String totalScore = null;
String creditScore = null;
String comfortableScore = null;
String lectureScore = null;
if (request.getParameter("lectureName") != null) {
	lectureName = request.getParameter("lectureName");
	System.out.println("1");
}
if (request.getParameter("professorName") != null) {
	professorName = request.getParameter("professorName");
	System.out.println("2");
}
if (request.getParameter("lectureYear") != null) {
	try {
		lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
		System.out.println("3");
	} catch (Exception e) {
		System.out.println("강의 연도 데이터 오류");
	}
}
if (request.getParameter("semesterDivide") != null) {
	semesterDivide = request.getParameter("semesterDivide");
	System.out.println("4");
}
if (request.getParameter("lectureDivide") != null) {
	lectureDivide = request.getParameter("lectureDivide");
	System.out.println("5");
}
if (request.getParameter("evaluationTitle") != null) {
	evaluationTitle = request.getParameter("evaluationTitle");
	System.out.println("6");
}
if (request.getParameter("evaluationContent") != null) {
	evaluationContent = request.getParameter("evaluationContent");
	System.out.println("7");
}
if (request.getParameter("totalScore") != null) {
	totalScore = request.getParameter("totalScore");
	System.out.println("8");
}
if (request.getParameter("creditScore") != null) {
	creditScore = request.getParameter("creditScore");
	System.out.println("9");
}
if (request.getParameter("comfortableScore") != null) {
	comfortableScore = request.getParameter("comfortableScore");
	System.out.println("10");
}
if (request.getParameter("lectureScore") != null) {
	lectureScore = request.getParameter("lectureScore");
	System.out.println("11");
}
if (lectureName == null || professorName == null || lectureYear == 0 || semesterDivide == null || lectureDivide == null
		|| evaluationTitle == null || evaluationContent == null || totalScore == null || creditScore == null
		|| comfortableScore == null || lectureScore == null || evaluationContent.equals("")
		|| evaluationTitle.equals("")) {
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('입력이 안 된 사항이 있습니다.');");
	wr.println("history.back();");
	wr.println("</script>");
	wr.close();
	return;
}
EvaluationDAO evaluationDAO = new EvaluationDAO();
int result = evaluationDAO.write(new EvaluationDTO(0, userID, lectureName, professorName, lectureYear, semesterDivide, lectureDivide,
		evaluationTitle, evaluationContent, totalScore, creditScore, comfortableScore, lectureScore, 0));
if (result == -1) {
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("alert('강의 평가 등록 실패했습니다.');");
	wr.println("history.back();");
	wr.println("</script>");
	wr.close();
	return;
} else {
	session.setAttribute("userID", userID);
	PrintWriter wr = response.getWriter();
	wr.println("<script>");
	wr.println("location.href = 'index.jsp'");
	wr.println("</script>");
	wr.close();
	return;
}
%>