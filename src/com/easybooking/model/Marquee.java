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
import javax.websocket.ClientEndpoint;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.Where;

@Entity
@Table (name = "Marquee")


public class Marquee implements Serializable {

	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column (name="name")
	private String name="";
	
	@Column (name="address")
	private String address="";
	
	@Column (name="address2")
	private String address2="";
	
	@Column (name="location")
	private String location="";
	
	@Column (name="contact")
	private String contact="";
	
	@Column (name="email")
	private String email="";
	
	@Column (name="rejectedReason")
	private String rejectedReason="";
	
	@Column (name="capacity")
	private Integer capacity;
	
	@Column ( name="createdAt" )
	String created_at;
	
	@Column ( name="updatedAt" )
	String updated_at;
	 
	@Column (name="active")
	private Byte active = 0 ;
	
	@ManyToOne
	@JoinColumn (name="created_by")
	private User user;
	  
	@OneToMany ( mappedBy ="marquee" , fetch = FetchType.EAGER) 
	private Set<Portion> portions ;
	   
	@OneToMany (targetEntity=Gallery.class,mappedBy ="marquee" ,fetch = FetchType.EAGER)
	private Set<Gallery> galleries = new HashSet<>();
	
	@OneToMany (targetEntity=MarqueeFoodService.class , mappedBy="marquees" ,fetch = FetchType.EAGER)
    private Set<MarqueeFoodService> marqueeFoodServices = new HashSet<MarqueeFoodService>();
	
	@OneToMany (targetEntity=Payment.class, mappedBy="marquees" ,fetch = FetchType.EAGER)
    private Set<Payment> payment = new HashSet<Payment>(); 
	
	@OneToMany (targetEntity=PayPayment.class, mappedBy="marquees" )
    private Set<PayPayment> payPayment;
	
	@OneToMany (targetEntity=FoodServices.class, mappedBy="marquee" )
    private Set<FoodServices> foodServices; 
	 
	@ManyToOne	
	@JoinColumn (name = "city_id") 
	private City city;
	 
	@ManyToOne	
	@JoinColumn (name = "area_id")
	private Area area;
	
	@OneToMany (mappedBy = "marquee_id")  
	private Set<BookingRequest> requests;
	 
	public Marquee(){}
	

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


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}

 	public String getContact() {
		return contact;
	}


	public void setContact(String contact) {
		this.contact = contact;
	}


	public String getEmail() {
	 	return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public Integer getCapacity() {
		return capacity;
	}


	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}


	public Byte getActive() {
		return active;
	}


	public void setActive(Byte active) {
		this.active = active;
	}


	public Set<Portion> getPortions() {
		return portions;
	}


	public void setPortions(Set<Portion> portions) {
		this.portions = portions;
	}


	public Set<Gallery> getGalleries() {
		return galleries;
	}


	public void setGalleries(Set<Gallery> galleries) {
		this.galleries = galleries;
	}


	public Set<MarqueeFoodService> getMarqueeFoodServices() {
		return marqueeFoodServices;
	}


	public void setMarqueeFoodServices(Set<MarqueeFoodService> marqueeFoodServices) {
		this.marqueeFoodServices = marqueeFoodServices;
	}


	public City getCity() {
		return city;
	}


	public void setCity(City city) {
		this.city = city;
	}


	public Area getArea() {
		return area;
	}


	public void setArea(Area area) {
		this.area = area;
	}


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}

    
	public Set<BookingRequest> getRequests() {
		return requests;
	}


	public void setRequests(Set<BookingRequest> requests) {
		this.requests = requests;
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


	public Set<Payment> getPayment() {
		return payment;
	}


	public void setPayment(Set<Payment> payment) {
		this.payment = payment;
	}


	public Set<PayPayment> getPayPayment() {
		return payPayment;
	}


	public void setPayPayment(Set<PayPayment> payPayment) {
		this.payPayment = payPayment;
	}


	public String getRejectedReason() {
		return rejectedReason;
	}


	public void setRejectedReason(String rejectedReason) {
		this.rejectedReason = rejectedReason;
	}


	public String getLocation() {
		return location;
	}


	public void setLocation(String location) {
		this.location = location;
	}


	public String getAddress2() {
		return address2;
	}


	public void setAddress2(String address2) {
		this.address2 = address2;
	}


	public Set<FoodServices> getFoodServices() {
		return foodServices;
	}


	public void setFoodServices(Set<FoodServices> foodServices) {
		this.foodServices = foodServices;
	}
	
	
}
