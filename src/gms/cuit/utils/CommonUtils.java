package gms.cuit.utils;

import java.util.UUID;

public class CommonUtils {

	//获得UUID
	public static String getUUID() {
		String s= UUID.randomUUID().toString();
        return s.replace("-", "");
	}

}
