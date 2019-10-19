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

import com.SpaManagementSystem.ISD.model.Equipment;
import com.SpaManagementSystem.ISD.repository.EquipmentRepository;

@RestController
@RequestMapping("/v1/equipment")
public class EquipmentController {

	private EquipmentRepository repository;

	public EquipmentController(EquipmentRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<Equipment> getAll() {
		return repository.findAll(Sort.by(Sort.Direction.DESC, "id"));
	}

	@PostMapping
	public Equipment create(@RequestBody Equipment equipment) {
		return repository.save(equipment);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Equipment> findById(@PathVariable long id) {
		Optional<Equipment> optionalEquipment = repository.findById(id);
		if (!optionalEquipment.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The equipment with id: "+id+" cannot be found");
		} else {
			Equipment equipment = optionalEquipment.get();
			return new ResponseEntity<Equipment>(equipment, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<Equipment> update(@PathVariable long id, @RequestBody Equipment newEquipment) {
		Optional<Equipment> optionalOldEquipment = repository.findById(id);
		if (!optionalOldEquipment.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The equipment with id: "+id+" cannot be found");
		} else {
			Equipment oldEquipment = optionalOldEquipment.get();
			oldEquipment.setName(newEquipment.getName());
			oldEquipment.setDescription(newEquipment.getDescription());
			oldEquipment.setPrice(newEquipment.getPrice());
			oldEquipment.setPhoto_dir(newEquipment.getPhoto_dir());
			oldEquipment.setStatus(newEquipment.getStatus());
			oldEquipment.setEquipmentCategory(newEquipment.getEquipmentCategory());
			repository.save(oldEquipment);
			return new ResponseEntity<Equipment>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		Optional<Equipment> tobeDeletedEquipment = repository.findById(id);
		if (!tobeDeletedEquipment.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The equipment with id: "+id+" cannot be found");
		} else {
			Equipment tobeDeleted = tobeDeletedEquipment.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
