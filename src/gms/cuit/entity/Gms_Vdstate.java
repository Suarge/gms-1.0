package gms.cuit.entity;

import java.io.Serializable;
import java.util.Date;

public class Gms_Vdstate implements Serializable{

	/** 场馆编号 */
    private String vdstate_Id ;
    /** 日期 */
    private Date vdstate_Date ;
    /** 分时状态;第i位代表第i~i+1小时的场馆状态0代表不可用1代表可用2代表已经被预约 */
    private String vdstate_St ;
    
	public Gms_Vdstate() {
		super();
	}

	public Gms_Vdstate(String vdstate_Id, Date vdstate_Date, String vdstate_St) {
		super();
		this.vdstate_Id = vdstate_Id;
		this.vdstate_Date = vdstate_Date;
		this.vdstate_St = vdstate_St;
	}

	public String getVdstate_Id() {
		return vdstate_Id;
	}

	public void setVdstate_Id(String vdstate_Id) {
		this.vdstate_Id = vdstate_Id;
	}
	
	public void setVdstate_id(String vdstate_Id) {
		this.vdstate_Id = vdstate_Id;
	}

	public Date getVdstate_Date() {
		return vdstate_Date;
	}

	public void setVdstate_Date(Date vdstate_Date) {
		this.vdstate_Date = vdstate_Date;
	}
	
	public void setVdstate_date(Date vdstate_Date) {
		this.vdstate_Date = vdstate_Date;
	}

	public String getVdstate_St() {
		return vdstate_St;
	}

	public void setVdstate_St(String vdstate_St) {
		this.vdstate_St = vdstate_St;
	}
	
	public void setVdstate_st(String vdstate_St) {
		this.vdstate_St = vdstate_St;
	}

	@Override
	public String toString() {
		return "Gms_Vdstate [vdstate_Id=" + vdstate_Id + ", vdstate_Date=" + vdstate_Date + ", vdstate_St=" + vdstate_St
				+ "]";
	}

	
    
}
