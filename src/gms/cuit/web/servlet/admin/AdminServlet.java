package gms.cuit.web.servlet.admin;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.User;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.Converter;
import org.apache.naming.java.javaURLContextFactory;

import com.mysql.jdbc.Util;
import com.sun.org.apache.bcel.internal.generic.NEW;

import gms.cuit.entity.Gms_Admin;
import gms.cuit.entity.Gms_Bck_analytics;
import gms.cuit.entity.Gms_Notice;
import gms.cuit.entity.Gms_Order;
import gms.cuit.entity.Gms_User;
import gms.cuit.entity.Gms_Venue;
import gms.cuit.entity.PageBean;
import gms.cuit.service.admin.AdminService;
import gms.cuit.service.admin.impl.AdminServiceImpl;
import gms.cuit.utils.CommonUtils;
import gms.cuit.utils.DataSourceUtils;
import gms.cuit.utils.ExportExcelUtils;
import gms.cuit.utils.MD5Utils;
import gms.cuit.web.servlet.BaseServlet;

/**
 * Servlet implementation class AdminServlet
 */
@WebServlet("/admin")
public class AdminServlet extends BaseServlet {
	
	AdminService adminService = new AdminServiceImpl();
	
	public void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		HttpSession session = request.getSession();
		Gms_Admin admin = new Gms_Admin();
		admin.setAdmin_Username(request.getParameter("username"));
		admin.setAdmin_Password(MD5Utils.md5(request.getParameter("password")));
		admin = adminService.login(admin); 
		
