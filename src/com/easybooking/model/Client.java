package com.easybooking.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.easybooking.model.Common;
import com.easybooking.model.Marquee;

@Entity
@Table (name="Client")

public class Client extends Common implements Serializable{
	
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column ( name="name" )
	private String name="";
	
	@Column ( name="email" )
	private String email="";
	
	@Column ( name="password" )
	private String password="";
	
	@Column ( name="contact" )
	private String contact="";
	
	@Column ( name="cnic" )
	private String cnic="";

	@Column (name="active")
	private Byte active = 1;
	
	@Column (name = "facebook_login_id")
	Integer facebook_login_id;
	
	@Column (name = "google_login_id")
	Integer google_login_id;
	
	@OneToMany
	@JoinColumn (name= "marquee_id")
	private Set<Marquee> marquees;
	
	public Client() {
		// TODO Auto-generated constructor stub
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getCnic() {
		return cnic;
	}

	public void setCnic(String cnic) {
		this.cnic = cnic;
	}

	public Byte getActive() {
		return active;
	}

	public void setActive(Byte active) {
		this.active = active;
	}

	public Integer getFacebook_login_id() {
		return facebook_login_id;
	}

	public void setFacebook_login_id(Integer facebook_login_id) {
		this.facebook_login_id = facebook_login_id;
	}

	public Integer getGoogle_login_id() {
		return google_login_id;
	}

	public void setGoogle_login_id(Integer google_login_id) {
		this.google_login_id = google_login_id;
	}

	public Set<Marquee> getMarquees() {
		return marquees;
	}

	public void setMarquees(Set<Marquee> marquees) {
		this.marquees = marquees;
	}
	

}
