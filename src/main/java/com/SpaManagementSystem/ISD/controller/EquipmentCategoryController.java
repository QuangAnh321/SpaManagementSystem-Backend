package com.SpaManagementSystem.ISD.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.SpaManagementSystem.ISD.model.EquipmentCategory;
import com.SpaManagementSystem.ISD.model.ProductCategory;
import com.SpaManagementSystem.ISD.repository.EquipmentCategoryRepository;;

@RestController
@RequestMapping("/v1/equipment-category")
public class EquipmentCategoryController {

	private EquipmentCategoryRepository repository;

	public EquipmentCategoryController(EquipmentCategoryRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<EquipmentCategory> getAll() {
		return repository.findAll(Sort.by(Sort.Direction.DESC, "id"));
	}

	@PostMapping
	public EquipmentCategory create(@RequestBody EquipmentCategory equipmentCategory) {
		return repository.save(equipmentCategory);
	}

	@GetMapping("/{id}")
	public ResponseEntity<EquipmentCategory> findById(@PathVariable long id) {
		Optional<EquipmentCategory> optionalEquipmentCategory = repository.findById(id);
		if (!optionalEquipmentCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The equipment category with id: "+id+" cannot be found");
		} else {
			EquipmentCategory equipmentCategory = optionalEquipmentCategory.get();
			return new ResponseEntity<EquipmentCategory>(equipmentCategory, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<EquipmentCategory> update(@PathVariable long id, @RequestBody EquipmentCategory newEquipmentCategory) {
		Optional<EquipmentCategory> optionalOldEquipmentCategory = repository.findById(id);
		if (!optionalOldEquipmentCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The equipment category with id: "+id+" cannot be found");
		} else {
			EquipmentCategory oldEquipmentCategory = optionalOldEquipmentCategory.get();
			oldEquipmentCategory.setName(newEquipmentCategory.getName());
			repository.save(oldEquipmentCategory);
			return new ResponseEntity<EquipmentCategory>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		Optional<EquipmentCategory> tobeDeletedEquipmentCategory = repository.findById(id);
		if (!tobeDeletedEquipmentCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The equipment category with id: "+id+" cannot be found");
		} else {
			EquipmentCategory tobeDeleted = tobeDeletedEquipmentCategory.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
