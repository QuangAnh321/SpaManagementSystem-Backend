package com.SpaManagementSystem.ISD.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="service")
public class Service {
	@Id
	@Column(name="service_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	private String name;
	private double price;
	private String description;
	private String photo_dir;
	private int time;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="service_group_id")
	private ServiceGroup serviceGroup;
	
	
	
	public Service(long id, String name, double price, String description,
			String photo_dir, int time, ServiceGroup serviceGroup) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.description = description;
		this.photo_dir = photo_dir;
		this.time = time;
		this.serviceGroup = serviceGroup;
	}
	
	public Service() {
		
	}

	public long getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPhoto_dir() {
		return photo_dir;
	}

	public void setPhoto_dir(String photo_dir) {
		this.photo_dir = photo_dir;
	}

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}

	public ServiceGroup getServiceGroup() {
		return serviceGroup;
	}

	public void setServiceGroup(ServiceGroup serviceGroup) {
		this.serviceGroup = serviceGroup;
	}
	
	
	
}
