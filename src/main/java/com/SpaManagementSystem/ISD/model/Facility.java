package com.SpaManagementSystem.ISD.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="facility")
public class Facility {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	private String name;
	private double price;
	private int quantity;
	private String description;
	private int status;
	private String photo_dir;
	
	public Facility(long id, String name, double price, int quantity, String description, int status,
			String photo_dir) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.quantity = quantity;
		this.description = description;
		this.status = status;
		this.photo_dir = photo_dir;
	}
	
	public Facility() {
		
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
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getPhoto_dir() {
		return photo_dir;
	}
	public void setPhoto_dir(String photo_dir) {
		this.photo_dir = photo_dir;
	}

	
	
}
