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

import com.SpaManagementSystem.ISD.model.Coupon;
import com.SpaManagementSystem.ISD.repository.CouponRepository;

@RestController
@RequestMapping("/v1/coupon")
public class CouponController {

	private CouponRepository repository;

	public CouponController(CouponRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<Coupon> getAll() {
		return repository.findAll();
	}

	@PostMapping
	public Coupon create(@RequestBody Coupon coupon) {
		Optional<Coupon> optionalCoupon = repository.findByCode(coupon.getCode());
		if (optionalCoupon.isPresent()) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The coupon with code: "+coupon.getCode()+" has already exist");
		} else if (coupon.getOffer() >= 100 || coupon.getOffer() <= 0)  {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The coupon offer must be in range of 0 and 100 percentage");
		} else {
			return repository.save(coupon);
		}
	}

	@GetMapping("/{id}")
	public ResponseEntity<Coupon> findById(@PathVariable long id) {
		Optional<Coupon> optionalCoupon = repository.findById(id);
		if (!optionalCoupon.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The coupon with id: "+id+" cannot be found");
		} else {
			Coupon coupon = optionalCoupon.get();
			return new ResponseEntity<Coupon>(coupon, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<Coupon> update(@PathVariable long id, @RequestBody Coupon newCoupon) {
		Optional<Coupon> optionalOldCoupon = repository.findById(id);
		if (!optionalOldCoupon.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The coupon with id: "+id+" cannot be found");
		} else {
			Coupon oldCoupon = optionalOldCoupon.get();
			Optional<Coupon> checkCouponCode = repository.findByCode(newCoupon.getCode());
			if (checkCouponCode.isPresent()) {
				throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The coupon with code: "+newCoupon.getCode()+" has already exist");
			} else {
				oldCoupon.setCode(newCoupon.getCode());
			}
			
			if (newCoupon.getOffer() >= 100 || newCoupon.getOffer() <= 0)  {
				throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The coupon offer must be in range of 0 and 100 percentage");
			} else {
				oldCoupon.setOffer(newCoupon.getOffer());
			}
			oldCoupon.setName(newCoupon.getName());
			oldCoupon.setDescription(newCoupon.getDescription());
			oldCoupon.setExpire_date(newCoupon.getExpire_date());
			oldCoupon.setService(newCoupon.getService());
			repository.save(oldCoupon);
			return new ResponseEntity<Coupon>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		Optional<Coupon> tobeDeletedCoupon = repository.findById(id);
		if (!tobeDeletedCoupon.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The coupon with id: "+id+" cannot be found");
		} else {
			Coupon tobeDeleted = tobeDeletedCoupon.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
