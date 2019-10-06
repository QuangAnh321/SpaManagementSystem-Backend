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
@Table(name="staff")
public class Staff {
	@Id
	@Column(name="staff_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	private String name;
	private String phone_number;
	private String email;
	private String address;
	private String photo_dir;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="staff_category_id")
	private StaffCategory staffCategory;
	
	
	public Staff(long id, String name, String gender, String phone_number, String email, String address, String photo_dir
			, StaffCategory staffCategory) {
		this.id = id;
		this.name = name;
		this.phone_number = phone_number;
		this.email = email;
		this.address = address;
		this.photo_dir = photo_dir;
		this.staffCategory = staffCategory;
	}
	
	public Staff() {
		
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhoto_dir() {
		return photo_dir;
	}

	public void setPhoto_dir(String photo_dir) {
		this.photo_dir = photo_dir;
	}

	public String getPhone_number() {
		return phone_number;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}

	public StaffCategory getStaffCategory() {
		return staffCategory;
	}

	public void setStaffCategory(StaffCategory staffCategory) {
		this.staffCategory = staffCategory;
	}
	
	
}
