package gms.cuit.service.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import gms.cuit.entity.Gms_Admin;
import gms.cuit.entity.Gms_Bck_analytics;
import gms.cuit.entity.Gms_Notice;
import gms.cuit.entity.Gms_Order;
import gms.cuit.entity.Gms_Venue;
import gms.cuit.entity.PageBean;

public interface AdminService {
	public Gms_Admin login(Gms_Admin admin) throws SQLException;
	public void update_password(String username,String newpassword) throws SQLException;
	
	public void add_notice(Gms_Notice notice) throws SQLException;
	public void del_notice(String notice_id) throws SQLException;
	public void update_notice(Gms_Notice notice) throws SQLException;
	public PageBean<Gms_Notice> query_noticeByKey(int currentPage, int currentCount, String query_key) throws SQLException;
	public List<Gms_Notice> query_noticeAll() throws SQLException;
	
	public void add_venue(Gms_Venue venue) throws SQLException;
	public void del_venue(String venue_id) throws SQLException;
	public void update_venue(Gms_Venue venue) throws SQLException;
	public PageBean<Gms_Venue> query_venueByKey(int currentPage, int currentCount, String query_key) throws SQLException;
	public List<Gms_Venue> query_venueAll() throws SQLException;

	public int get_venueTotalCountByKeyQuery(String query_key) throws SQLException;
	public List<Map<String, Object>> query_orderByKey(int currentPage, int currentCount, String query_key, String sort_state) throws SQLException;
	public int get_orderTotalCountByKeyQuery(String query_key) throws SQLException;
	public List<Map<String, Object>> query_orderAll() throws SQLException;
	
	public List<Gms_Bck_analytics> analytics_allByDateAndCat(String date_st, String date_ed) throws SQLException;
	public List<Gms_Bck_analytics> analytics_allByDateAndVen(String date_st, String date_ed) throws SQLException;
	
	public Integer get_summaryTodayOrderCount(String date_today) throws SQLException;
	public Double get_summaryTodayOrderProfit(String date_today) throws SQLException;
	public List<Map<String, Object>> query_orderByLatest(int get_count) throws SQLException;
	public String get_orderCountByDate(String date_today) throws SQLException;
	
}
