package spms.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/add")
public class MamberAddServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		out.println("<html><head><title>회원목록</title></head>");
		out.println("<body><h1>회원목록</h1>");
		out.println("<form action='add' method='post'>");
		out.println("이름: <input type='text' name='name'><br>");
		out.println("이메일: <input type='text' name='email'><br>");
		out.println("암호: <input type='password' name='password'><br>");
		out.println("<input type='submit' value='추가'>");
		out.println("<input type='reset' value='취소'>");
		out.println("</form>");
		out.println("</body></html>");
//		super.doGet(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		CharacterEncodingFilter에서 처리
		//		req.setCharacterEncoding("UTF-8");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			ServletContext sc = this.getServletContext();
			Class.forName(sc.getInitParameter("driver"));
			conn = DriverManager.getConnection(
					sc.getInitParameter("url"),
					sc.getInitParameter("username"),
					sc.getInitParameter("password"));
					
//			DriverManager.deregisterDriver(new com.mysql.jdbc.Driver());
//					conn = DriverManager.getConnection(
//							"jdbc:mysql://localhost/studydb",	//url (IP address)
//							"study",	//사용자 아이디
//							"study"); 	// 사용자 비밀번호
					
					
					
					stmt = conn.prepareStatement(
							"insert into members(email,pwd,mname,cre_date,mod_date)" + " values (?,?,?,now(),now())");
					stmt.setString(1, req.getParameter("email"));
					stmt.setString(2, req.getParameter("password"));
					stmt.setString(3, req.getParameter("name"));
					stmt.executeUpdate();
					
					resp.sendRedirect("list");
					
//					리다이렉트는 HTML을 출력하지 않는다.
//					resp.setContentType("text/html; charset=UTF-8");
//					PrintWriter out = resp.getWriter();
//					out.println("<html><head><title>회원등록결과</title></head>");
//					out.println("<meta http-equiv='Refresh' content='1; url=list'>");
//					out.println("<body>");
//					out.println("<p>등록 성공입니다!</p>");
//					out.println("</body></p>");
//					
//					// 응답 헤더를 이용한 리프래시정보 보내기(리프래시 정보를 헤더에 추가)
////					resp.addHeader("Refresh", "1;url=list"); 	// HttpServletResponse의 addHeader()는 HTTP 응답 정보에 헤더를 추가하는 메서드
//					
//		
		} catch (Exception e) {
			throw new ServletException(e);
			
		}
		finally {
			try {if (stmt != null) stmt.close();} catch(Exception e) {}
			try {if (stmt != null) conn.close();} catch(Exception e) {}
			
		}
		
		
		
		
		
//		super.doPost(req, resp);
	}
}


	