		if(admin==null) {
			request.setAttribute("error", "用户名或密码错误");
			request.getRequestDispatcher("admin/bck_login.jsp").forward(request, response);
		}
		else {
			session.setAttribute("admin", admin);
			response.sendRedirect(request.getContextPath()+"/admin/bck_index.jsp");
		}
	}
	
	public void logout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		
		HttpSession session = request.getSession();
		session.setAttribute("admin", null);
		String json = "{}";
		response.getWriter().write(json);
	}
	
	public void update_password(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		HttpSession session = request.getSession();
		String username = ((Gms_Admin) session.getAttribute("admin")).getAdmin_Username();
		String newpassword = request.getParameter("newpassword");
		adminService.update_password(username, MD5Utils.md5(newpassword));
		session.setAttribute("admin", null);
		request.getRequestDispatcher("admin/bck_login.jsp").forward(request, response);
	}
	
	public void add_notice(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		Map<String, String[]> properties = request.getParameterMap();
		Gms_Notice notice = new Gms_Notice();
		try {
			ConvertUtils.register(new Converter() {
				public Object convert(Class arg0, Object arg1) {
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					Date parse = null;
					try {
						parse = new Date(( format.parse(arg1.toString())).getTime());
					} catch (ParseException e) {
						e.printStackTrace();
					}
					return parse;
				}
			}, Date.class);
			BeanUtils.populate(notice, properties);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		notice.setNotice_Id(CommonUtils.getUUID());
		adminService.add_notice(notice);
		String json = "{}";
		response.getWriter().write(json);
	}
	
	public void del_notice(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String notice_id = request.getParameter("del_notice_id");
		adminService.del_notice(notice_id);
		String json = "{}";
		response.getWriter().write(json);
	}
	
	public void update_notice(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		Map<String, String[]> properties = request.getParameterMap();
		Gms_Notice notice = new Gms_Notice();
		try {
			ConvertUtils.register(new Converter() {
				public Object convert(Class arg0, Object arg1) {
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					Date parse = null;
					try {
						parse = new Date(( format.parse(arg1.toString())).getTime());
					} catch (ParseException e) {
						e.printStackTrace();
					}
					return parse;
				}
			}, Date.class);
			BeanUtils.populate(notice, properties);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		adminService.update_notice(notice);
		String json = "{}";
		response.getWriter().write(json);
	}
	
	public void query_notice(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		int currentPage = 1;
		int currentCount = 5;
		String currentPageStr = request.getParameter("currentPage");
		String currentCountStr = request.getParameter("currentCount");
		if(currentPageStr!=null&&currentPageStr.trim().equals("")==false) currentPage = Integer.parseInt(currentPageStr);
		if(currentCountStr!=null&&currentCountStr.trim().equals("")==false) currentCount = Integer.parseInt(currentCountStr); 
		String query_key = request.getParameter("query_key");
		if(query_key==null) query_key="";
		PageBean<Gms_Notice> pageBean_notice =  adminService.query_noticeByKey(currentPage, currentCount, query_key);
		request.setAttribute("pageBean_notice", pageBean_notice);
		request.setAttribute("query_key", query_key);
		request.getRequestDispatcher("admin/bck_notice.jsp").forward(request, response);
	}
	
	public void export_notice(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
			Map<String, String> title = new HashMap(); // 表头
	        List<Map<String, Object>> data = new ArrayList(); // 需要导出的数据
	        Map<String, Integer> position = new HashMap(); // 表头字段对应的位置（自定义位置）
	        	
	        List<Gms_Notice> nList = adminService.query_noticeAll();
	        
			// 设置表头字段位置
	        position.put("notice_Man", 0);
	        position.put("notice_Title", 1);
	        position.put("notice_Content", 2);
	        position.put("notice_Time", 3);
	 
	        // 设置表头信息
	        title.put("notice_Man", "通知人");
	        title.put("notice_Title", "通知标题");
	        title.put("notice_Content", "通知内容");
	        title.put("notice_Time", "通知日期");
	 
	        Map<String, Object> noticeMap = null;
	        
	        for (Gms_Notice notice : nList) {
	        	noticeMap = new HashMap();
	        	noticeMap.put("notice_Man", notice.getNotice_Man());
	        	noticeMap.put("notice_Title", notice.getNotice_Title());
	        	noticeMap.put("notice_Content", notice.getNotice_Content());
	        	noticeMap.put("notice_Time", notice.getNotice_Time());
	            data.add(noticeMap);     // 将userMap添加到List集合中
	        }
	        DateFormat df = new SimpleDateFormat("yyyy-MM-dd_HH_mm_ss");
	        String date = df.format(new java.util.Date());
	        String excelName = "通知清单-" + date + ".xlsx";
	        String sheetName = "通知清单数据";
	        excelName = URLEncoder.encode(excelName, "UTF-8");
	        response.setCharacterEncoding("UTF-8");
	        response.addHeader("Content-Disposition", "attachment;filename=" + excelName);
	        response.setContentType("application/x-download");
	        // 调用写好的工具类的导出数据方法   传入对应的参数
	        ExportExcelUtils.exportDataToExcel(title, position, data, sheetName, response.getOutputStream());
	}
	
	public void add_venue(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		Map<String, String[]> properties = request.getParameterMap();
		Gms_Venue venue = new Gms_Venue();
		try {
			BeanUtils.populate(venue, properties);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		venue.setVenue_Id(CommonUtils.getUUID());
		adminService.add_venue(venue);
		String json = "{}";
		response.getWriter().write(json);
	}
	
	public void del_venue(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String venue_id = request.getParameter("del_venue_id");
		adminService.del_venue(venue_id);
		String json = "{}";
		response.getWriter().write(json);
	}
	
	public void update_venue(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		Map<String, String[]> properties = request.getParameterMap();
		Gms_Venue venue = new Gms_Venue();
		try {
			BeanUtils.populate(venue, properties);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		adminService.update_venue(venue);
		String json = "{}";
		response.getWriter().write(json);
	}
	
	public void query_venue(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		int currentPage = 1;
		int currentCount = 5;
		String currentPageStr = request.getParameter("currentPage");
		String currentCountStr = request.getParameter("currentCount");
		if(currentPageStr!=null&&currentPageStr.trim().equals("")==false) currentPage = Integer.parseInt(currentPageStr);
		if(currentCountStr!=null&&currentCountStr.trim().equals("")==false) currentCount = Integer.parseInt(currentCountStr); 
		String query_key = request.getParameter("query_key");
		if(query_key==null) query_key="";
		PageBean<Gms_Venue> pageBean_venue = adminService.query_venueByKey(currentPage, currentCount, query_key);
		request.setAttribute("pageBean_venue", pageBean_venue);
		request.setAttribute("query_key", query_key);
		request.getRequestDispatcher("admin/bck_venue.jsp").forward(request, response);
	}
	
	public void export_venue(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
			Map<String, String> title = new HashMap(); // 表头
	        List<Map<String, Object>> data = new ArrayList(); // 需要导出的数据
	        Map<String, Integer> position = new HashMap(); // 表头字段对应的位置（自定义位置）
	        List<Gms_Venue> vList = adminService.query_venueAll();
	        
			// 设置表头字段位置
	        position.put("venue_Name", 0);
	        position.put("venue_Type", 1);
	        position.put("venue_Capacity", 2);
	        position.put("venue_Price", 3);
	        position.put("venue_Open", 4);
	        position.put("venue_Close", 5);
	 
	        // 设置表头信息
	        title.put("venue_Name", "场馆名字");
	        title.put("venue_Type", "场馆类别");
	        title.put("venue_Capacity", "接待能力");
	        title.put("venue_Price", "场馆价格");
	        title.put("venue_Open", "开放时间");
	        title.put("venue_Close", "关闭时间");
	 
	        Map<String, Object> venueMap = null;
	        
	        for (Gms_Venue venue : vList) {
	        	venueMap = new HashMap();
	        	venueMap.put("venue_Name", venue.getVenue_Name());
	        	venueMap.put("venue_Type", venue.getVenue_Type());
	        	venueMap.put("venue_Capacity", venue.getVenue_Capacity());
	        	venueMap.put("venue_Price", venue.getVenue_Price().toString());
	        	venueMap.put("venue_Open", venue.getVenue_Open()+":00");
	        	venueMap.put("venue_Close", venue.getVenue_Close()+":00");
	            data.add(venueMap);     // 将userMap添加到List集合中
	        }
	        DateFormat df = new SimpleDateFormat("yyyy-MM-dd_HH_mm_ss");
	        String date = df.format(new java.util.Date());
	        String excelName = "场地列表-" + date + ".xlsx";
	        String sheetName = "场地列表数据";
	        excelName = URLEncoder.encode(excelName, "UTF-8");
	        response.setCharacterEncoding("UTF-8");
	        response.addHeader("Content-Disposition", "attachment;filename=" + excelName);
	        response.setContentType("application/x-download");
	        // 调用写好的工具类的导出数据方法   传入对应的参数
	        ExportExcelUtils.exportDataToExcel(title, position, data, sheetName, response.getOutputStream());
	}
	
	public void query_order(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		//分页预处理
		int currentPage = 1;
		int currentCount = 5;
		String currentPageStr = request.getParameter("currentPage");
		String currentCountStr = request.getParameter("currentCount");
		if(currentPageStr!=null&&currentPageStr.trim().equals("")==false) currentPage = Integer.parseInt(currentPageStr);
		if(currentCountStr!=null&&currentCountStr.trim().equals("")==false) currentCount = Integer.parseInt(currentCountStr); 
		String query_key = request.getParameter("query_key");
		if(query_key==null) query_key="";
		//分页数据处理
		PageBean<Gms_Order> pageBean_order = new PageBean<Gms_Order>();
		pageBean_order.setCurrentPage(currentPage);
		pageBean_order.setCurrentCount(currentCount);
		int totalCount = adminService.get_orderTotalCountByKeyQuery(query_key);
		pageBean_order.setTotalCount(totalCount);
		int totalPage = (int) Math.ceil(1.0*totalCount/currentCount);
		pageBean_order.setTotalPage(totalPage);
		int index = (currentPage-1)*currentCount;
		String sort_state = request.getParameter("sort_state");
		if(sort_state==null) sort_state="7";
		List<Map<String, Object>> mapList = adminService.query_orderByKey(index, currentCount, query_key, sort_state);
		//查询回来的数据进行再次处理
		List<Gms_Order> orderlist = new ArrayList<Gms_Order>();
		try {
			for(Map<String, Object> mp : mapList) {
				Gms_Order orderitem = new Gms_Order();
				Gms_Venue venueitem = new Gms_Venue();
				Gms_User useritem = new Gms_User();
				BeanUtils.populate(orderitem, mp);
				BeanUtils.populate(venueitem, mp);
				BeanUtils.populate(useritem, mp);
				orderitem.setOrder_VenueId(venueitem);
				orderitem.setOrder_UserId(useritem);
				orderlist.add(orderitem);		
			}
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		pageBean_order.setList(orderlist);
		request.setAttribute("pageBean_order", pageBean_order);
		request.setAttribute("query_key", query_key);
		request.setAttribute("sort_state", sort_state);
		request.getRequestDispatcher("admin/bck_order.jsp").forward(request, response);
	}
	
	public void export_order(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
			Map<String, String> title = new HashMap(); // 表头
	        List<Map<String, Object>> data = new ArrayList(); // 需要导出的数据
	        Map<String, Integer> position = new HashMap(); // 表头字段对应的位置（自定义位置）
	        	
	        List<Map<String, Object>> mapList = adminService.query_orderAll();
			//查询回来的数据进行再次处理
			List<Gms_Order> orderlist = new ArrayList<Gms_Order>();
			try {
				for(Map<String, Object> mp : mapList) {
					Gms_Order orderitem = new Gms_Order();
					Gms_Venue venueitem = new Gms_Venue();
					Gms_User useritem = new Gms_User();
					BeanUtils.populate(orderitem, mp);
					BeanUtils.populate(venueitem, mp);
					BeanUtils.populate(useritem, mp);
					orderitem.setOrder_VenueId(venueitem);
					orderitem.setOrder_UserId(useritem);
					orderlist.add(orderitem);		
				}
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
	        
			// 设置表头字段位置
	        position.put("Venue_Name", 0);
	        position.put("Venue_Type", 1);
	        position.put("User_Id", 2);
	        position.put("Order_Date", 3);
	        position.put("Order_St", 4);
	        position.put("Order_Ed", 5);
	        position.put("Order_Price", 6);
	        position.put("Order_Mktime", 7);
	        position.put("Order_Sate", 8);
	 
	        // 设置表头信息
	        title.put("Venue_Name", "预约场地");
	        title.put("Venue_Type", "场地类别");
	        title.put("User_Id", "预约人");
	        title.put("Order_Date", "预约日期");
	        title.put("Order_St", "开始时间");
	        title.put("Order_Ed", "结束时间");
	        title.put("Order_Price", "预约价格");
	        title.put("Order_Mktime", "预约生成时间");
	        title.put("Order_Sate", "预约状态");
	 
	        Map<String, Object> orderMap = null;
	        
	        for (Gms_Order order : orderlist) {
	        	orderMap = new HashMap();
	        	orderMap.put("Venue_Name", order.getOrder_VenueId().getVenue_Name());
	        	orderMap.put("Venue_Type", order.getOrder_VenueId().getVenue_Type());
	        	orderMap.put("User_Id", order.getOrder_UserId().getUser_Id());
	        	orderMap.put("Order_Date", order.getOrder_Date());
	        	orderMap.put("Order_St", order.getOrder_St()+":00");
	        	orderMap.put("Order_Ed", order.getOrder_Ed()+":00");
	        	orderMap.put("Order_Price", order.getOrder_Price());
	        	orderMap.put("Order_Mktime", order.getOrder_Mktime2());
	        	String Order_Sate = "";
	        	if(order.getOrder_State()==0) Order_Sate="进行中";
	        	else if(order.getOrder_State()==1) Order_Sate="已取消";
	        	else if(order.getOrder_State()==2) Order_Sate="已成功";
	        	orderMap.put("Order_Sate", Order_Sate);
	            data.add(orderMap);     // 将userMap添加到List集合中
	        }
	        DateFormat df = new SimpleDateFormat("yyyy-MM-dd_HH_mm_ss");
	        String date = df.format(new java.util.Date());
	        String excelName = "订单列表-" + date + ".xlsx";
	        String sheetName = "订单列表数据";
	        excelName = URLEncoder.encode(excelName, "UTF-8");
	        response.setCharacterEncoding("UTF-8");
	        response.addHeader("Content-Disposition", "attachment;filename=" + excelName);
	        response.setContentType("application/x-download");
	        // 调用写好的工具类的导出数据方法   传入对应的参数
	        ExportExcelUtils.exportDataToExcel(title, position, data, sheetName, response.getOutputStream());
	}
	
	public void analytics_all(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		List<Gms_Bck_analytics> analyticslist = null;
		//日期处理
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
		String currentdateString = formatter.format(new java.util.Date());
		String date_st = request.getParameter("date_st");
		if(date_st==null||date_st.trim().equals("")) date_st=currentdateString+" 10:00";
		String date_ed = request.getParameter("date_ed");
		if(date_ed==null||date_ed.trim().equals("")) date_ed=currentdateString+" 22:00";
		String category = request.getParameter("category");
		if("venue".equals(category)) analyticslist = adminService.analytics_allByDateAndVen(date_st, date_ed);
		else analyticslist = adminService.analytics_allByDateAndCat(date_st, date_ed);
		request.setAttribute("date_st", date_st);
		request.setAttribute("date_ed", date_ed);
		request.setAttribute("category", category);
		request.setAttribute("analyticslist", analyticslist);
		request.getRequestDispatcher("admin/bck_analytics.jsp").forward(request, response);
	}
	
	public void summary_all(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String currentDate = dateFormat.format( new java.util.Date());
        int get_count = 5;
		Integer summaryTodayOrderCount = adminService.get_summaryTodayOrderCount(currentDate);
		Double summaryTodayOrderProfit = adminService.get_summaryTodayOrderProfit(currentDate);
		//获取近期订单
		List<Map<String, Object>> mapList = adminService.query_orderByLatest(get_count);
		List<Gms_Order> latest_orderlist = new ArrayList<Gms_Order>();
		try {
			for(Map<String, Object> mp : mapList) {
				Gms_Order orderitem = new Gms_Order();
				Gms_Venue venueitem = new Gms_Venue();
				Gms_User useritem = new Gms_User();
				BeanUtils.populate(orderitem, mp);
				BeanUtils.populate(venueitem, mp);
				BeanUtils.populate(useritem, mp);
				orderitem.setOrder_VenueId(venueitem);
				orderitem.setOrder_UserId(useritem);
				latest_orderlist.add(orderitem);		
			}
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		
		//获取订单分布
		String summary_orderCountByDateAndVen_val = adminService.get_orderCountByDate(currentDate);
		//获取近期的访问量日期
		String summary_venueVisCountByDate_ti = "";
		String summary_venueVisCountByDate_val = "";
		String summaryTodayVistors = "";
		SimpleDateFormat sdf=new SimpleDateFormat("MM-dd");
		for(int i=-6;i<=0;i++) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(new java.util.Date());
			calendar.add(Calendar.DAY_OF_MONTH, i);
//			System.out.println(sdf.format(calendar.getTime()));
			summary_venueVisCountByDate_ti += sdf.format(calendar.getTime());//日期拼接
			Integer vvInteger = (Integer) this.getServletContext().getAttribute(dateFormat.format(calendar.getTime()));
			if(vvInteger==null) vvInteger= (new Random().nextInt(80)) + 10;//随机访问量
			this.getServletContext().setAttribute(dateFormat.format(calendar.getTime()), vvInteger);
			summary_venueVisCountByDate_val += vvInteger.toString();
			if(i!=0) {
				summary_venueVisCountByDate_ti += " ";
				summary_venueVisCountByDate_val += " ";
			}
			if(i==0) summaryTodayVistors = vvInteger.toString();
		}
		
		request.setAttribute("summary_orderCountByDateAndVen_val",summary_orderCountByDateAndVen_val);
		request.setAttribute("summary_venueVisCountByDate_ti",summary_venueVisCountByDate_ti);
		request.setAttribute("summary_venueVisCountByDate_val",summary_venueVisCountByDate_val);
		request.setAttribute("latest_orderlist", latest_orderlist);
		request.setAttribute("summaryTodayOrderCount", summaryTodayOrderCount);
		request.setAttribute("summaryTodayOrderProfit", summaryTodayOrderProfit);
		request.setAttribute("summaryTodayVistors", summaryTodayVistors);
		request.getRequestDispatcher("admin/bck_summary.jsp").forward(request, response);
	}
}
