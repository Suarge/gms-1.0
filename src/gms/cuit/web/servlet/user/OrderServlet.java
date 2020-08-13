package gms.cuit.web.servlet.user;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.alibaba.fastjson.JSON;

import gms.cuit.entity.Gms_Notice;
import gms.cuit.entity.Gms_Order;
import gms.cuit.entity.Gms_Type;
import gms.cuit.entity.Gms_User;
import gms.cuit.entity.Gms_Vdstate;
import gms.cuit.entity.Gms_Venue;
import gms.cuit.entity.PageBean;
import gms.cuit.service.user.OrderServcie;
import gms.cuit.service.user.impl.OrderServcieImpl;
import gms.cuit.utils.CommonUtils;
import gms.cuit.utils.ExportExcelUtils;
import gms.cuit.web.servlet.BaseServlet;

@WebServlet("/order")
public class OrderServlet extends BaseServlet {
	
	OrderServcie service = new OrderServcieImpl();
	
	//导出数据
	public void export_order(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Map<String, String> title = new HashMap(); // 表头
        List<Map<String, Object>> data = new ArrayList(); // 需要导出的数据
        Map<String, Integer> position = new HashMap(); // 表头字段对应的位置（自定义位置）
        
		//获取当前对象的id
		HttpSession session = request.getSession();
		Gms_User user = (Gms_User) session.getAttribute("user");
		String user_Id = user.getUser_Id();
        
        List<Map<String, Object>> mapList = service.query_orderAll(user_Id);
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
        position.put("Order_Date", 2);
        position.put("Order_St", 3);
        position.put("Order_Ed", 4);
        position.put("Order_Price", 5);
        position.put("Order_Mktime", 6);
        position.put("Order_Sate", 7);
 
        // 设置表头信息
        title.put("Venue_Name", "预约场地");
        title.put("Venue_Type", "场地类别");
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
        	orderMap.put("Order_Date", order.getOrder_Date());
        	orderMap.put("Order_St", order.getOrder_St()+":00");
        	orderMap.put("Order_Ed", order.getOrder_Ed()+":00");
        	orderMap.put("Order_Price", order.getOrder_Price());
        	orderMap.put("Order_Mktime", order.getOrder_Mktime2());
        	String Order_Sate = "";
        	if(order.getOrder_State()==0) Order_Sate="进行中";
        	else if(order.getOrder_State()==1) Order_Sate="已取消";
        	else if(order.getOrder_State()==2) Order_Sate="已完成";
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
	
	//取消订单
	public void delOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String orderid = request.getParameter("orderId");//订单号
		String venueid = request.getParameter("venueId");//订单场馆id
//		System.out.println(venueid);
		String orderdate = request.getParameter("orderDate");//订单日期
		String st = request.getParameter("orderSt");//分时状态第一个
		service.delOrderById(orderid);//订单改变状态
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");  
        java.util.Date d = null;  
        try {  
            d = format.parse(orderdate);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        java.sql.Date date = new java.sql.Date(d.getTime()); 
		
		Gms_Vdstate vdstate = service.findVdstateById(venueid,date);
		
		//获得开始时间order_St
		//******************改变分时状态为已预约**********************
		int order_st = Integer.parseInt(st);
		//获得分时状态
		String vdstate_st = vdstate.getVdstate_St();
		
		char[] ch = vdstate_st.toCharArray();
		for(int i=0;i<ch.length;i++) {
			if(i==order_st) {
				//将当前状态改为黄色，表示已预约
				ch[i]='1';
			}
		}
		
		String new_vdstate_st = String.valueOf(ch);
		vdstate.setVdstate_St(new_vdstate_st);
		
		//保存分时状态
		service.saveVdstate(vdstate,date);
		//******************改变分时状态为已预约************************
		request.getRequestDispatcher("/order?method=pageOrderList").forward(request, response);
	}
	//订单信息分页
	public void pageOrderList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//获取模糊查询
		String sub = request.getParameter("sub");
		if(sub==null) sub="";
		if(sub!=null&&sub.trim().equals("")==false) sub=sub.trim();
		//获取当前对象的id
		HttpSession session = request.getSession();
		Gms_User user = (Gms_User) session.getAttribute("user");
		String user_Id = user.getUser_Id();
		
		//设置当前页和当前显示条数
		String currentPageStr = request.getParameter("currentPage");
		if (currentPageStr == null||currentPageStr.equals(""))  
			currentPageStr = "1";
		int currentPage = Integer.parseInt(currentPageStr);
		int currentCount = 6;	
		
		PageBean pageBean = service.findOrderListByUserId(user_Id,currentPage,currentCount,sub);
		
//		System.out.println(pageBean);
		
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("sub", sub);
		request.getRequestDispatcher("/privilege/personal_center.jsp").forward(request, response);
	}
	
