package com.easybooking.model;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GeneratorType;

@Entity
@Table (name="booked_services")

public class BookedServices {

	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@OneToMany
	private Set<FoodServices > services;
	
	@ManyToOne
	@JoinColumn (name= "marquee_id")
	private Marquee marquee;

	
	public BookedServices(){} 
	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Set<FoodServices> getServices() {
		return services;
	}

	public void setServices(Set<FoodServices> services) {
		this.services = services;
	}

	public Marquee getMarquee() {
		return marquee;
	}

	public void setMarquee(Marquee marquee) {
		this.marquee = marquee;
	}
	
	
}
