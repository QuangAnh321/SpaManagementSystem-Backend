package com.SpaManagementSystem.ISD.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="product_category")
public class ProductCategory {

	@Id
	@Column(name="product_category_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	private String name;
	
	public ProductCategory() {
		
	}
	
	public ProductCategory(long id, String name) {
		this.id = id;
		this.name = name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public long getId() {
		return id;
	}
	
	
}
