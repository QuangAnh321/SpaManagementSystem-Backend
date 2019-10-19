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
@Table(name="supplier")
public class Supplier {

	@Id
	@Column(name="supplier_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	private String code;
	private String name;
	private String address;
	private String phone_number;
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="supplier_category_id")
	private SupplierCategory supplierCategory;

	
	
	public Supplier(long id, String code, String name, String address, String phone_number, SupplierCategory supplierCategory) {
		this.id = id;
		this.code = code;
		this.name = name;
		this.address = address;
		this.phone_number = phone_number;
		this.supplierCategory = supplierCategory;
	}
	
	public Supplier() {
		
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone_number() {
		return phone_number;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}

	
	public SupplierCategory getSupplierCategory() {
		return supplierCategory;
	}

	public void setSupplierCategory(SupplierCategory supplierCategory) {
		this.supplierCategory = supplierCategory;
	}

	public long getId() {
		return id;
	}
	
	
	
}
