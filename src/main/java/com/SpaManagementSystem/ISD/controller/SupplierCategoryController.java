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

import com.SpaManagementSystem.ISD.model.SupplierCategory;
import com.SpaManagementSystem.ISD.repository.SupplierCategoryRepository;;

@RestController
@RequestMapping("/v1/supplier-category")
public class SupplierCategoryController {

	private SupplierCategoryRepository repository;

	public SupplierCategoryController(SupplierCategoryRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<SupplierCategory> getAll() {
		return repository.findAll(Sort.by(Sort.Direction.DESC, "id"));
	}

	@PostMapping
	public SupplierCategory create(@RequestBody SupplierCategory supplierCategory) {
		return repository.save(supplierCategory);
	}

	@GetMapping("/{id}")
	public ResponseEntity<SupplierCategory> findById(@PathVariable long id) {
		Optional<SupplierCategory> optionalSupplierCategory = repository.findById(id);
		if (!optionalSupplierCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,
					"The supplier category with id: " + id + " cannot be found");
		} else {
			SupplierCategory supplierCategory = optionalSupplierCategory.get();
			return new ResponseEntity<SupplierCategory>(supplierCategory, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<SupplierCategory> update(@PathVariable long id,
			@RequestBody SupplierCategory newSupplierCategory) {
		Optional<SupplierCategory> optionalOldSupplierCategory = repository.findById(id);
		if (!optionalOldSupplierCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,
					"The supplier category with id: " + id + " cannot be found");
		} else {
			SupplierCategory oldSupplierCategory = optionalOldSupplierCategory.get();
			oldSupplierCategory.setName(newSupplierCategory.getName());
			repository.save(oldSupplierCategory);
			return new ResponseEntity<SupplierCategory>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		Optional<SupplierCategory> tobeDeletedSupplierCategory = repository.findById(id);
		if (!tobeDeletedSupplierCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,
					"The supplier category with id: " + id + " cannot be found");
		} else {
			SupplierCategory tobeDeleted = tobeDeletedSupplierCategory.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
