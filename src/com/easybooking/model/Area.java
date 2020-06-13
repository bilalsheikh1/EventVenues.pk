package com.easybooking.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

@Entity
@Table (name = "area")
public class Area {
	
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Integer id ;
	
	@Column (name="active")
	private byte active = 0;
	
	@Column (name = "name") 
	private String name ="";
	
	@ManyToOne
	@JoinColumn (name = "city_id")
	private City city;

	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public byte getActive() {
		return active;
	}

	public void setActive(byte active) {
		this.active = active;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public City getCity() {
		return city;
	}

	public void setCity(City city) {
		this.city = city;
	}
	
	
}
