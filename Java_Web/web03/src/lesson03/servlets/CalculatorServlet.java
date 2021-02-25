package lesson03.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;

/*
 * url에 대하여 처리할 서블릿을 설정하는 방법 : annotation 방법
 * 주의사항 : 중복을 피하고, url 체계를 가져가도록 전체적으로 설계가 필요
 * 여러개의 url을 사용하는 경우 ->
 * Client가 PC가 휴대폰인지를 구별할 필요가 있을 경우 : PC(브라우저), 휴대폰(HttpClient:native Android UI -> HTML/CSS/Javascript)
 */
@WebServlet(urlPatterns = {"/calc", "/calc.do", "/calculator.action"})
public class CalculatorServlet extends GenericServlet {
	private static final long serialVersionUID = 1L;

	@Override
	public void service(ServletRequest request, ServletResponse response)
			throws ServletException, IOException {
		int a = Integer.parseInt( request.getParameter("a") );
		int b = Integer.parseInt( request.getParameter("b") );

		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println("a=" + a + "," + "b=" + b + "의 계산결과 입니다.");
		writer.println("a + b = " + (a + b));
		writer.println("a - b = " + (a - b));
		writer.println("a * b = " + (a * b));
		writer.println("a / b = " + ((float)a / (float)b));
		writer.println("a % b = " + (a % b));
	}
}
