package com.easybooking.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public class Common implements Serializable{

	@Column ( name="createdAt" )
	String created_at;
	
	@Column ( name="updatedAt" )
	String updated_at;
	 
	@Column ( name="created_by" )
	private Integer created_by;
	
	@Column ( name="updated_by" )
	private Integer updated_by;

	
	public Common(){}
	
	
	 
	public Common(String created_at, String updated_at, Integer created_by, Integer updated_by ) {
		super();
		this.created_at = created_at;
		this.updated_at = updated_at;
		this.created_by = created_by;
		this.updated_by = updated_by;
	}



	public String getCreated_at() {
		return created_at;
	} 

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

	public String getUpdated_at() {
		return updated_at;
	}

	public void setUpdated_at(String updated_at) {
		this.updated_at = updated_at;
	}

	public Integer getCreated_by() {
		return created_by;
	}

	public void setCreated_by(Integer created_by) {
		this.created_by = created_by;
	}

	public Integer getUpdated_by() {
		return updated_by;
	}

	public void setUpdated_by(Integer updated_by) {
		this.updated_by = updated_by;
	}
	
	
	
}
