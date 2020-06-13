package com.easybooking.model;

import java.io.Serializable;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;

@Entity 
@Table (name="City")
//@Where (clause = "active = 1")  
public class City extends Common implements Serializable{
	
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column (name="name")
	private String name="";
	
	@Column (name="active")
	private Byte active = 1;
 	
	@OneToMany (mappedBy = "city")
	private Set<Marquee> marquees ;

	public City (){
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

	public Byte getActive() {
		return active;
	}

	public void setActive(Byte active) {
		this.active = active;
	}

	public Set<Marquee> getMarquees() {
		return marquees;
	}

	public void setMarquees(Set<Marquee> marquees) {
		this.marquees = marquees;
	}
}
