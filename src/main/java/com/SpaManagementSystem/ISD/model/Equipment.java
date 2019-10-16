package com.SpaManagementSystem.ISD.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;



@Entity
@Table(name="equipment")
public class Equipment {
	
	@Id
	@Column(name="equipment_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	private String name;
	private double price;
	private String description;
	private String photo_dir;
	
	@Enumerated(EnumType.STRING)
	private EquipmentStatus status;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="equipment_category_id")
	private EquipmentCategory equipmentCategory;
	
	public Equipment(long id, String name, double price, int quantity, String description, EquipmentStatus status,
			String photo_dir, EquipmentCategory equipmentCategory) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.status = status;
		this.photo_dir = photo_dir;
		this.equipmentCategory = equipmentCategory;
	}
	
	public Equipment() {
		
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

	public EquipmentStatus getStatus() {
		return status;
	}

	public void setStatus(EquipmentStatus status) {
		this.status = status;
	}

	public long getId() {
		return id;
	}

	public EquipmentCategory getEquipmentCategory() {
		return equipmentCategory;
	}

	public void setEquipmentCategory(EquipmentCategory equipmentCategory) {
		this.equipmentCategory = equipmentCategory;
	}
	
	
}
