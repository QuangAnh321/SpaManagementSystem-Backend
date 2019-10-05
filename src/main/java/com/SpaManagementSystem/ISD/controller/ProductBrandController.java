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

import com.SpaManagementSystem.ISD.model.ProductBrand;
import com.SpaManagementSystem.ISD.repository.ProductBrandRepository;

@RestController
@RequestMapping("/v1/product_brand")
public class ProductBrandController {

	private ProductBrandRepository repository;

	public ProductBrandController(ProductBrandRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<ProductBrand> getAllProductBrand() {
		return repository.findAll();
	}

	@PostMapping
	public ProductBrand createProductBrand(@RequestBody ProductBrand productBrand) {
		return repository.save(productBrand);
	}

	@GetMapping("/{id}")
	public ResponseEntity<ProductBrand> findProductBrandById(@PathVariable long id) {
		Optional<ProductBrand> optionalProductBrand = repository.findById(id);
		if (!optionalProductBrand.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product brand with id: "+id+" cannot be found");
		} else {
			ProductBrand productBrand = optionalProductBrand.get();
			return new ResponseEntity<ProductBrand>(productBrand, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<ProductBrand> updateProductBrand(@PathVariable long id, @RequestBody ProductBrand newProductBrand) {
		Optional<ProductBrand> optionalOldProductBrand = repository.findById(id);
		if (!optionalOldProductBrand.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product brand with id: "+id+" cannot be found");
		} else {
			ProductBrand oldProductBrand = optionalOldProductBrand.get();
			oldProductBrand.setName(newProductBrand.getName());
			repository.save(oldProductBrand);
			return new ResponseEntity<ProductBrand>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> deleteProductBrand(@PathVariable("id") long id) {
		Optional<ProductBrand> tobeDeletedProductBrand = repository.findById(id);
		if (!tobeDeletedProductBrand.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product category with id: "+id+" cannot be found");
		} else {
			ProductBrand tobeDeleted = tobeDeletedProductBrand.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
