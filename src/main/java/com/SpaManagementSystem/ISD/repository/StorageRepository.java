package com.SpaManagementSystem.ISD.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.SpaManagementSystem.ISD.model.Storage;

@Repository
public interface StorageRepository extends JpaRepository<Storage, Long>{

	List<Storage> findByProduct_id(long id);
}
