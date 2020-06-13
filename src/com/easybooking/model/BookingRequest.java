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
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

@Entity
@Table (name="bookingrequest")

public class BookingRequest {
	
	@Id 
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Integer id ;

	@Column (name="bookName")
	private String bookName="";
	
	@Column (name="shift")
	private String shift="";
	
	@Column (name= "contact")
	private String contact="";
	
	@Column (name="capacity") 
	private Integer capacity; 
	  
	@Column (name = "cost")
	private Double cost=0.0; 
	
	@Column (name = "advance")
	private Double advance=0.0; 
	
	@Column (name = "bookedDate")
	private String bookedDate; 
	
	@Column (name="updatedAt") 
	private String updatedAt;
	
	@Column (name="eventName")     
	private String eventName="";
	
	@Column (name ="cancel_by" )
	private Integer cancel_by;
	
	@Column (name ="active" )
	private Byte active=1;
	
	@ManyToOne
	@JoinColumn(name= "marquee_id" )
	private Marquee marquee_id;
	
	@ManyToOne
	@JoinColumn(name= "portion_id" )
	private Portion portion_id; 
	    
	@ManyToOne   
	@JoinColumn (name= "user_id") 
	private User user_id;
     
	@OneToMany  (mappedBy ="bookingRequest" ,cascade=CascadeType.ALL) 
	private Set<Booked> booked;
	  
	public BookingRequest() {
		// TODO Auto-generated constructor stub
 	}
	
 	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getShift() {
		return shift;
	}

	public void setShift(String shift) {
		this.shift = shift;
	}

	public Integer getCapacity() {
		return capacity;
	}

	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}
	public Double getCost() {
		return cost;
	}
	public void setCost(Double cost) {
		this.cost = cost;
	}


	public String getBookedDate() {
		return bookedDate;
	}

	public void setBookedDate(String bookedDate) {
		this.bookedDate = bookedDate;
	}

	public String getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(String updatedAt) {
		this.updatedAt = updatedAt;
	}

	public Integer getCancel_by() {
		return cancel_by;
	}

	public void setCancel_by(Integer cancel_by) {
		this.cancel_by = cancel_by;
	}

	
	
	public User getUser_id() {
		return user_id;
	}


	public void setUser_id(User user_id) {
		this.user_id = user_id;
	}


	public String getEventName() {
		return eventName;
	}
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}


	public Set<Booked> getBooked() {
		return booked;
	}


	public void setBooked(Set<Booked> booked) {
		this.booked = booked;
	}


	public String getContact() {
		return contact;
	}


	public void setContact(String contact) {
		this.contact = contact;
	}


	public Byte getActive() {
		return active;
	}


	public void setActive(Byte active) {
		this.active = active;
	}


	public Marquee getMarquee() {
		return marquee_id;
	}

  
	public void setMarquee(Marquee marquee) {
		this.marquee_id = marquee;
	}


	public String getBookName() {
		return bookName;
	}


	public void setBookName(String bookName) {
		this.bookName = bookName;
	}


	public Double getAdvance() {
		return advance;
	}


	public void setAdvance(Double advance) {
		this.advance = advance;
	}


	public Portion getPortion() {
		return portion_id;
	}

 
	public void setPortion(Portion portion) {
		this.portion_id = portion;
	}


     	    
	

}
