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
@Table(name="product")
public class Product {

	@Id
	@Column(name="product_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	private String name;
	private double price;
	private String description;
	private String photo_dir;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="product_category_id")
	private ProductCategory productCategory;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="product_brand_id")
	private ProductBrand productBrand;
	
	
	
	public Product(long id, String name, double price, String description, String brand_name, String photo_dir, 
			ProductCategory productCategory, ProductBrand productBrand) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.description = description;
		this.photo_dir = photo_dir;
		this.productCategory = productCategory;
		this.productBrand = productBrand;
	}
	
	public Product() {
		
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
	public long getId() {
		return id;
	}

	public ProductCategory getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(ProductCategory productCategory) {
		this.productCategory = productCategory;
	}

	public ProductBrand getProductBrand() {
		return productBrand;
	}

	public void setProductBrand(ProductBrand productBrand) {
		this.productBrand = productBrand;
	}
	
	
}
