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
	public List<Service> getAll() {
		return repository.findAll(Sort.by(Sort.Direction.DESC, "id"));
	}

	@PostMapping
	public Service create(@RequestBody Service Service) {
		return repository.save(Service);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Service> findById(@PathVariable long id) {
		Optional<Service> optionalService = repository.findById(id);
		if (!optionalService.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Service with id: "+id+" cannot be found");
		} else {
			Service service = optionalService.get();
			return new ResponseEntity<Service>(service, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<Service> update(@PathVariable long id, @RequestBody Service newService) {
		Optional<Service> optionalOldService = repository.findById(id);
		if (!optionalOldService.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Service with id: "+id+" cannot be found");
		} else {
			Service oldService = optionalOldService.get();
            oldService.setPrice(newService.getPrice());
			oldService.setName(newService.getName());
			oldService.setDescription(newService.getDescription());
			oldService.setPhoto_dir(newService.getPhoto_dir());
			oldService.setTime(newService.getTime());
			oldService.setServiceGroup(newService.getServiceGroup());
			repository.save(oldService);
			return new ResponseEntity<Service>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
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
