package com.easybooking.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table (name = "marqueefoodservice")
public class MarqueeFoodService implements Serializable {
	
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@ManyToOne
    @JoinColumn (name="marquee_id")
	private Marquee marquees;
	
	@ManyToOne 
	@JoinColumn (name="food_service_id") 
	private FoodServices foodServices; 
	
	@Column (name="active")
	Byte active=1; 

	
	public MarqueeFoodService(){}
	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}


	public Marquee getMarquees() {
		return marquees;
	}


	public void setMarquees(Marquee marquees) {
		this.marquees = marquees;
	}


	public Byte getActive() {
		return active;
	}

	public void setActive(Byte active) {
		this.active = active;
	}


	public FoodServices getFoodServices() {
		return foodServices;
	}


	public void setFoodServices(FoodServices foodServices) {
		this.foodServices = foodServices;
	}





	
	
	
}
