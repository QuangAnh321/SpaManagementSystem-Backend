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

import com.SpaManagementSystem.ISD.model.Facility;
import com.SpaManagementSystem.ISD.repository.FacilityRepository;

@RestController
@RequestMapping("/SpaManagementSystem/facilityManagement")
public class FacilityController {

	private FacilityRepository facilityRepository;

	public FacilityController(FacilityRepository repository) {
		this.facilityRepository = repository;
	}

	@GetMapping
	public List<Facility> getAllFacility() {
		return facilityRepository.findAll();
	}

	@PostMapping
	public Facility createFacility(@RequestBody Facility facility) {
		return facilityRepository.save(facility);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Facility> findFacilityById(@PathVariable long id) {
		return facilityRepository.findById(id).map(facility -> ResponseEntity.ok().body(facility))
				.orElse(ResponseEntity.notFound().build());
	}

	@PutMapping("/{id}")
	public ResponseEntity<Facility> updateFacility(@PathVariable long id, @RequestBody Facility newFacility) {
		return facilityRepository.findById(id).map(facility -> {
			facility.setName(newFacility.getName());
			facility.setPrice(newFacility.getPrice());
			facility.setDescription(newFacility.getDescription());
			facility.setQuantity(newFacility.getQuantity());
			facility.setStatus(newFacility.getStatus());
			facility.setPhoto_dir(newFacility.getPhoto_dir());
			Facility updated = facilityRepository.save(facility);
			return ResponseEntity.ok().body(updated);
		}).orElse(ResponseEntity.notFound().build());
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		return facilityRepository.findById(id).map(facility -> {
			facilityRepository.deleteById(id);
			return ResponseEntity.ok().build();
		}).orElse(ResponseEntity.notFound().build());
	}
}
