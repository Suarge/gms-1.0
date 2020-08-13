package gms.cuit.service.user.impl;

import java.lang.reflect.InvocationTargetException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.jasper.tagplugins.jstl.core.ForEach;

import gms.cuit.dao.OrderDao;
import gms.cuit.dao.impl.OrderDaoImpl;
import gms.cuit.entity.Gms_Notice;
import gms.cuit.entity.Gms_Order;
import gms.cuit.entity.Gms_Type;
import gms.cuit.entity.Gms_User;
import gms.cuit.entity.Gms_Vdstate;
import gms.cuit.entity.Gms_Venue;
import gms.cuit.entity.PageBean;
import gms.cuit.service.user.OrderServcie;

public class OrderServcieImpl implements OrderServcie {
	
	OrderDao dao = new  OrderDaoImpl();
	
	public OrderServcieImpl() {
		super();
	}
	
	//获得所有通知
	public List<Gms_Notice> findAllNotice() {
		List<Gms_Notice> list= null;
		try {
			list = dao.findAllNotice();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	
	}
	
	//根据id获取通知
	public Gms_Notice findNoticeById(String id) {
		Gms_Notice notice = null;
		try {
			notice = dao.findNoticeById(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return notice;
	}

	
	//查询所有的场馆类型
	public List<Gms_Type> findAllType() {
		List<Gms_Type> gmstype = null;
		try {
			gmstype = dao.findAllType();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return gmstype;
	}

	//查询所有场馆类型和分时状态
	public List<Map<String, Object>> finAllVenueByTypeAndDate(String venueName, String dateTime) {
		List<Map<String, Object>> maplist=null;
		try {
			maplist = dao.finAllVenueByTypeAndDate(venueName,dateTime);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return maplist;
	}

	//通过场馆编号获得场馆
	public Gms_Venue findVenueById(String venue_id) {
		Gms_Venue venue = null;
		try {
			venue = dao.findVenueById(venue_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return venue;
	}

	//保存订单信息到订单表  
	//  (不考虑金额可以不用事务) 后面可以扩展
	public void addOrderList(Gms_Order orderlist) {
		try {
			dao.addOrder(orderlist);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//通过场馆id找分时状态
	public Gms_Vdstate findVdstateById(String venue_Id,Date order_Date) {
		Gms_Vdstate vdstate = null;
		try {
			vdstate = dao.findVdstateById(venue_Id,order_Date);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vdstate;
	}

	//保存修改后的分时状态表
	public void saveVdstate(Gms_Vdstate vdstate,Date order_Date) {
		try {
			dao.saveVdstate(vdstate,order_Date);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//封装PageBean
	public PageBean findOrderListByUserId(String user_Id,int currentPage, int currentCount,String sub) {
		// 封装一个pagebean并返回web层
		PageBean<Gms_Order> pageBean = new PageBean<Gms_Order>();
		//1.封装当前页
		pageBean.setCurrentPage(currentPage);
		//2.封装当前显示条数
		pageBean.setCurrentCount(currentCount);
		//3.封装总条数
		int totalCount = 0;
		try {
			totalCount = dao.getCount(user_Id,sub);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pageBean.setTotalCount(totalCount);
		//4.封装总页数
		int totalPage = (int) Math.ceil(1.0*totalCount/currentCount);
		pageBean.setTotalPage(totalPage);
		//5.封装当前页显示的数据
		int index = (currentPage-1)*currentCount;
		//将list<map<>>遍历封装到orderlist
		List<Map<String, Object>> maplist = null;
		try {
			maplist = dao.findProductByPage(user_Id,index,currentCount,sub);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		List<Gms_Order> list = new ArrayList<Gms_Order>();
		for (Map<String, Object> map : maplist) {
			Gms_Order order = new Gms_Order();
			Gms_Venue venue = new Gms_Venue();
			Gms_User user = new Gms_User();
			try {
				BeanUtils.populate(order, map);
				BeanUtils.populate(venue, map);
				BeanUtils.populate(user, map);
				order.setOrder_UserId(user);
				order.setOrder_VenueId(venue);
			} catch (IllegalAccessException | InvocationTargetException e) {
				e.printStackTrace();
			}
			list.add(order);
		}
	
		pageBean.setList(list);
//		System.out.println(pageBean);
		return pageBean;
	}

	//通过id取消订单  就是改变订单状态为取消状态
	public void delOrderById(String orderid) {
		try {
			dao.delOrderById(orderid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//导出数据
	public List<Map<String, Object>> query_orderAll(String user_Id) {
		List<Map<String, Object>> list = null;
		try {
			list = dao.query_orderAll(user_Id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

}
