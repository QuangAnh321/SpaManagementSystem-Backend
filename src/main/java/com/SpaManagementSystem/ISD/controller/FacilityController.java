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

import com.SpaManagementSystem.ISD.model.Facility;
import com.SpaManagementSystem.ISD.repository.FacilityRepository;

@RestController
@RequestMapping("/v1/facility")
public class FacilityController {

	private FacilityRepository repository;

	public FacilityController(FacilityRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<Facility> getAllFacility() {
		return repository.findAll();
	}

	@PostMapping
	public Facility createFacility(@RequestBody Facility facility) {
		return repository.save(facility);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Facility> findBranchById(@PathVariable long id) {
		Optional<Facility> optionalFacility = repository.findById(id);
		if (!optionalFacility.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The facility with id: "+id+" cannot be found");
		} else {
			Facility facility = optionalFacility.get();
			return new ResponseEntity<Facility>(facility, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<Facility> updateFacility(@PathVariable long id, @RequestBody Facility newFacility) {
		Optional<Facility> optionalOldFacility = repository.findById(id);
		if (!optionalOldFacility.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The facility with id: "+id+" cannot be found");
		} else {
			Facility oldFacility = optionalOldFacility.get();
			oldFacility.setName(newFacility.getName());
			oldFacility.setDescription(newFacility.getDescription());
			oldFacility.setPrice(newFacility.getPrice());
			oldFacility.setPhoto_dir(newFacility.getPhoto_dir());
			oldFacility.setQuantity(newFacility.getQuantity());
			oldFacility.setStatus(newFacility.getStatus());
			repository.save(oldFacility);
			return new ResponseEntity<Facility>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> deleteFacility(@PathVariable("id") long id) {
		Optional<Facility> tobeDeletedFacility = repository.findById(id);
		if (!tobeDeletedFacility.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The facility with id: "+id+" cannot be found");
		} else {
			Facility tobeDeleted = tobeDeletedFacility.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
