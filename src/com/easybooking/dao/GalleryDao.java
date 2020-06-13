package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.Gallery;

public interface GalleryDao {
	public ArrayList<Gallery> getImage();
	public Gallery getDataById(int id);
	public Integer deleteImg(Gallery gallery);
	public Integer addImage(Gallery gallery);
}
