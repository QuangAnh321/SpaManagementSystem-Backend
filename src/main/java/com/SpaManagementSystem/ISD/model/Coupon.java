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
@Table(name="coupon")
public class Coupon {

	@Id
	@Column(name="coupon_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	private String code;
	private String name;
	private int offer;
	private String expire_date;
	private String description;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="service_id")
	private Service service;
	
	public Coupon(long id, String code, String name, int offer, String expire_date, String description,
			Service service) {
		this.id = id;
		this.code = code;
		this.name = name;
		this.offer = offer;
		this.expire_date = expire_date;
		this.description = description;
		this.service = service;
	}
	
	public Coupon() {
		
	}

	public long getId() {
		return id;
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

	public int getOffer() {
		return offer;
	}

	public void setOffer(int offer) {
		this.offer = offer;
	}

	public String getExpire_date() {
		return expire_date;
	}

	public void setExpire_date(String expire_date) {
		this.expire_date = expire_date;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Service getService() {
		return service;
	}

	public void setService(Service service) {
		this.service = service;
	}
	
	
}
