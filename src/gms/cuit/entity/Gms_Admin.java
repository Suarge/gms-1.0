package gms.cuit.entity;

import java.io.Serializable;

public class Gms_Admin implements Serializable {

	/** 用户名 */
    private String admin_Username ;
    /** 密码 */
    private String admin_Password ;

	public Gms_Admin() {
		super();
	}

	public Gms_Admin(String admin_Username, String admin_Password) {
		super();
		this.admin_Username = admin_Username;
		this.admin_Password = admin_Password;
	}

	public String getAdmin_Username() {
		return admin_Username;
	}
	
	public void setAdmin_Username(String admin_Username) {
		this.admin_Username = admin_Username;
	}
	
	public void setAdmin_username(String admin_Username) {
		this.admin_Username = admin_Username;
	}
	
	public String getAdmin_Password() {
		return admin_Password;
	}

	public void setAdmin_Password(String admin_Password) {
		this.admin_Password = admin_Password;
	}
	
	public void setAdmin_password(String admin_Password) {
		this.admin_Password = admin_Password;
	}

	@Override
	public String toString() {
		return "Gms_Admin [admin_Username=" + admin_Username + ", admin_Password=" + admin_Password + "]";
	}

    
}
