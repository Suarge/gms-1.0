package gms.cuit.dao.impl;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import gms.cuit.dao.OrderDao;
import gms.cuit.entity.Gms_Notice;
import gms.cuit.entity.Gms_Order;
import gms.cuit.entity.Gms_Type;
import gms.cuit.entity.Gms_Vdstate;
import gms.cuit.entity.Gms_Venue;
import gms.cuit.utils.DataSourceUtils;

public class OrderDaoImpl implements OrderDao {
	
	//通知消息
	public List<Gms_Notice> findAllNotice() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from gms_notice where notice_state=0 order by notice_time desc";
		return runner.query(sql, new BeanListHandler<Gms_Notice>(Gms_Notice.class));
	}
	
	//根据id获取通知消息
	public Gms_Notice findNoticeById(String id) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from gms_notice where notice_id = ?";
		return runner.query(sql, new BeanHandler<Gms_Notice>(Gms_Notice.class),id);
	}
	//查询所有场馆类型
	public List<Gms_Type> findAllType() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from gms_type";
		return runner.query(sql, new BeanListHandler<Gms_Type>(Gms_Type.class));
	}

	//查询所有场馆信息和分时状态
	public List<Map<String, Object>> finAllVenueByTypeAndDate(String venueName,  String dateTime) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select i.venue_id,i.venue_type,i.venue_name,i.venue_price,p.vdstate_date,vdstate_st from gms_venue i,gms_vdstate p where i.venue_id= p.vdstate_id and i.venue_Type=?  and p.vdstate_Date=?";
		List<Map<String, Object>> mapList = runner.query(sql, new MapListHandler() ,venueName,dateTime);
		return mapList;
	}

	//通过id获得场馆
	public Gms_Venue findVenueById(String venue_id) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from gms_venue where venue_id = ?";
		return runner.query(sql, new BeanHandler<Gms_Venue>(Gms_Venue.class),venue_id);
	}

	//录入订单信息
	public void addOrder(Gms_Order orderlist) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "insert into gms_order values(?,?,?,?,?,?,?,?,?)";
		runner.update(sql, orderlist.getOrder_Id(),orderlist.getOrder_VenueId().getVenue_Id(),orderlist.getOrder_UserId().getUser_Id(),orderlist.getOrder_Date(),
				orderlist.getOrder_St(),orderlist.getOrder_Ed(),orderlist.getOrder_State(),orderlist.getOrder_Mktime2(),orderlist.getOrder_Price());
		
	}

	//通过场馆id找分时状态
	public Gms_Vdstate findVdstateById(String venue_Id,Date order_Date) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from gms_vdstate where vdstate_id=? and vdstate_date=?";
		Gms_Vdstate gms_vdstate = runner.query(sql, new BeanHandler<Gms_Vdstate>(Gms_Vdstate.class),venue_Id,order_Date);
		return gms_vdstate;
	}

	//保存更改后的分时状态
	public void saveVdstate(Gms_Vdstate vdstate,Date order_Date) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "update gms_vdstate set vdstate_st=? where vdstate_id=? and vdstate_date=?";
		runner.update(sql,vdstate.getVdstate_St(),vdstate.getVdstate_Id(),order_Date);
		
	}

	//获得总条数
	public int getCount(String user_Id,String sub) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select COALESCE(count(*),0) from gms_order i,gms_venue p where i.order_venue_id= p.venue_id and i.order_user_id=? and (p.venue_type LIKE binary '%"+sub+"%' or p.venue_name LIKE binary '%"+sub+"%'  or i.order_id LIKE binary '%"+sub+"%' or i.order_date LIKE binary '%"+sub+"%' or i.order_mktime LIKE binary '%"+sub+"%' or i.order_price LIKE binary '%"+sub+"%')";
		Long query = (Long) runner.query(sql, new ScalarHandler(),user_Id);
		return query.intValue();
	}

	//通过user_id查看自己的订单
	public List<Map<String, Object>> findProductByPage(String user_Id, int currentPage, int currentCount, String sub) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from gms_order i,gms_venue p where i.order_venue_id= p.venue_id and i.order_user_id=? and (p.venue_type LIKE binary '%"+sub+"%' or p.venue_name LIKE binary '%"+sub+"%'  or i.order_id LIKE binary '%"+sub+"%' or i.order_date LIKE binary '%"+sub+"%' or i.order_mktime LIKE binary '%"+sub+"%' or i.order_price LIKE binary '%"+sub+"%') order by order_mktime desc,order_date desc  limit ?,?";
		List<Map<String, Object>> mapList = runner.query(sql, new MapListHandler() ,user_Id,currentPage,currentCount);
		return mapList;
	}
	
	//通过id修改订单状态
	public void delOrderById(String orderid) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "update gms_order set order_state=1 where order_id=?";
		runner.update(sql,orderid);
		
	}
	
	@Override
	public void UpateOrderStateByTime(String date,String hour) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select order_id from gms_order where order_state=0 and (order_date<? or (order_date=? and order_st<=?))";
		List<Object[]> rsList = runner.query(sql, new ArrayListHandler(),date,date,hour);
		if(rsList==null) return;
		for(Object[] obj:rsList ) {
			String sqllString = "update gms_order set order_state=2 where order_state=0 and order_id=?";
			runner.update(sqllString, obj[0].toString());
		}
	}

	@Override
	public List<Gms_Vdstate> QueryOrderStateByTime(String date) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from gms_vdstate where vdstate_date = ?";
		return runner.query(sql, new BeanListHandler<Gms_Vdstate>(Gms_Vdstate.class),date);
	}

	@Override
	public void UpateVdState(Gms_Vdstate vdstate) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql =  "update gms_vdstate set vdstate_st=? where vdstate_id=? and vdstate_date=?";
		runner.update(sql,vdstate.getVdstate_St(),vdstate.getVdstate_Id(),vdstate.getVdstate_Date());
	}

	//导出数据
	public List<Map<String, Object>> query_orderAll(String user_Id) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from gms_order i,gms_venue p where i.order_venue_id= p.venue_id and i.order_user_id=?  order by order_mktime desc,order_date desc";
		List<Map<String, Object>> mapList = runner.query(sql, new MapListHandler() ,user_Id);
		return mapList;
	}
}
