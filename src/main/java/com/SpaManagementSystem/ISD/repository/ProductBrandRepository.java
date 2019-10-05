package com.SpaManagementSystem.ISD.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.SpaManagementSystem.ISD.model.ProductBrand;

@Repository
public interface ProductBrandRepository extends JpaRepository<ProductBrand, Long> {

}
