package gms.cuit.web.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import gms.cuit.dao.OrderDao;
import gms.cuit.dao.impl.OrderDaoImpl;
import gms.cuit.entity.Gms_Vdstate;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

@WebListener
public class OrderStateChangeListener implements ServletContextListener {
    public OrderStateChangeListener() {
    }

    public void contextDestroyed(ServletContextEvent arg0)  { 
    }

    public void contextInitialized(ServletContextEvent arg0)  { 
    	//当web应用启动 开启任务调动---每1分钟监听订单状态,查看是否已经完成
		Timer timer = new Timer();
		final OrderDao dao = new OrderDaoImpl();
		timer.scheduleAtFixedRate(new TimerTask() {
			@Override
			public void run() {
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH");  
				String currenttime = formatter.format(new Date());
				String [] str= currenttime.split(" ");
				String date = str[0];
				String hour = str[1];
				int hourr = Integer.parseInt(hour);
				try {
					dao.UpateOrderStateByTime(date,hour);
					List<Gms_Vdstate> queryOrderStateByTime = dao.QueryOrderStateByTime(date);
					for(Gms_Vdstate vdstate:queryOrderStateByTime) {
						String tp = vdstate.getVdstate_St();
						for(int i=0;i<=hourr;i++) {
							if(tp.charAt(i)=='1') tp = tp.replaceFirst("1", "0");							
						}
						vdstate.setVdstate_St(tp);
						dao.UpateVdState(vdstate);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}, new Date(), 1000*60);
    }
}

