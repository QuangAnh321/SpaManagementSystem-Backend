package com.SpaManagementSystem.ISD.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.SpaManagementSystem.ISD.model.Equipment;

@Repository
public interface EquipmentRepository extends JpaRepository<Equipment, Long> {

}
