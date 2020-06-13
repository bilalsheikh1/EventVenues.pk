package com.easybooking.model;
 
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
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GeneratorType;

@Entity
@Table (name = "booked") 
public class Booked { 
	@Id
	
	@GeneratedValue (strategy = GenerationType.IDENTITY) 
	private Integer id ;
  
	@ManyToOne
	@JoinColumn (name="bookingrequest_id") 
	private BookingRequest bookingRequest;    
	
	@Column (name="marquee_id")
	private Integer marquee_id; 
	
	@Column (name="active")
	private byte active= 1;
	
	public Booked(){}
	
	  
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
 
	public BookingRequest getBookingRequest() {
		return bookingRequest;
	}


	public void setBookingRequest(BookingRequest bookingRequest) {
		this.bookingRequest = bookingRequest;
	}


	public Integer getMarquee_id() {
		return marquee_id;
	}


	public void setMarquee_id(Integer marquee_id) {
		this.marquee_id = marquee_id;
	}
	
	
	
	
	
	
	
}
