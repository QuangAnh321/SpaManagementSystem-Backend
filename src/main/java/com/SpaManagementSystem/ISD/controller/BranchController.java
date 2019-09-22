package com.SpaManagementSystem.ISD.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.SpaManagementSystem.ISD.model.Branch;
import com.SpaManagementSystem.ISD.model.Facility;
import com.SpaManagementSystem.ISD.repository.BranchRepository;
import com.SpaManagementSystem.ISD.repository.FacilityRepository;

@RestController
@RequestMapping("/SpaManagementSystem/branchManagement")
public class BranchController {

	private BranchRepository repository;

	public BranchController(BranchRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<Branch> getAllFacility() {
		return repository.findAll();
	}

	@PostMapping
	public Branch createBranch(@RequestBody Branch branch) {
		return repository.save(branch);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Branch> findBranchById(@PathVariable long id) {
		return repository.findById(id).map(branch -> ResponseEntity.ok().body(branch))
				.orElse(ResponseEntity.notFound().build());
	}

	@PutMapping("/{id}")
	public ResponseEntity<Branch> updateBranch(@PathVariable long id, @RequestBody Branch newBranch) {
		return repository.findById(id).map(branch -> {
			branch.setName(newBranch.getName());
			branch.setPhone_number(newBranch.getPhone_number());
			branch.setDescription(newBranch.getDescription());
			branch.setAddress(newBranch.getAddress());
			branch.setEmail(newBranch.getEmail());
			branch.setPhoto_dir(newBranch.getPhoto_dir());
			Branch updated = repository.save(branch);
			return ResponseEntity.ok().body(updated);
		}).orElse(ResponseEntity.notFound().build());
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		return repository.findById(id).map(branch -> {
			repository.deleteById(id);
			return ResponseEntity.ok().build();
		}).orElse(ResponseEntity.notFound().build());
	}
}
