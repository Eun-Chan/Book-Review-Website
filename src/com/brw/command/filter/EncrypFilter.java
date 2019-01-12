package com.brw.command.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import com.brw.command.filter.EncryptWrapper;

/**
 * Servlet Filter implementation class EncrypFilter
 */
@WebFilter({"/createUser.do", "/login.do" ,"/sign/checkedPassword.do", "/sign/updateUser.do"})
public class EncrypFilter implements Filter {

    /**
     * Default constructor. 
     */
    public EncrypFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//암호화래퍼객체 생성
		EncryptWrapper encRequest = new EncryptWrapper((HttpServletRequest)request);
		System.out.println("EncryptFilter처리 완료!");

		//ServletRequest타입의 파라미터에  작성한 EncrytWrapper객체 전달
		//ServletRequest - HttpServletRequest - HttpServletRequestWrapper - EncryptWrapper
		chain.doFilter(encRequest, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
