package gms.cuit.service.user;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import gms.cuit.entity.Gms_Notice;
import gms.cuit.entity.Gms_Order;
import gms.cuit.entity.Gms_Type;
import gms.cuit.entity.Gms_Vdstate;
import gms.cuit.entity.Gms_Venue;
import gms.cuit.entity.PageBean;

public interface OrderServcie {

	public List<Gms_Type> findAllType();

	public List<Map<String, Object>> finAllVenueByTypeAndDate(String venueName, String dateTime);

	public Gms_Venue findVenueById(String venue_id);

	public void addOrderList(Gms_Order orderlist);

	public Gms_Vdstate findVdstateById(String venue_Id, Date order_Date);

	public void saveVdstate(Gms_Vdstate vdstate, Date order_Date);

	public PageBean findOrderListByUserId(String user_Id, int currentPage, int currentCount, String sub);

	public void delOrderById(String orderid);

	public List<Gms_Notice> findAllNotice();

	public Gms_Notice findNoticeById(String id);

	public List<Map<String, Object>> query_orderAll(String user_Id);

}
