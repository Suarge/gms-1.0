	package gms.cuit.service.admin.impl;

import java.math.RoundingMode;
import java.sql.Date;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;

import com.sun.org.apache.bcel.internal.generic.RETURN;

import gms.cuit.dao.AdminDao;
import gms.cuit.dao.impl.AdminDaoImpl;
import gms.cuit.entity.Gms_Admin;
import gms.cuit.entity.Gms_Bck_analytics;
import gms.cuit.entity.Gms_Notice;
import gms.cuit.entity.Gms_Order;
import gms.cuit.entity.Gms_Venue;
import gms.cuit.entity.PageBean;
import gms.cuit.service.admin.AdminService;
import gms.cuit.utils.DataSourceUtils;

public class AdminServiceImpl implements AdminService {

	AdminDao adminDao = new AdminDaoImpl();
	
	public AdminServiceImpl() {
		
	}

	@Override
	public Gms_Admin login(Gms_Admin admin) throws SQLException {
		return adminDao.login(admin);
	}

	@Override
	public void update_password(String username, String newpassword) throws SQLException {
		adminDao.update_password(username, newpassword);
	}

	@Override
	public void add_notice(Gms_Notice notice) throws SQLException {
		adminDao.add_notice(notice);
	}
	
	@Override
	public void del_notice(String notice_id) throws SQLException {
		adminDao.del_notice(notice_id);
	}
	
	@Override
	public void update_notice(Gms_Notice notice) throws SQLException {
		adminDao.update_notice(notice);
	}

	@Override
	public PageBean<Gms_Notice> query_noticeByKey(int currentPage, int currentCount, String query_key)
			throws SQLException {
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setCurrentCount(currentCount);
		int totalCount = adminDao.get_noticeTotalCountByKeyQuery(query_key);
		pageBean.setTotalCount(totalCount);
		int totalPage = (int) Math.ceil(1.0*totalCount/currentCount);
		pageBean.setTotalPage(totalPage);
		int index = (currentPage-1)*currentCount;
		List<Gms_Notice> notice_list = adminDao.query_noticeByKey(index,currentCount,query_key);
		pageBean.setList(notice_list);
		return pageBean;
	}
	
	@Override
	public List<Gms_Notice> query_noticeAll() throws SQLException {
		return adminDao.query_noticeByKey(0,-1,"");
	}

	@Override
	public void add_venue(Gms_Venue venue) throws SQLException {
		adminDao.add_venue(venue);
	}

	@Override
	public void del_venue(String venue_id) throws SQLException {
		adminDao.del_venue(venue_id);
	}

	@Override
	public void update_venue(Gms_Venue venue) throws SQLException {
		adminDao.update_venue(venue);
	}

	@Override
	public PageBean<Gms_Venue> query_venueByKey(int currentPage, int currentCount, String query_key) throws SQLException {
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setCurrentCount(currentCount);
		int totalCount = adminDao.get_venueTotalCountByKeyQuery(query_key);
		pageBean.setTotalCount(totalCount);
		int totalPage = (int) Math.ceil(1.0*totalCount/currentCount);
		pageBean.setTotalPage(totalPage);
		int index = (currentPage-1)*currentCount;
		List<Gms_Venue> venue = adminDao.query_venueByKey(index,currentCount,query_key);
		pageBean.setList(venue);
		return pageBean;
	}
	
	@Override
	public List<Gms_Venue> query_venueAll() throws SQLException {
		return adminDao.query_venueByKey(0,-1,"");
	}

	@Override
	public int get_venueTotalCountByKeyQuery(String query_key) throws SQLException {
		return adminDao.get_venueTotalCountByKeyQuery(query_key);
	}

	@Override
	public List<Map<String, Object>> query_orderByKey(int currentPage, int currentCount, String query_key, String sort_state)
			throws SQLException {
		return adminDao.query_orderByKey(currentPage, currentCount, query_key, sort_state);
	}

	@Override
	public int get_orderTotalCountByKeyQuery(String query_key) throws SQLException {
		return adminDao.get_orderTotalCountByKeyQuery(query_key);
	}

	@Override
	public List<Map<String, Object>> query_orderAll() throws SQLException {
		return adminDao.query_orderByKey(0, -1, "", "7");
	}
	
