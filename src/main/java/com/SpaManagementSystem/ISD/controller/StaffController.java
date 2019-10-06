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

import com.SpaManagementSystem.ISD.model.Staff;
import com.SpaManagementSystem.ISD.repository.StaffRepository;

@RestController
@RequestMapping("/v1/staff")
public class StaffController {

	private StaffRepository repository;

	public StaffController(StaffRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<Staff> getAllStaff() {
		return repository.findAll(Sort.by(Sort.Direction.DESC, "id"));
	}

	@PostMapping
	public Staff createStaff(@RequestBody Staff staff) {
		return repository.save(staff);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Staff> findStaffById(@PathVariable long id) {
		Optional<Staff> optionalStaff = repository.findById(id);
		if (!optionalStaff.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Staff with id: "+id+" cannot be found");
		} else {
			Staff staff = optionalStaff.get();
			return new ResponseEntity<Staff>(staff, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<Staff> updateStaff(@PathVariable long id, @RequestBody Staff newStaff) {
		Optional<Staff> optionalOldStaff = repository.findById(id);
		if (!optionalOldStaff.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Staff with id: "+id+" cannot be found");
		} else {
			Staff oldStaff = optionalOldStaff.get();
            oldStaff.setAddress(newStaff.getAddress());
            oldStaff.setEmail(newStaff.getEmail());
            oldStaff.setName(newStaff.getName());
            oldStaff.setPhone_number(newStaff.getPhone_number());
            oldStaff.setPhoto_dir(newStaff.getPhoto_dir());
            oldStaff.setStaffCategory(newStaff.getStaffCategory());
			repository.save(oldStaff);
			return new ResponseEntity<Staff>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> deleteService(@PathVariable("id") long id) {
		Optional<Staff> tobeDeletedStaff = repository.findById(id);
		if (!tobeDeletedStaff.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Staff with id: "+id+" cannot be found");
		} else {
			Staff tobeDeleted = tobeDeletedStaff.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
