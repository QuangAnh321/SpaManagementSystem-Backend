package com.SpaManagementSystem.ISD.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.SpaManagementSystem.ISD.model.ServiceGroup;

@Repository
public interface ServiceGroupRepository extends JpaRepository<ServiceGroup, Long>{

}
