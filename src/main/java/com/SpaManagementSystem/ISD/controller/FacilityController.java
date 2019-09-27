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

//	@GetMapping("/{id}")
//	public ResponseEntity<Facility> findFacilityById(@PathVariable long id) {
//		return facilityRepository.findById(id).map(facility -> ResponseEntity.ok().body(facility))
//				.orElse(ResponseEntity.notFound().build());
////				.orElseThrow(() -> new ResourceNotFoundException("Facility with id: "+id+" Not Found"));
//	}
//
//	@PutMapping("/{id}")
//	public ResponseEntity<Facility> updateFacility(@PathVariable long id, @RequestBody Facility newFacility) {
//		return facilityRepository.findById(id).map(facility -> {
//			facility.setName(newFacility.getName());
//			facility.setPrice(newFacility.getPrice());
//			facility.setDescription(newFacility.getDescription());
//			facility.setQuantity(newFacility.getQuantity());
//			facility.setStatus(newFacility.getStatus());
//			facility.setPhoto_dir(newFacility.getPhoto_dir());
//			Facility updated = facilityRepository.save(facility);
//			return ResponseEntity.ok().body(updated);
//		}).orElse(ResponseEntity.notFound().build());
//	}
//
//	@DeleteMapping("/{id}")
//	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
//		return facilityRepository.findById(id).map(facility -> {
//			facilityRepository.deleteById(id);
//			return ResponseEntity.ok().build();
//		}).orElse(ResponseEntity.notFound().build());
//	}
	
	@GetMapping("/{id}")
	public ResponseEntity<Optional<Facility>> findBranchById(@PathVariable long id) {
		Optional<Facility> facility = repository.findById(id);
		if (!facility.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The facility with id: "+id+" cannot be found");
		} else {
			return new ResponseEntity<Optional<Facility>>(facility, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<Optional<Facility>> updateFacility(@PathVariable long id, @RequestBody Facility newFacility) {
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
			return new ResponseEntity<Optional<Facility>>(HttpStatus.OK);
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
