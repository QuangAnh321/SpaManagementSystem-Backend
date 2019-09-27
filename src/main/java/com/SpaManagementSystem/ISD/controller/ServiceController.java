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

import com.SpaManagementSystem.ISD.model.Service;
import com.SpaManagementSystem.ISD.repository.ServiceRepository;

@RestController
@RequestMapping("/v1/service")
public class ServiceController {

	private ServiceRepository repository;

	public ServiceController(ServiceRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<Service> getAllService() {
		return repository.findAll();
	}

	@PostMapping
	public Service createService(@RequestBody Service Service) {
		return repository.save(Service);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Optional<Service>> findServiceById(@PathVariable long id) {
		Optional<Service> Service = repository.findById(id);
		if (!Service.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Service with id: "+id+" cannot be found");
		} else {
			return new ResponseEntity<Optional<Service>>(Service, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<Optional<Service>> updateService(@PathVariable long id, @RequestBody Service newService) {
		Optional<Service> optionalOldService = repository.findById(id);
		if (!optionalOldService.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Service with id: "+id+" cannot be found");
		} else {
			Service oldService = optionalOldService.get();
            oldService.setService_group_id(newService.getService_group_id());
            oldService.setCode(newService.getCode());
            oldService.setPrice(newService.getPrice());
			oldService.setName(newService.getName());
			oldService.setDescription(newService.getDescription());
			oldService.setPhoto_dir(newService.getPhoto_dir());
			repository.save(oldService);
			return new ResponseEntity<Optional<Service>>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> deleteService(@PathVariable("id") long id) {
		Optional<Service> tobeDeletedService = repository.findById(id);
		if (!tobeDeletedService.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Service with id: "+id+" cannot be found");
		} else {
			Service tobeDeleted = tobeDeletedService.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
