package com.easybooking.config;

import java.util.Properties;



import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import com.easybooking.model.Admin;
import com.easybooking.model.Area;
import com.easybooking.model.BookedServices;
import com.easybooking.model.BookingRequest;
import com.easybooking.model.Booked;
import com.easybooking.model.City;
import com.easybooking.model.FoodServices;
import com.easybooking.model.Footer;
import com.easybooking.model.Gallery;
import com.easybooking.model.Marquee;
import com.easybooking.model.MarqueeFoodService;
import com.easybooking.model.PayPayment;
import com.easybooking.model.Payment;
import com.easybooking.model.Portion;
import com.easybooking.model.User;



public class HibernateUtil {
	
	public static SessionFactory getSesssionFactory(){
		SessionFactory factory ;
		Configuration configuration = new Configuration();
		
		Properties properties = new Properties();
		
		properties.put(Environment.DRIVER , "com.mysql.jdbc.Driver");
		properties.put(Environment.URL, "jdbc:mysql://localhost/easybooking");
		properties.put(Environment.DIALECT, "org.hibernate.dialect.MySQLDialect" );
		properties.put(Environment.USER, "root"); 
		properties.put(Environment.PASS, "");
		properties.put(Environment.SHOW_SQL, "true");
//		properties.put(Environment.HBM2DDL_AUTO, "update");
		
		configuration.setProperties(properties);
		configuration.addAnnotatedClass(User.class); 
		configuration.addAnnotatedClass(City.class);
		configuration.addAnnotatedClass(Marquee.class);
		configuration.addAnnotatedClass(Gallery.class);
		configuration.addAnnotatedClass(Portion.class);
		configuration.addAnnotatedClass(FoodServices.class);
		configuration.addAnnotatedClass(MarqueeFoodService.class);
		configuration.addAnnotatedClass(Area.class);
		configuration.addAnnotatedClass(Booked.class);
		configuration.addAnnotatedClass(BookedServices.class);
		configuration.addAnnotatedClass(BookingRequest.class);
		configuration.addAnnotatedClass(Admin.class);
		configuration.addAnnotatedClass(Payment.class);
		configuration.addAnnotatedClass(PayPayment.class);	
		configuration.addAnnotatedClass(Footer.class);
		
		
		ServiceRegistry registry =  new StandardServiceRegistryBuilder()
				.applySettings(configuration.getProperties()).build();
		
		
		factory = configuration.buildSessionFactory(registry);
		
		return factory;
	}
}

