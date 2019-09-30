package com.SpaManagementSystem.ISD.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.SpaManagementSystem.ISD.model.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

	public List<Product> findAllByProductCategoryId(Long product_category_id);
}
