package com.easybooking.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table (name = "payment" )
public class Payment {
	
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column (name="paymentDate")
	private String paymentdate="";
	
	@Column (name="whichMonthYearDate")
	private String whichMonthYearDate="";
	
	@Column (name="perMonth")
	private double perMonth=0;
	
	@Column (name = "perYear")
	private double perYear=0;
 	
	@Column (name="active")
	private byte active=1;
	
	@ManyToOne
	@JoinColumn (name="marquee_id")
	private Marquee marquees; 

	public Payment(){}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPaymentdate() {
		return paymentdate;
	}

	public void setPaymentdate(String paymentdate) {
		this.paymentdate = paymentdate;
	}

	public String getWhichMonthYearDate() {
		return whichMonthYearDate;
	}

	public void setWhichMonthYearDate(String whichMonthYearDate) {
		this.whichMonthYearDate = whichMonthYearDate;
	}

	public double getPerMonth() {
		return perMonth;
	}

	public void setPerMonth(double perMonth) {
		this.perMonth = perMonth;
	}

	public double getPerYear() {
		return perYear;
	}

	public void setPerYear(double perYear) {
		this.perYear = perYear;
	}

	public byte getActive() {
		return active;
	}

	public void setActive(byte active) {
		this.active = active;
	}

	public Marquee getMarquees() {
		return marquees;
	}

	public void setMarquees(Marquee marquees) {
		this.marquees = marquees;
	} 
	
	
	
	
}
