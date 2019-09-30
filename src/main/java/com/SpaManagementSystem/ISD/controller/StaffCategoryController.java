package com.SpaManagementSystem.ISD.controller;

import java.util.List;
import java.util.Optional;

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

import com.SpaManagementSystem.ISD.model.StaffCategory;
import com.SpaManagementSystem.ISD.repository.StaffCategoryRepository;

@RestController
@RequestMapping("/v1/staff-category")
public class StaffCategoryController {
	private StaffCategoryRepository repository;

	public StaffCategoryController(StaffCategoryRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<StaffCategory> getAllStaffCategory() {
		return repository.findAll();
	}

	@PostMapping
	public StaffCategory createStaffCategory(@RequestBody StaffCategory StaffCategory) {
		return repository.save(StaffCategory);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Optional<StaffCategory>> findStaffCategoryById(@PathVariable long id) {
		Optional<StaffCategory> StaffCategory = repository.findById(id);
		if (!StaffCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The staff category with id: "+id+" cannot be found");
		} else {
			return new ResponseEntity<Optional<StaffCategory>>(StaffCategory, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<Optional<StaffCategory>> updateStaffCategory(@PathVariable long id, @RequestBody StaffCategory newStaffCategory) {
		Optional<StaffCategory> optionalOldStaffCategory = repository.findById(id);
		if (!optionalOldStaffCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The staff category with id: "+id+" cannot be found");
		} else {
			StaffCategory oldStaffCategory = optionalOldStaffCategory.get();
			oldStaffCategory.setName(newStaffCategory.getName());
			repository.save(oldStaffCategory);
			return new ResponseEntity<Optional<StaffCategory>>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		Optional<StaffCategory> tobeDeletedStaffCategory = repository.findById(id);
		if (!tobeDeletedStaffCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The staff category with id: "+id+" cannot be found");
		} else {
			StaffCategory tobeDeleted = tobeDeletedStaffCategory.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
