<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="user.UserDAO"%>
<%@page import="evaluation.EvaluationDAO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%!public static String getCilentIP(HttpServletRequest request) {
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("WL-Porxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getRemoteAddr();

		}
		return ip;

	}%>

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
int evaluationID = 0;
if (request.getParameter("evaluationID") != null) {
	evaluationID = Integer.parseInt(request.getParameter("evaluationID"));
}
EvaluationDAO evaluationDAO = new EvaluationDAO();
LikeyDAO likeyDAO = new LikeyDAO();
int result = likeyDAO.like(userID, evaluationID, getCilentIP(request));
System.out.println(result);
	if (result == 1) {
		result = evaluationDAO.like(Integer.toString(evaluationID));
		if(result == 1) {
			PrintWriter wr = response.getWriter();
			wr.println("<script>");
			wr.println("alert('추천이 완료되었습니다.');");
			wr.println("location.href = 'index.jsp'");
			wr.println("</script>");
			wr.close();
			return;
		} else {
			PrintWriter wr = response.getWriter();
			wr.println("<script>");
			wr.println("alert('데이터베이스 오류가 발생했습니다.');");
			wr.println("history.back()");
			wr.println("</script>");
			wr.close();
			return;
			
		}
	} else {
		PrintWriter wr = response.getWriter();
		wr.println("<script>");
		wr.println("alert('이미 추천을 누른 글입니다.');");
		wr.println("history.back()");
		wr.println("</script>");
		wr.close();
		return;
		
	}


%>