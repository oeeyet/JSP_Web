package spms.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.GenericServlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * 브라우저에서 회원정보 목록을 요구하는 url : /member/list
 */

@WebServlet("/member/list")
public class MemberListServlet extends HttpServlet {

	@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	/*
	 * 데이터베이스 접속 순서
	 * 1. JDBC 드라이버를 로딩
	 * 2. Connection 설정
	 * 3. Statment, PrepareStatment 획득
	 * 4. executeQuery(select : 데이터베이스에서 데이터를 검색 -> 검색결과(ResultSet),
	 *  	executeUpdate(update, insert, delete 수행 - 데이터베이스를 변경 -> 변경되는 투플
	 *  5.검색 : ResultSet에서 데이터를 꺼내온다.
	 */

		Connection conn = null;
		Statement stmt = null;	// 검색할 때
		ResultSet rs = null;		// 검색할 때만 사용
		
		try {
			// 컨텍스트 초기화 변수
			ServletContext sc = this.getServletContext();
			
			// 설정한 드라이버 구현체 등록
			Class.forName(sc.getInitParameter("driver"));
			
			//MySQL 서버에 연결
			// - 연결 성공시 Connection 객체 반환
			conn = DriverManager.getConnection(
					sc.getInitParameter("url"),
					sc.getInitParameter("username"),
					sc.getInitParameter("password"));

			// SQL 문을 실행할 객체
			stmt = conn.createStatement();
//			String query = ("select mno, mname, email, cre_date from members order by mno asc");
			// 3번 절차
			
			// 4번 절차
//			rs = stmt.executeQuery(query);	// 검색 결과가 rs에 저장된다.membersorder
			
			// SQL문을 서버에 보냄
			rs = stmt.executeQuery("select mno,mname,email,cre_date from members" + " order by mno asc");
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<html><head><title>회원목록</title></head>");
			out.println("<body><h1>회원목록</h1>");
			out.println("<p><a href='add'>신규 회원</a></p>");
			while(rs.next()) {
				out.println(
						// 방법 1 : rs.getInt("mno") 방법 2 : rs.getInt(1) columnindex사용
						rs.getInt("mno") + "," + 
								"<a href='update?no=" + rs.getInt("mno") + "'>" + 
						rs.getString("mname")
								+ "</a>," + rs.getString("email") + "," +
						rs.getDate("cre_date") + 
						"<a href='delete?no=" + rs.getInt("mno") + "'> [삭제] </a>" + " <br>");
			}
			out.println("</body></html>");
			} catch (Exception e) {
				throw new ServletException(e);
			}finally {
				try { if (rs != null) rs.close();} catch(Exception e) {}
				try { if (stmt != null) rs.close();} catch(Exception e) {}
				try { if (conn != null) rs.close();} catch(Exception e) {}
				
			}
		
	}

}
