package com.SpaManagementSystem.ISD.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="staff_category")
public class StaffCategory {

	@Id
	@Column(name="staff_category_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	private String name;

	public StaffCategory(long id, String name) {
		this.id = id;
		this.name = name;
	}
	
	public StaffCategory() {
		
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
}
