package com.SpaManagementSystem.ISD.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="service")
public class Service {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	private long service_group_id;
	private int code;
	private String name;
	private double price;
	private String description;
	private String photo_dir;
	
	public Service(long id, long service_group_id, int code, String name, double price, String description,
			String photo_dir) {
		super();
		this.id = id;
		this.service_group_id = service_group_id;
		this.code = code;
		this.name = name;
		this.price = price;
		this.description = description;
		this.photo_dir = photo_dir;
	}
	
	public Service() {
		
	}

	public long getId() {
		return id;
	}

	public long getService_group_id() {
		return service_group_id;
	}

	public void setService_group_id(long service_group_id) {
		this.service_group_id = service_group_id;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
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
	
	
}
