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

import com.SpaManagementSystem.ISD.model.Booking;
import com.SpaManagementSystem.ISD.repository.BookingRepository;

@RestController
@RequestMapping("/v1/booking")
public class BookingController {

	private BookingRepository repository;

	public BookingController(BookingRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<Booking> getAll() {
		return repository.findAll(Sort.by(Sort.Direction.DESC, "id"));
	}

	@PostMapping
	public Booking create(@RequestBody Booking booking) {
			return repository.save(booking);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Booking> findById(@PathVariable long id) {
		Optional<Booking> optionalBooking = repository.findById(id);
		if (!optionalBooking.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Booking with id: " + id + " cannot be found");
		} else {
			Booking booking = optionalBooking.get();
			return new ResponseEntity<Booking>(booking, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<Booking> update(@PathVariable long id, @RequestBody Booking newBooking) {
		Optional<Booking> optionalOldBooking = repository.findById(id);
		if (!optionalOldBooking.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Booking with id: " + id + " cannot be found");
		} else {
			Booking oldBooking = optionalOldBooking.get();
			oldBooking.setName(newBooking.getName());
			oldBooking.setDescription(newBooking.getDescription());
			oldBooking.setAddress(newBooking.getAddress());
			oldBooking.setService(newBooking.getService());
			oldBooking.setEmail(newBooking.getEmail());
			oldBooking.setPhone_number(newBooking.getPhone_number());
			oldBooking.setTime(newBooking.getTime());
			repository.save(oldBooking);
			return new ResponseEntity<Booking>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		Optional<Booking> tobeDeletedBooking = repository.findById(id);
		if (!tobeDeletedBooking.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Booking with id: " + id + " cannot be found");
		} else {
			Booking tobeDeleted = tobeDeletedBooking.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