	@Override
	public List<Gms_Bck_analytics> analytics_allByDateAndCat(String date_st, String date_ed) throws SQLException {
		List<Gms_Bck_analytics> analyticslist = new ArrayList<Gms_Bck_analytics>();
		List<Object[]> catlist = adminDao.query_venuetype(); //查询出所有的类别
		for(Object[] catitem : catlist) { //遍历每一个类别
			Gms_Bck_analytics gms_Bck_analytics = new Gms_Bck_analytics();
			//获取类别名字
			String catitemString = catitem[0].toString();
			gms_Bck_analytics.setAnalytics_Name(catitemString);
			//获取订单收益
			Double analytics_Profit = adminDao.get_orderProfitByDateAndCat(date_st, date_ed, catitemString);
			gms_Bck_analytics.setAnalytics_Profit(analytics_Profit);
			//获取租用人数
			Integer analytics_Rent = adminDao.get_orderRentByDateAndCat(date_st, date_ed, catitemString);
			gms_Bck_analytics.setAnalytics_Rent(analytics_Rent);
			//获取总数
			int totalcount = adminDao.get_orderTotalCountByDate(date_st, date_ed);
			int mycount = adminDao.get_orderUsageByDateAndCat(date_st, date_ed, catitemString);
			//获取使用率
			double analytics_Usage = 0.00;
			if(totalcount!=0) analytics_Usage = (double)mycount*1.0/((double)totalcount*1.0);
			NumberFormat nf = NumberFormat.getPercentInstance();/*设置为百分比*/
	        nf.setMinimumFractionDigits(2);//设置该百分比数字，保留2位小数;
	        nf.setRoundingMode(RoundingMode.HALF_UP); //设置满5向上进位，即四舍五入;
			gms_Bck_analytics.setAnalytics_Usage(nf.format(analytics_Usage));
			//获取男女欢迎度
			int malecount = adminDao.get_orderCountByDateAndCatAndSex(date_st, date_ed, catitemString, "男");
			int femalecount = adminDao.get_orderCountByDateAndCatAndSex(date_st, date_ed, catitemString, "女");
			gms_Bck_analytics.setAnalytics_Sexpercentage(malecount+" "+femalecount);
			//获取订单年龄分布
			String analytics_Agepercentage = "";
			for(int age=10;age<=60;age+=10) {
				analytics_Agepercentage+=adminDao.get_orderCountByDateAndCatAndAge(date_st, date_ed, catitemString, age);
				if(age!=60) analytics_Agepercentage+=" ";
			}
			gms_Bck_analytics.setAnalytics_Agepercentage(analytics_Agepercentage);
			analyticslist.add(gms_Bck_analytics);
		}
		return analyticslist;
	}
	
	@Override
	public List<Gms_Bck_analytics> analytics_allByDateAndVen(String date_st, String date_ed) throws SQLException {
		List<Gms_Bck_analytics> analyticslist = new ArrayList<Gms_Bck_analytics>();
		List<Object[]> venlist = adminDao.query_venue(); //查询出所有的场馆
		for(Object[] venitem : venlist) { //遍历每一个类别
			Gms_Bck_analytics gms_Bck_analytics = new Gms_Bck_analytics();
			//获取场馆名字
			String venitemString = venitem[0].toString();
			gms_Bck_analytics.setAnalytics_Name(venitemString);
			//获取订单收益
			Double analytics_Profit = adminDao.get_orderProfitByDateAndVen(date_st, date_ed, venitemString);
			gms_Bck_analytics.setAnalytics_Profit(analytics_Profit);
			//获取租用人数
			Integer analytics_Rent = adminDao.get_orderRentByDateAndVen(date_st, date_ed, venitemString);
			gms_Bck_analytics.setAnalytics_Rent(analytics_Rent);
			//获取总数
			int totalcount = adminDao.get_orderTotalCountByDate(date_st, date_ed);
			int mycount = adminDao.get_orderUsageByDateAndVen(date_st, date_ed, venitemString);
			//获取使用率
			double analytics_Usage = 0.00;
			if(totalcount!=0) analytics_Usage = (double)mycount*1.0/((double)totalcount*1.0);
			NumberFormat nf = NumberFormat.getPercentInstance();/*设置为百分比*/
	        nf.setMinimumFractionDigits(2);//设置该百分比数字，保留2位小数;
	        nf.setRoundingMode(RoundingMode.HALF_UP); //设置满5向上进位，即四舍五入;
			gms_Bck_analytics.setAnalytics_Usage(nf.format(analytics_Usage));
			//获取男女欢迎度
			int malecount = adminDao.get_orderCountByDateAndVenAndSex(date_st, date_ed, venitemString, "男");
			int femalecount = adminDao.get_orderCountByDateAndVenAndSex(date_st, date_ed, venitemString, "女");
			gms_Bck_analytics.setAnalytics_Sexpercentage(malecount+" "+femalecount);
			//获取订单年龄分布
			String analytics_Agepercentage = "";
			for(int age=10;age<=60;age+=10) {
				analytics_Agepercentage+=adminDao.get_orderCountByDateAndVenAndAge(date_st, date_ed, venitemString, age);
				if(age!=60) analytics_Agepercentage+=" ";
			}
			gms_Bck_analytics.setAnalytics_Agepercentage(analytics_Agepercentage);
			analyticslist.add(gms_Bck_analytics);
		}
		return analyticslist;
	}

	@Override
	public Integer get_summaryTodayOrderCount(String date_today) throws SQLException {
		return adminDao.get_summaryTodayOrderCount(date_today);
	}
	
	@Override
	public Double get_summaryTodayOrderProfit(String date_today) throws SQLException {
		return adminDao.get_summaryTodayOrderProfit(date_today);
	}

	@Override
	public List<Map<String, Object>> query_orderByLatest(int get_count) throws SQLException {
		return adminDao.query_orderByLatest(get_count);
	}

	@Override
	public String get_orderCountByDate(String date_today) throws SQLException {
		List<Object[]> catlist = adminDao.query_venuetype(); //查询出所有的类别
		String valString = "";		
		for(Object[] catitem : catlist) { //遍历每一个类别
			//获取类别名字
			String catitemname = catitem[0].toString();
			//获取订单场馆分布
			int count = adminDao.get_orderCountByDateAndVen(date_today, catitemname);
			if(catitemname.equals(catlist.get(0)[0]) == false) valString += " "; 
			valString += ""+count;
		}
		return valString;
	}

	


	
}
