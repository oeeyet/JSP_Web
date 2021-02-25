package spms.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class CharacterEncodingFilter implements Filter {
	FilterConfig config;
	
	// init()메서드는 필터 객체가 생성되고 나서 준비 작업을 위해 딱 한번 호출
	//이 메서드의 매개변수는 FilterConfig객체이고 이 객체를 통해 필터 초기화 매개변수의 값을 꺼낼 수 있다.
	//
	@Override
	public void init(FilterConfig config) throws ServletException {
		this.config = config; //doFilter()에서 사용하기 위해 인스턴스 변수에 저장함.
		
	}
	//필터와 연결된URL에 대해 요청이 들어오면 dofilter()가 항상 호출 됨 이 메서드에 필터가 할일을 적으면 된다.
	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain nextFilter)
			throws IOException, ServletException {
		/* 서블릿이 실행되기 전에 해야 할 작업 */
		req.setCharacterEncoding(config.getInitParameter("encoding")); // 서블릿이 실행 되기 전에 메시지 바디의 문자 집합을 먼저 설정하기 위해 먼저 호출
		
		// 다음 필터를 호출. 더 이상 필터가 없다면 서블릿의 service()가 호출 됨.
		nextFilter.doFilter(req, resp);
		
		/* 서블릿을 실행한 후, 클라이언트에게 응답하기 전에 해야할 작업 */

	}
	@Override
	public void destroy() {	}
	
}
