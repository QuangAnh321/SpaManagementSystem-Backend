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

import com.SpaManagementSystem.ISD.model.ProductCategory;
import com.SpaManagementSystem.ISD.repository.ProductCategoryRepository;

@RestController
@RequestMapping("/v1/product-category")
public class ProductCategoryController {

	private ProductCategoryRepository repository;

	public ProductCategoryController(ProductCategoryRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<ProductCategory> getAll() {
		return repository.findAll(Sort.by(Sort.Direction.DESC, "id"));
	}

	@PostMapping
	public ProductCategory create(@RequestBody ProductCategory productCategory) {
		return repository.save(productCategory);
	}

	@GetMapping("/{id}")
	public ResponseEntity<ProductCategory> findById(@PathVariable long id) {
		Optional<ProductCategory> optionalProductCategory = repository.findById(id);
		if (!optionalProductCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product category with id: "+id+" cannot be found");
		} else {
			ProductCategory productCategory = optionalProductCategory.get();
			return new ResponseEntity<ProductCategory>(productCategory, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<ProductCategory> update(@PathVariable long id, @RequestBody ProductCategory newProductCategory) {
		Optional<ProductCategory> optionalOldProductCategory = repository.findById(id);
		if (!optionalOldProductCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product category with id: "+id+" cannot be found");
		} else {
			ProductCategory oldProductCategory = optionalOldProductCategory.get();
			oldProductCategory.setName(newProductCategory.getName());
			repository.save(oldProductCategory);
			return new ResponseEntity<ProductCategory>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		Optional<ProductCategory> tobeDeletedProductCategory = repository.findById(id);
		if (!tobeDeletedProductCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product category with id: "+id+" cannot be found");
		} else {
			ProductCategory tobeDeleted = tobeDeletedProductCategory.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
