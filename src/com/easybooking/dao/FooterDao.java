package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.Footer;

public interface FooterDao {
	public Integer insertFooter(Footer footer);
	public Integer updateFooter(Footer footer);
	public Integer deleteFooter(Footer footer);
	public ArrayList<Footer> getFooterData();
	public Footer getDataById(int id);
}
