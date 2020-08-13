package gms.cuit.web.filter.user;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import gms.cuit.entity.Gms_User;

public class UserLoginPrivilegeFilter implements Filter{

	//用户是否登录权限控制过滤器
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		// 校验用户是否登录---校验sesssion是否存在user对象
		HttpSession session = req.getSession();
		Gms_User user = (Gms_User) session.getAttribute("user");
		if (user == null) {
			// 没有登录
			resp.sendRedirect(req.getContextPath() + "/user/login.jsp");
			return;
		}
		
		chain.doFilter(req, resp);
	}
	
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
