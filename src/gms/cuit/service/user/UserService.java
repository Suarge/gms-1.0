package gms.cuit.service.user;

import gms.cuit.entity.Gms_User;

public interface UserService {

	public boolean register(Gms_User user);

	public Gms_User login(String id, String password);

	public void update_password(String username, String md5);

	public boolean checkUsername(String userid);

}
