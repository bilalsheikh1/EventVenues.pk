package com.easybooking.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.Where;

@Entity
@Table (name = "foodservices" )

public class FoodServices implements Serializable {
	
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Integer id ;
	
	@Column (name = "type")
	private String name;
	
	@Column (name = "active")
	private Byte active = 1;
	
//	@OneToMany/Service;
	
//	@ManyToMany (cascade = { CascadeType.PERSIST})
//	@JoinTable (name="marquee_food_service" , 
//				joinColumns= {@JoinColumn (name= "food_service_id" )},
//				inverseJoinColumns={@JoinColumn(name="marquee_id")})
//	private Set<Marquee> marquees; 
	 
	@ManyToOne
	@JoinColumn (name="marquee_id")
	private Marquee marquee;
	
	@OneToMany (mappedBy = "foodServices" )
    private Set<MarqueeFoodService> marqueeFoodServices = new HashSet<MarqueeFoodService>(); 

	
	

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Byte getActive() {
		return active;
	}

	public void setActive(Byte active) {
		this.active = active;
	}

	public Set<MarqueeFoodService> getMarqueeFoodServices() {
		return marqueeFoodServices;
	}

	public void setMarqueeFoodServices(Set<MarqueeFoodService> marqueeFoodServices) {
		this.marqueeFoodServices = marqueeFoodServices;
	}

	public Marquee getMarquee() {
		return marquee;
	}

	public void setMarquee(Marquee marquee) {
		this.marquee = marquee;
	}



	
}
