package gms.cuit.entity;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.sql.Date;

public class Gms_Order implements Serializable {

	/** 订单编号 */
    private String order_Id ;
    /** 场馆编号 */
    private Gms_Venue order_VenueId ;
    /** 工号/学号 */
    private Gms_User order_UserId ;
    /** 预约日期 */
    private Date order_Date ;
    /** 预约开始时间 */
    private Integer order_St ;
    /** 预约结束时间 */
    private Integer order_Ed ;
    /** 预约状态 */
    private Integer order_State ;//0代表进行中 (预约成功), 1代表已取消, 2代表已成功
    /** 订单生成时间 */
    private Date order_Mktime ;
    /** 订单生成时间2 */
    private String order_Mktime2 ;
    /** 订单价格 */
    private Double order_Price ;
    
	public Gms_Order() {
		super();
	}

	public Gms_Order(String order_Id, Gms_Venue order_VenueId, Gms_User order_UserId, Date order_Date, Integer order_St,
			Integer order_Ed, Integer order_State, Date order_Mktime, Double order_Price) {
		super();
		this.order_Id = order_Id;
		this.order_VenueId = order_VenueId;
		this.order_UserId = order_UserId;
		this.order_Date = order_Date;
		this.order_St = order_St;
		this.order_Ed = order_Ed;
		this.order_State = order_State;
		this.order_Mktime = order_Mktime;
		this.order_Price = order_Price;
	}

	public String getOrder_Id() {
		return order_Id;
	}

	public void setOrder_Id(String order_Id) {
		this.order_Id = order_Id;
	}
	
	public void setOrder_id(String order_Id) {
		this.order_Id = order_Id;
	}

	public Gms_Venue getOrder_VenueId() {
		return order_VenueId;
	}

	public void setOrder_VenueId(Gms_Venue order_VenueId) {
		this.order_VenueId = order_VenueId;
	}
	
	public void setOrder_venueId(Gms_Venue order_VenueId) {
		this.order_VenueId = order_VenueId;
	}

	public Gms_User getOrder_UserId() {
		return order_UserId;
	}

	public void setOrder_UserId(Gms_User order_UserId) {
		this.order_UserId = order_UserId;
	}
	
	public void setOrder_userId(Gms_User order_UserId) {
		this.order_UserId = order_UserId;
	}

	public Date getOrder_Date() {
		return order_Date;
	}

	public void setOrder_Date(Date order_Date) {
		setOrder_date(order_Date);
	}
	
	public void setOrder_date(Date order_Date) {
		this.order_Date = order_Date;
	}

	public Integer getOrder_St() {
		return order_St;
	}

	public void setOrder_St(Integer order_St) {
		this.order_St = order_St;
	}
	
	public void setOrder_st(Integer order_St) {
		this.order_St = order_St;
	}

	public Integer getOrder_Ed() {
		return order_Ed;
	}

	public void setOrder_Ed(Integer order_Ed) {
		this.order_Ed = order_Ed;
	}
	
	public void setOrder_ed(Integer order_Ed) {
		this.order_Ed = order_Ed;
	}

	public Integer getOrder_State() {
		return order_State;
	}

	public void setOrder_State(Integer order_State) {
		this.order_State = order_State;
	}
	
	public void setOrder_state(Integer order_State) {
		this.order_State = order_State;
	}

	public Date getOrder_Mktime() {
		return order_Mktime;
	}

	public void setOrder_Mktime(Date order_Mktime) {
		setOrder_mktime(order_Mktime);
	}
	
	public void setOrder_mktime(Date order_Mktime) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String datetime = null;
		datetime = format.format(order_Mktime);
		setOrder_Mktime2(datetime);
		this.order_Mktime = order_Mktime;
	}
	
	public String getOrder_Mktime2() {
		return order_Mktime2;
	}

	public void setOrder_Mktime2(String order_Mktime2) {
		this.order_Mktime2 = order_Mktime2;
	}

	public Double getOrder_Price() {
		return order_Price;
	}

	public void setOrder_Price(Double order_Price) {
		this.order_Price = order_Price;
	}
	
	public void setOrder_price(Double order_Price) {
		this.order_Price = order_Price;
	}

	@Override
	public String toString() {
		return "Gms_Order [order_Id=" + order_Id + ", order_VenueId=" + order_VenueId + ", order_UserId=" + order_UserId
				+ ", order_Date=" + order_Date + ", order_St=" + order_St + ", order_Ed=" + order_Ed + ", order_State="
				+ order_State + ", order_Mktime2=" + order_Mktime2 + ", order_Price=" + order_Price + "]";
	}

}
