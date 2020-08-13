package gms.cuit.dao;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import gms.cuit.entity.Gms_Notice;
import gms.cuit.entity.Gms_Order;
import gms.cuit.entity.Gms_Type;
import gms.cuit.entity.Gms_Vdstate;
import gms.cuit.entity.Gms_Venue;

public interface OrderDao {

	public List<Gms_Type> findAllType() throws SQLException;

	public List<Map<String, Object>> finAllVenueByTypeAndDate(String venueName, String dateTime) throws SQLException;

	public Gms_Venue findVenueById(String venue_id) throws SQLException;

	public void addOrder(Gms_Order orderlist) throws SQLException;

	public Gms_Vdstate findVdstateById(String venue_Id, Date order_Date) throws SQLException;

	public void saveVdstate(Gms_Vdstate vdstate, Date order_Date) throws SQLException;

	public int getCount(String user_Id, String string) throws SQLException;

	public List<Map<String, Object>> findProductByPage(String user_Id, int currentPage, int currentCount, String sub) throws SQLException;
	
	public void delOrderById(String orderid) throws SQLException;

	public void UpateOrderStateByTime(String date,String hour) throws SQLException;
	public List<Gms_Vdstate> QueryOrderStateByTime(String date) throws SQLException;
	public void UpateVdState(Gms_Vdstate vdstate) throws SQLException;

	public List<Gms_Notice> findAllNotice() throws SQLException;

	public Gms_Notice findNoticeById(String id) throws SQLException;

	public List<Map<String, Object>> query_orderAll(String user_Id) throws SQLException;
}
