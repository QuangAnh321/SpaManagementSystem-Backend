package com.SpaManagementSystem.ISD.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="service_group")
public class ServiceGroup {
	
	@Id
	@Column(name="service_group_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	private String name;

	public ServiceGroup(long id, String name) {
		this.id = id;
		this.name = name;
	}
	
	public ServiceGroup() {
		
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
