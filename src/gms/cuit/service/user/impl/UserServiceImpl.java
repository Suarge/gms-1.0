package gms.cuit.service.user.impl;

import java.sql.SQLException;

import gms.cuit.dao.UserDao;
import gms.cuit.dao.impl.UserDaoImpl;
import gms.cuit.entity.Gms_User;
import gms.cuit.service.user.UserService;

public class UserServiceImpl implements UserService {
	
	UserDao userdao = new UserDaoImpl();

	//用户注册
	public boolean register(Gms_User user) {
		int row = 0;
		try {
			row = userdao.regist(user);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return row>0?true:false;
	}

	//用户登录
	public Gms_User login(String id, String password) {
		Gms_User user = null;
		try {
			user = userdao.login(id,password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

	//修改密码
	public void update_password(String username, String password) {
		try {
			userdao.update_password(username,password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	//判断用户是否存在
	public boolean checkUsername(String userid) {
		Long isExist = 0L;
		try {
			isExist = userdao.checkUsername(userid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isExist>0?true:false;
	}

}
