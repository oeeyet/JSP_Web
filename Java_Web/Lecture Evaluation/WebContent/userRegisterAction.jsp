<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>



<%
	//요청받은 정보
request.setCharacterEncoding("UTF-8");
String userID = null;
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}

if(userID != null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 된 상태입니다..');");
	script.println("location.href = 'index.jsp'");
	script.println("</script>");
	script.close();
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
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('입력이 안 된 사항이 있습니다.');");
	script.println("histroy.back();");
	script.println("</script>");
	script.close();
	return;

}
EvaluationDAO userDAO = new EvaluationDAO();
int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));
if (result == -1) { //로그인이 실패(이미 존재하는 아이디)

	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 존재하는 아이디 입니다.');");
	script.println("histroy.back();");
	script.println("</script>");
	script.close();
	return;
} else { //회원가입후 이메일 인증 후 로그인된
	session.setAttribute("userID", userID);
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href = 'emailSendAction.jsp'");
	script.println("</script>");
	script.close();
	return;
}
%>
