package gms.cuit.dao.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import gms.cuit.dao.AdminDao;
import gms.cuit.entity.Gms_Admin;
import gms.cuit.entity.Gms_Notice;
import gms.cuit.entity.Gms_Venue;
import gms.cuit.utils.DataSourceUtils;

public class AdminDaoImpl implements AdminDao {

	public AdminDaoImpl() {
		
	}

	@Override
	public Gms_Admin login(Gms_Admin admin) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from gms_admin where admin_username=? and admin_password=?";
		return runner.query(sql, new BeanHandler<Gms_Admin>(Gms_Admin.class), admin.getAdmin_Username(),admin.getAdmin_Password());
	}

	@Override
	public void update_password(String username, String newpassword) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "update gms_admin set admin_password=? where admin_username=?";
		runner.update(sql, newpassword,username);
	}

	//通知相关数据库操作
	@Override
	public void add_notice(Gms_Notice notice) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "insert into gms_notice values(?,?,?,?,?,0)";
		runner.update(sql,notice.getNotice_Id(),notice.getNotice_Time(),notice.getNotice_Man(),
				notice.getNotice_Content(),notice.getNotice_Title());
	}
	
	@Override
	public void del_notice(String notice_id) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "update gms_notice set notice_state = 1 where notice_id = ?";
		runner.update(sql,notice_id);
	}
	
	@Override
	public void update_notice(Gms_Notice notice) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "update gms_notice set notice_time=?,notice_man=?,notice_content=?, "
				+ "notice_title=?,notice_state=0 where notice_id=?";
		runner.update(sql,notice.getNotice_Time(),notice.getNotice_Man(),
				notice.getNotice_Content(),notice.getNotice_Title(),notice.getNotice_Id());
	}

	@Override
	public List<Gms_Notice> query_noticeByKey(int currentPage, int currentCount, String query_key) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from gms_notice where notice_state = 0 and notice_title like'%"+query_key+"%' order by notice_time desc limit ?,?";
		return runner.query(sql, new BeanListHandler<Gms_Notice>(Gms_Notice.class),currentPage,currentCount);
	}

	@Override
	public int get_noticeTotalCountByKeyQuery(String query_key) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select COALESCE(count(*),0) from gms_notice where notice_state = 0 and notice_title like '%"+query_key+"%'";
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}

	//场馆相关操作
	@Override
	public void add_venue(Gms_Venue venue) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "insert into gms_venue values(?,?,?,?,?,?,?,0)";
		runner.update(sql,venue.getVenue_Id(),venue.getVenue_Type(),venue.getVenue_Name(),venue.getVenue_Price(),
				venue.getVenue_Capacity(),venue.getVenue_Open(),venue.getVenue_Close());
	}

	@Override
	public void del_venue(String venue_id) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "update gms_venue set venue_is_del = 1 where venue_id = ?";
		runner.update(sql,venue_id);
	}

	@Override
	public void update_venue(Gms_Venue venue) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "update gms_venue set venue_type=?,venue_name=?,venue_price=?, "
				+ "venue_capacity=?,venue_open=?,venue_close=? where venue_id=?";
		runner.update(sql,venue.getVenue_Type(),venue.getVenue_Name(),venue.getVenue_Price(),
				venue.getVenue_Capacity(),venue.getVenue_Open(),venue.getVenue_Close(),venue.getVenue_Id());
	}

	@Override
	public List<Gms_Venue> query_venueByKey(int currentPage, int currentCount, String query_key) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from gms_venue where venue_is_del = 0 and venue_name like'%"+query_key+"%' order by venue_type desc limit ?,?";
		return runner.query(sql, new BeanListHandler<Gms_Venue>(Gms_Venue.class),currentPage,currentCount);
	}

	@Override
	public int get_venueTotalCountByKeyQuery(String query_key) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select COALESCE(count(*),0) from gms_venue where venue_is_del = 0 and venue_name like '%"+query_key+"%'";
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}

	//订单相关操作
	@Override
	public List<Map<String, Object>> query_orderByKey(int currentPage, int currentCount, String query_key, String sort_state)
			throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT venue_name,venue_type,user_id,user_email,user_sex,user_age,order_date,order_st,order_ed,order_price,order_mktime,order_state "
		+"FROM gms_order,gms_venue,gms_user WHERE gms_order.order_venue_id=gms_venue.venue_id AND gms_user.user_id=gms_order.order_user_id AND (order_user_id LIKE '%"+query_key
			+"%' OR venue_name LIKE '%"+query_key+"%' OR venue_type LIKE '%"+query_key+"%')";
		String sortparm = "";
		if("1".equals(sort_state)) sortparm="ORDER BY order_date DESC";
		else if("2".equals(sort_state)) sortparm="ORDER BY order_date";
		else if("3".equals(sort_state)) sortparm="ORDER BY order_price DESC";
		else if("4".equals(sort_state)) sortparm="ORDER BY order_price";
		else if("5".equals(sort_state)) sortparm="ORDER BY order_mktime DESC";
		else if("6".equals(sort_state)) sortparm="ORDER BY order_mktime";
		else sortparm="ORDER BY venue_type";
		sql+=sortparm + " limit ?,?";
		return runner.query(sql, new MapListHandler(), currentPage, currentCount);
	}

	@Override
	public int get_orderTotalCountByKeyQuery(String query_key) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT COALESCE(COUNT(*),0) FROM gms_order,gms_venue WHERE gms_order.order_venue_id=gms_venue.venue_id AND (order_user_id LIKE '%"+query_key
				+"%' OR venue_name LIKE '%"+query_key+"%' OR venue_type LIKE '%"+query_key+"%')";
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}
	
	//按类别分析相关操作
	@Override
	public List<Object[]> query_venuetype() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select type_name from gms_type";
		return runner.query(sql, new ArrayListHandler());
	}
	
	@Override
	public int get_orderTotalCountByDate(String date_st, String date_ed) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT COALESCE(COUNT(*),0) FROM gms_order WHERE order_mktime BETWEEN '"+date_st+"' AND '"+date_ed+"'";
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}

	@Override
	public Double get_orderProfitByDateAndCat(String date_st, String date_ed, String catitemString) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT COALESCE(SUM(order_price),0) FROM gms_order,gms_venue WHERE gms_venue.venue_id=gms_order.order_venue_id "
		+"AND venue_type='"+catitemString+"' AND order_mktime BETWEEN '"+date_st+"' AND '"+date_ed+"'";
		Double query = Double.parseDouble(runner.query(sql, new ScalarHandler()).toString());
		return query;
	}

	@Override
	public Integer get_orderRentByDateAndCat(String date_st, String date_ed, String catitemString) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT COALESCE(COUNT(*),0) FROM gms_order,gms_venue WHERE gms_venue.venue_id=gms_order.order_venue_id "
		+"AND venue_type='"+catitemString+"' AND order_mktime BETWEEN '"+date_st+"' AND '"+date_ed+"'";
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}
	
	@Override
	public int get_orderUsageByDateAndCat(String date_st, String date_ed, String catitemString) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT COALESCE(COUNT(*),0) FROM gms_order,gms_venue WHERE gms_venue.venue_id=gms_order.order_venue_id "
		+"AND venue_type='"+catitemString+"' AND order_mktime BETWEEN '"+date_st+"' AND '"+date_ed+"'";
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}

	@Override
	public int get_orderCountByDateAndCatAndSex(String date_st, String date_ed, String catitemString, String sex) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT COALESCE(COUNT(*),0) FROM gms_order,gms_venue,gms_user WHERE gms_venue.venue_id=gms_order.order_venue_id "
				+"AND gms_order.order_user_id=gms_user.user_id AND venue_type='"+catitemString+"' "
				+"AND order_mktime BETWEEN '"+date_st+"' AND '"+date_ed+"' "
				+"AND user_sex='"+sex+"'";
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}

	@Override
	public int get_orderCountByDateAndCatAndAge(String date_st, String date_ed, String catitemString, int age)
			throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT COALESCE(COUNT(*),0) FROM gms_order,gms_venue,gms_user WHERE gms_venue.venue_id=gms_order.order_venue_id "
		+"AND gms_order.order_user_id=gms_user.user_id AND venue_type='"+catitemString+"'"
		+"AND order_mktime BETWEEN '"+date_st+"' AND '"+date_ed+"'";
		String agesql = "";
		if(age==10) agesql=" AND user_age < 20";
		else if(age==20) agesql=" AND user_age >=20 AND user_age < 29";
		else if(age==30) agesql=" AND user_age >=30 AND user_age < 39";
		else if(age==40) agesql=" AND user_age >=40 AND user_age < 49";
		else if(age==50) agesql=" AND user_age >=50 AND user_age < 59";
		else agesql=" AND user_age >=60";
		sql+=agesql;
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}

	//按场馆分析相关操作
	@Override
	public List<Object[]> query_venue() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select venue_name from gms_venue";
		return runner.query(sql, new ArrayListHandler());
	}
	
	@Override
	public Double get_orderProfitByDateAndVen(String date_st, String date_ed, String venitemString) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT COALESCE(SUM(order_price),0) FROM gms_order,gms_venue WHERE gms_venue.venue_id=gms_order.order_venue_id "
		+"AND venue_name='"+venitemString+"' AND order_mktime BETWEEN '"+date_st+"' AND '"+date_ed+"'";
		Double query = Double.parseDouble(runner.query(sql, new ScalarHandler()).toString());
		return query;
	}
	
	@Override
	public Integer get_orderRentByDateAndVen(String date_st, String date_ed, String venitemString) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT COALESCE(COUNT(*),0) FROM gms_order,gms_venue WHERE gms_venue.venue_id=gms_order.order_venue_id "
		+"AND venue_name='"+venitemString+"' AND order_mktime BETWEEN '"+date_st+"' AND '"+date_ed+"'";
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}
	
	@Override
	public int get_orderUsageByDateAndVen(String date_st, String date_ed, String venitemString) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT COALESCE(COUNT(*),0) FROM gms_order,gms_venue WHERE gms_venue.venue_id=gms_order.order_venue_id "
		+"AND venue_name='"+venitemString+"' AND order_mktime BETWEEN '"+date_st+"' AND '"+date_ed+"'";
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}
	
	@Override
	public int get_orderCountByDateAndVenAndSex(String date_st, String date_ed, String venitemString, String sex) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT COALESCE(COUNT(*),0) FROM gms_order,gms_venue,gms_user WHERE gms_venue.venue_id=gms_order.order_venue_id "
				+"AND gms_order.order_user_id=gms_user.user_id AND venue_name='"+venitemString+"' "
				+"AND order_mktime BETWEEN '"+date_st+"' AND '"+date_ed+"' "
				+"AND user_sex='"+sex+"'";
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}

	@Override
	public int get_orderCountByDateAndVenAndAge(String date_st, String date_ed, String venitemString, int age)
			throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT COALESCE(COUNT(*),0) FROM gms_order,gms_venue,gms_user WHERE gms_venue.venue_id=gms_order.order_venue_id "
		+"AND gms_order.order_user_id=gms_user.user_id AND venue_name='"+venitemString+"'"
		+"AND order_mktime BETWEEN '"+date_st+"' AND '"+date_ed+"'";
		String agesql = "";
		if(age==10) agesql=" AND user_age < 20";
		else if(age==20) agesql=" AND user_age >=20 AND user_age < 29";
		else if(age==30) agesql=" AND user_age >=30 AND user_age < 39";
		else if(age==40) agesql=" AND user_age >=40 AND user_age < 49";
		else if(age==50) agesql=" AND user_age >=50 AND user_age < 59";
		else agesql=" AND user_age >=60";
		sql+=agesql;
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}

	//总览操作
	@Override
	public Integer get_summaryTodayOrderCount(String date_today) throws SQLException {
		String date_st = date_today+" 00:00:00";
		String date_ed = date_today+" 23:00:00";
		String sql = "SELECT COALESCE(COUNT(*),0) FROM gms_order WHERE order_mktime BETWEEN '"
				+date_st+"' AND '"+date_ed+"'";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}

	@Override
	public Double get_summaryTodayOrderProfit(String date_today) throws SQLException {
		String date_st = date_today+" 00:00:00";
		String date_ed = date_today+" 23:00:00";
		String sql = "SELECT COALESCE(SUM(order_price),0) FROM gms_order WHERE order_mktime BETWEEN '"
				+date_st+"' AND '"+date_ed+"'";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		Double query = Double.parseDouble(runner.query(sql, new ScalarHandler()).toString());
		return query;
	}

	@Override
	public List<Map<String, Object>> query_orderByLatest(int get_count) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "SELECT venue_name,venue_type,user_id,order_user_id,order_price,order_mktime,order_state "
		+"FROM gms_order,gms_venue,gms_user WHERE gms_user.user_id=gms_order.order_user_id AND gms_order.order_venue_id=gms_venue.venue_id ORDER BY order_mktime DESC limit 0,?";
		return runner.query(sql, new MapListHandler(), get_count);
	}

	@Override
	public int get_orderCountByDateAndVen(String date_today, String venitemString) throws SQLException {
		String date_st = date_today+" 00:00:00";
		String date_ed = date_today+" 23:00:00";
		String sql = "SELECT COALESCE(COUNT(*),0) FROM gms_order,gms_venue WHERE gms_venue.venue_id=gms_order.order_venue_id "
				+"AND venue_type='"+venitemString+"' "
				+"AND order_mktime BETWEEN '"+date_st+"' AND '"+date_ed+"' ";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		Long query = (Long) runner.query(sql, new ScalarHandler());
		return query.intValue();
	}
}
