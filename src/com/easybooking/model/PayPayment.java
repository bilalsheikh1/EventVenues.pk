package com.easybooking.model;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table (name = "paypayment")
public class PayPayment {
	
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column (name="date")
	private String date="";
	
	@Column (name="paymentMonth")
	private String paymentMonth="";
	
	@Column (name="paymentYear")
	private String paymentYear="";
	
	@Column (name="marqueeCreaetedDate")
	private String marqueeCreaetedDate = "";
	
	@OneToMany
	private Set<Marquee> marquees;
	
	@OneToMany
	private Set<Payment> payments;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getPaymentMonth() {
		return paymentMonth;
	}

	public void setPaymentMonth(String paymentMonth) {
		this.paymentMonth = paymentMonth;
	}

	public String getMarqueeCreaetedDate() {
		return marqueeCreaetedDate;
	}

	public void setMarqueeCreaetedDate(String marqueeCreaetedDate) {
		this.marqueeCreaetedDate = marqueeCreaetedDate;
	}

	public Set<Marquee> getMarquees() {
		return marquees;
	}

	public void setMarquees(Set<Marquee> marquees) {
		this.marquees = marquees;
	}

	public Set<Payment> getPayments() {
		return payments;
	}

	public void setPayments(Set<Payment> payments) {
		this.payments = payments;
	}

	public String getPaymentYear() {
		return paymentYear;
	}

	public void setPaymentYear(String paymentYear) {
		this.paymentYear = paymentYear;
	}
	
	
	
	
}
