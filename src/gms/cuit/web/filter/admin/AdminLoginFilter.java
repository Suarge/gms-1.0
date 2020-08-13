package gms.cuit.web.filter.admin;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gms.cuit.entity.Gms_Admin;

/**
 * Servlet Filter implementation class AdminLoginFilter
 */

public class AdminLoginFilter implements Filter {

	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String method = request.getParameter("method");
        String path = request.getRequestURI();
        //进行登录就放行
        if("login".equals(method) || path.contains("login")) {
        	chain.doFilter(request, response);
        }
        else {
        	Gms_Admin admin = (Gms_Admin) request.getSession().getAttribute("admin");
        	if(admin==null) {
        		response.sendRedirect(request.getContextPath()+"/admin/bck_login.jsp");
        	}
        	else {
        		chain.doFilter(request, response);
        	}
        }
        
		
	}

	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}


}
