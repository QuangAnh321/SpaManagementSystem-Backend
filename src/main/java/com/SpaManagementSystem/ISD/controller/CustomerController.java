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

import com.SpaManagementSystem.ISD.model.Customer;
import com.SpaManagementSystem.ISD.repository.CustomerRepository;

@RestController
@RequestMapping("/v1/customer")
public class CustomerController {
	private CustomerRepository repository;

	public CustomerController(CustomerRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<Customer> getAllCustomer() {
		return repository.findAll(Sort.by(Sort.Direction.DESC, "id"));
	}

	@PostMapping
	public Customer createCustomer(@RequestBody Customer customer) {
		return repository.save(customer);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Customer> findCustomerById(@PathVariable long id) {
		Optional<Customer> optionalCustomer = repository.findById(id);
		if (!optionalCustomer.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The customer with id: "+id+" cannot be found");
		} else {
			Customer customer = optionalCustomer.get();
			return new ResponseEntity<Customer>(customer, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<Customer> updateCustomer(@PathVariable long id, @RequestBody Customer newCustomer) {
		Optional<Customer> optionalOldCustomer = repository.findById(id);
		if (!optionalOldCustomer.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The customer with id: "+id+" cannot be found");
		} else {
			Customer oldCustomer = optionalOldCustomer.get();
			oldCustomer.setName(newCustomer.getName());
			oldCustomer.setGender(newCustomer.getGender());
			oldCustomer.setPhone_number(newCustomer.getPhone_number());
			oldCustomer.setAddress(newCustomer.getAddress());
			oldCustomer.setEmail(newCustomer.getEmail());
			repository.save(oldCustomer);
			return new ResponseEntity<Customer>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		Optional<Customer> tobeDeletedCustomer = repository.findById(id);
		if (!tobeDeletedCustomer.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The customer with id: "+id+" cannot be found");
		} else {
			Customer tobeDeleted = tobeDeletedCustomer.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
