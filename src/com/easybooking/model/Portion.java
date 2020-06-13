package com.easybooking.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table (name="Portion")


public class Portion extends Common implements Serializable{
	
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column (name="name")
	private String name;
	
	@Column (name="capacity")
	private String portionCapacity;  
	 
	@Column (name="active")
	private Byte active = 1;  
	
	@ManyToOne 
	@JoinColumn (name="marquee_id")
	private Marquee marquee;

	@OneToMany ( mappedBy ="portion_id" ,cascade=CascadeType.ALL ) 
	private Set<BookingRequest> bookingRequests ;
	
	public Portion(){
		
	}
	
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

	public String getPortionCapacity() {
		return portionCapacity;
	}

	public void setPortionCapacity(String portionCapacity) {
		this.portionCapacity = portionCapacity;
	}

	public Byte getActive() {
		return active;
	}

	public void setActive(Byte active) {
		this.active = active;
	}

	public Marquee getMarquee() {
		return marquee;
	}

	public void setMarquee(Marquee marquee) {
		this.marquee = marquee;
	}

	public Set<BookingRequest> getBookingRequests() {
		return bookingRequests;
	}

	public void setBookingRequests(Set<BookingRequest> bookingRequests) {
		this.bookingRequests = bookingRequests;
	}

	

	
	
	

}
