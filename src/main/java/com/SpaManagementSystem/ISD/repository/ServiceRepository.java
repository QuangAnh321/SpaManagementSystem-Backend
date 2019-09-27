package com.SpaManagementSystem.ISD.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.SpaManagementSystem.ISD.model.Service;

@Repository
public interface ServiceRepository extends JpaRepository<Service, Long>{

}
