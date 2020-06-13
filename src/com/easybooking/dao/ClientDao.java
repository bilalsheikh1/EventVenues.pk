package com.easybooking.dao;

import java.util.ArrayList;

import com.easybooking.model.Client;

public interface ClientDao {
	public ArrayList<Client> getClients();
	public Integer insertClient(Client client);
	public Integer updateClient(Client client);
	public Integer deleteClient(Client client);
	public Client getDataById(int id);
}
