package com.SpaManagementSystem.ISD.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.SpaManagementSystem.ISD.model.SupplierCategory;

@Repository
public interface SupplierCategoryRepository extends JpaRepository<SupplierCategory, Long>{

}
