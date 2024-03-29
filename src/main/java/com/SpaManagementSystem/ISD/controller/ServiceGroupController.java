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

import com.SpaManagementSystem.ISD.model.ServiceGroup;
import com.SpaManagementSystem.ISD.repository.ServiceGroupRepository;

@RestController
@RequestMapping("/v1/service-group")
public class ServiceGroupController {
	private ServiceGroupRepository repository;

	public ServiceGroupController(ServiceGroupRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<ServiceGroup> getAll() {
		return repository.findAll(Sort.by(Sort.Direction.DESC, "id"));
	}

	@PostMapping
	public ServiceGroup create(@RequestBody ServiceGroup serviceGroup) {
		return repository.save(serviceGroup);
	}

	@GetMapping("/{id}")
	public ResponseEntity<ServiceGroup> findById(@PathVariable long id) {
		Optional<ServiceGroup> optionalServiceGroup = repository.findById(id);
		if (!optionalServiceGroup.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The service group with id: "+id+" cannot be found");
		} else {
			ServiceGroup serviceGroup = optionalServiceGroup.get();
			return new ResponseEntity<ServiceGroup>(serviceGroup, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<ServiceGroup> update(@PathVariable long id, @RequestBody ServiceGroup newServiceGroup) {
		Optional<ServiceGroup> optionalOldServiceGroup = repository.findById(id);
		if (!optionalOldServiceGroup.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The service group with id: "+id+" cannot be found");
		} else {
			ServiceGroup oldServiceGroup = optionalOldServiceGroup.get();
			oldServiceGroup.setName(newServiceGroup.getName());
			repository.save(oldServiceGroup);
			return new ResponseEntity<ServiceGroup>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		Optional<ServiceGroup> tobeDeletedServiceGroup = repository.findById(id);
		if (!tobeDeletedServiceGroup.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The service group with id: "+id+" cannot be found");
		} else {
			ServiceGroup tobeDeleted = tobeDeletedServiceGroup.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