	//取消预定
	public void cancelOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		session.removeAttribute("orderlist");
		
		response.sendRedirect(request.getContextPath()+"/user/GMS_index.jsp");
	}
	
	//提交订单
	public void submitOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//将session中的orderlist取出来存到数据库
		HttpSession session = request.getSession();
		Gms_Order orderlist = (Gms_Order) session.getAttribute("orderlist");
		
		service.addOrderList(orderlist);
		
		//将所选的位置状态改为已选
		//获得当前场馆id,通过场馆id去找分时状态表，获得分时状态 (也可以通过获得时间和场馆名去调用已经实现的方法)
		String venue_Id = orderlist.getOrder_VenueId().getVenue_Id();
		java.sql.Date order_Date = orderlist.getOrder_Date();
		Gms_Vdstate vdstate = service.findVdstateById(venue_Id,order_Date);
		
		//获得开始时间order_St
		//******************改变分时状态为已预约**********************
		Integer order_st = orderlist.getOrder_St();
		//获得分时状态
		String vdstate_st = vdstate.getVdstate_St();
		
		char[] ch = vdstate_st.toCharArray();
		for(int i=0;i<ch.length;i++) {
			if(i==order_st) {
				//将当前状态改为黄色，表示已预约
				ch[i]='2';
			}
		}
		
		String new_vdstate_st = String.valueOf(ch);
		vdstate.setVdstate_St(new_vdstate_st);
		//保存分时状态
		service.saveVdstate(vdstate,order_Date);
		//******************改变分时状态为已预约************************
		
		//存入成功后将session清空
		session.removeAttribute("orderlist");
		response.sendRedirect(request.getContextPath()+"/order?method=pageOrderList");
	}
	
	//页面确认订单
	public void confirmOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//获取页面提交过来的参数信息
		Map<String, String[]> ordermap = request.getParameterMap();
		Gms_Order orderlist = new Gms_Order();
		try {
			BeanUtils.populate(orderlist, ordermap);
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
		
		//把日期格式改了
		String order_Date = ordermap.get("order_Date")[0];
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");  
        Date d = null;  
        try {  
            d = format.parse(order_Date);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        java.sql.Date date = new java.sql.Date(d.getTime());  
        orderlist.setOrder_date(date);
		
		//把剩下的封装完整
		//1.封装订单号private Gms_User order_UserId
        orderlist.setOrder_Id(CommonUtils.getUUID());
		
		//2.封装场馆编号venue_id (封对象进去)
		String venue_id = ordermap.get("venue_id")[0];
		
		//3.通过场馆编号获得场馆对象private Gms_Venue order_VenueId 
		Gms_Venue venue = service.findVenueById(venue_id);
		orderlist.setOrder_VenueId(venue);
		
		//4. 封装学号/工号 private String order_Id 
		HttpSession session = request.getSession();
		Gms_User user = (Gms_User) session.getAttribute("user");
		orderlist.setOrder_UserId(user);
		
		//5.封装订单生成时间private Date order_Mktime2
		Date date2 = new Date();
		SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//HH大写表示用24小时制 hh表示用12小时制
		String buliddate = format2.format(date2);
		orderlist.setOrder_Mktime2(buliddate);
		
		//6.设置订单状态private Integer order_State
		orderlist.setOrder_State(0);
		
		//订单封装完成将信息放到session中,提交订单后清空
		session.setAttribute("orderlist", orderlist);
		response.sendRedirect(request.getContextPath()+"/user/orderlist.jsp");
	}
	
	//获得所有场馆信息
	public void venueList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获得页面传过来的json参数
		String currentDate = request.getParameter("currentDate");
		String venueName = request.getParameter("venueName");
		
		List<Map<String, Object>> maplist = service.finAllVenueByTypeAndDate(venueName,currentDate);
		
		String json = JSON.toJSONString(maplist);
		
		request.setAttribute("flag", "判断标识");//前台
		response.getWriter().write(json);
	}
	
	//获得所有的场馆类别
	public void typeList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		List<Gms_Type> gmstype = service.findAllType();
		
		//将所返回的list转为json
		String json = JSON.toJSONString(gmstype);
		response.getWriter().write(json);
	}
	
	//获取指定通知内容
	public void viewNotice(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("noticeId");
		
		Gms_Notice notice = service.findNoticeById(id);
		
		request.setAttribute("notice", notice);//前台
		request.getRequestDispatcher("/user/notice.jsp").forward(request, response);
	}

	//获得所有通知
	public void noticeList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		List<Gms_Notice> noticelist = service.findAllNotice();
		
		//放session目的是为了展示
		HttpSession session = request.getSession();
		session.setAttribute("noticelist", noticelist);
//		System.out.println(session.getAttribute("noticelist"));
		//将所返回的list转为json
		String json = JSON.toJSONString(noticelist);
		response.getWriter().write(json);
	}
	
}