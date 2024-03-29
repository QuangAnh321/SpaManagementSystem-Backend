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

import com.SpaManagementSystem.ISD.model.Branch;
import com.SpaManagementSystem.ISD.repository.BranchRepository;

@RestController
@RequestMapping("/v1/branch")
public class BranchController {

	private BranchRepository repository;

	public BranchController(BranchRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<Branch> getAll() {
		return repository.findAll();
	}

	@PostMapping
	public Branch create(@RequestBody Branch branch) {
		return repository.save(branch);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Branch> findById(@PathVariable long id) {
		Optional<Branch> optionalBranch = repository.findById(id);
		if (!optionalBranch.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The branch with id: "+id+" cannot be found");
		} else {
			Branch branch = optionalBranch.get();
			return new ResponseEntity<Branch>(branch, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<Branch> update(@PathVariable long id, @RequestBody Branch newBranch) {
		Optional<Branch> optionalOldBranch = repository.findById(id);
		if (!optionalOldBranch.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The branch with id: "+id+" cannot be found");
		} else {
			Branch oldBranch = optionalOldBranch.get();
			oldBranch.setName(newBranch.getName());
			oldBranch.setPhone_number(newBranch.getPhone_number());
			oldBranch.setDescription(newBranch.getDescription());
			oldBranch.setAddress(newBranch.getAddress());
			oldBranch.setEmail(newBranch.getEmail());
			oldBranch.setPhoto_dir(newBranch.getPhoto_dir());
			repository.save(oldBranch);
			return new ResponseEntity<Branch>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		Optional<Branch> tobeDeletedBranch = repository.findById(id);
		if (!tobeDeletedBranch.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The branch with id: "+id+" cannot be found");
		} else {
			Branch tobeDeleted = tobeDeletedBranch.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
