package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.Payment;

public interface PaymentDao {
	public Integer insertPaymentRecord(Payment payment);
	public Integer updatePaymentRecord(Payment payment);
	public Integer deletePaymentRecord(Payment payment);
	public Integer updatePaymentRecordActive0(int marquee_id);
	public Payment getDataByID(int id);
	public ArrayList<Payment> getPaymentRecord();
	public ArrayList<Payment> getPaymentPending();
}
