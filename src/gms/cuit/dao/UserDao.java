package gms.cuit.dao;

import java.sql.SQLException;

import gms.cuit.entity.Gms_User;

public interface UserDao {

	public int regist(Gms_User user) throws SQLException;

	public Gms_User login(String id, String password) throws SQLException;

	public void update_password(String username, String password) throws SQLException;

	public Long checkUsername(String userid) throws SQLException;

}
