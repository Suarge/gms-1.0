package gms.cuit.web.servlet.user;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import gms.cuit.entity.Gms_User;
import gms.cuit.service.user.UserService;
import gms.cuit.service.user.impl.UserServiceImpl;
import gms.cuit.utils.MD5Utils;
import gms.cuit.web.servlet.BaseServlet;

@WebServlet("/user")
public class UserServlet extends BaseServlet {
	
	UserService userservice = new UserServiceImpl();
	
	//修改密码
	public void updatePassword(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String username = ((Gms_User) session.getAttribute("user")).getUser_Id();
		String newpassword = request.getParameter("newpassword");
		userservice.update_password(username, MD5Utils.md5(newpassword));
		session.setAttribute("user", null);
		request.getRequestDispatcher("user/login.jsp").forward(request, response);
		
	}
	
	//用户注销
	public void logout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 获得session
		HttpSession session = request.getSession();
		session.removeAttribute("user");
		session.removeAttribute("orderlist");
		
		//将存储在客户端的cookie删除
		Cookie id_cookie = new Cookie("id_cookie","");
		id_cookie.setMaxAge(0);
		//创建存储密码的cookie
		Cookie password_cookie = new Cookie("password_cookie","");
		password_cookie.setMaxAge(0);

		response.addCookie(id_cookie);
		response.addCookie(password_cookie);
		
		response.sendRedirect(request.getContextPath()+"/user/GMS_index.jsp");
	}
	
	// 用户登录
	public void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 获得session
		HttpSession session = request.getSession();

		// 获取用户名和密码
		String id = request.getParameter("user_Id");
		String password = request.getParameter("user_Password");
		password = MD5Utils.md5(password);
		// 调用service方法
		Gms_User user = userservice.login(id, password);

		// 判断用户是否登录成功 user是否是null
		if (user != null) {
			// 用户登录成功
			// *************判断用户是否勾选了自动登录***************
			String autologin = request.getParameter("autoLogin");

			if ("on".equals(autologin)) {
				// 要自动登录，创建储存id的cookie
				Cookie id_cookie = new Cookie("id_cookie", user.getUser_Id());
				id_cookie.setMaxAge(10 * 60);

				// 创建密码的cookie
				Cookie password_cookie = new Cookie("password_cookie", user.getUser_Password());
				password_cookie.setMaxAge(10 * 60);

				response.addCookie(id_cookie);
				response.addCookie(password_cookie);
			}

			// 将用户名和密码存入session
			session.setAttribute("user", user);
			
			//登录成功后记录访问量
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        String currentDate = dateFormat.format( new java.util.Date());
	        Integer icount = (Integer) this.getServletContext().getAttribute(currentDate);
	        if(icount==null) icount = new Random().nextInt(78) + 10;;
	        icount++;
			this.getServletContext().setAttribute(currentDate,icount);
			
			response.sendRedirect(request.getContextPath() + "/user/GMS_index.jsp");
		} else {
			// 用户登录失败
			request.setAttribute("loginError", "用户名或密码错误");
			request.getRequestDispatcher("/user/login.jsp").forward(request, response);
		}
	}
	
	//校验学号/工号
	public void CheckUsername(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 获得用户名
		String userid = request.getParameter("user_Id");

		boolean isExist = userservice.checkUsername(userid);

		String json = "{\"isExist\":" + isExist + "}";

		response.getWriter().write(json);
	}
	// 用户注册
	public void register(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 获取页面所有参数
		Map<String, String[]> usermap = request.getParameterMap();

		Gms_User user = new Gms_User();
		try {
			BeanUtils.populate(user, usermap);
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}

		// 对密码加密
		String password = MD5Utils.md5(request.getParameter("user_Password"));
		user.setUser_Password(password);

		// 调用service层方法
		boolean isRegisterSuccess = userservice.register(user);

		// 判断是否注册成功
		if (isRegisterSuccess) {
			// 注册成功
			response.sendRedirect(request.getContextPath() + "/user/registerSuccess.jsp");
		} else {
			// 注册失败
			response.sendRedirect(request.getContextPath() + "/user/registerFail.jsp");
		}
	}

}