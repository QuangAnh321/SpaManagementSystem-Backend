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

import com.SpaManagementSystem.ISD.model.Supplier;
import com.SpaManagementSystem.ISD.repository.SupplierRepository;

@RestController
@RequestMapping("/v1/supplier")
public class SupplierController {

	private SupplierRepository repository;

	public SupplierController(SupplierRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<Supplier> getAll() {
		return repository.findAll(Sort.by(Sort.Direction.DESC, "id"));
	}

	@PostMapping
	public Supplier create(@RequestBody Supplier supplier) {
		Optional<Supplier> optionalSupplier = repository.findByCode(supplier.getCode());
		if (optionalSupplier.isPresent()) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
					"The supplier with code: " + supplier.getCode() + " has already exist");
		} else {
			return repository.save(supplier);
		}
	}

	@GetMapping("/{id}")
	public ResponseEntity<Supplier> findById(@PathVariable long id) {
		Optional<Supplier> optionalSupplier = repository.findById(id);
		if (!optionalSupplier.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The supplier with id: " + id + " cannot be found");
		} else {
			Supplier Supplier = optionalSupplier.get();
			return new ResponseEntity<Supplier>(Supplier, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<Supplier> update(@PathVariable long id, @RequestBody Supplier newSupplier) {
		Optional<Supplier> optionalOldSupplier = repository.findById(id);
		if (!optionalOldSupplier.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The supplier with id: " + id + " cannot be found");
		} else {
			Supplier oldSupplier = optionalOldSupplier.get();
			if (!oldSupplier.getCode().equals(newSupplier.getCode())) {
				Optional<Supplier> checkSupplierCode = repository.findByCode(newSupplier.getCode());
				if (checkSupplierCode.isPresent()) {
					throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
							"The Supplier with code: " + newSupplier.getCode() + " has already exist");
				} else {
					oldSupplier.setCode(newSupplier.getCode());
				}
			}
			oldSupplier.setName(newSupplier.getName());
			oldSupplier.setAddress(newSupplier.getAddress());
			oldSupplier.setSupplierCategory(newSupplier.getSupplierCategory());
			oldSupplier.setPhone_number(newSupplier.getPhone_number());
			repository.save(oldSupplier);
			return new ResponseEntity<Supplier>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		Optional<Supplier> tobeDeletedSupplier = repository.findById(id);
		if (!tobeDeletedSupplier.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The supplier with id: " + id + " cannot be found");
		} else {
			Supplier tobeDeleted = tobeDeletedSupplier.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
