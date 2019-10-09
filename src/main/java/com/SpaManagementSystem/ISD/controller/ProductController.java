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
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.SpaManagementSystem.ISD.model.Product;
import com.SpaManagementSystem.ISD.repository.ProductRepository;

@RestController
public class ProductController {

	private ProductRepository repository;

	public ProductController(ProductRepository repository) {
		this.repository = repository;
	}

	@GetMapping("/v1/product")
	public List<Product> getAllProduct() {
		return repository.findAll(Sort.by(Sort.Direction.DESC, "id"));
	}

//	@GetMapping("/v1/product/{id}")
//	public List<Product> getAllProductByProductCategory(@PathVariable Long id) {
//		Optional<ProductCategory> optionalProductCategory = productCategoryRepository.findById(id);
//		if(!optionalProductCategory.isPresent()) {
//			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product category with id: "+id+" cannot be found");
//		}
//		List<Product> productList = productRepository.findAllByProductCategoryId(id);
//		return productList;
//	}

	@GetMapping("/v1/product/{id}")
	public ResponseEntity<Product> getProductById(@PathVariable("id") long productId) {
		Optional<Product> optionalProduct = repository.findById(productId);
		if (!optionalProduct.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,
					"The product with id: " + productId + " cannot be found");
		} else {
			Product product = optionalProduct.get();
			return new ResponseEntity<Product>(product, HttpStatus.OK);
		}
	}

	@PostMapping("/v1/product/")
	public Product createProduct(@RequestBody Product product) {
		return repository.save(product);
	}

	@PutMapping("/v1/product/{id}")
	public ResponseEntity<Product> updateProduct(@PathVariable("id") long productId, @RequestBody Product newProduct) {
		Optional<Product> optionalOldProduct = repository.findById(productId);
		if (!optionalOldProduct.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,
					"The product with id: " + productId + " cannot be found");
		} else {
			Product oldProduct = optionalOldProduct.get();
			oldProduct.setName(newProduct.getName());
			oldProduct.setPhoto_dir(newProduct.getPhoto_dir());
			oldProduct.setBrand(newProduct.getBrand());
			oldProduct.setDescription(newProduct.getDescription());
			oldProduct.setProductCategory(newProduct.getProductCategory());
			repository.save(oldProduct);
			return new ResponseEntity<Product>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/v1/product/{id}")
	public ResponseEntity<Object> deleteProduct(@PathVariable("id") long productId) {
		Optional<Product> tobeDeletedProduct = repository.findById(productId);
		if (!tobeDeletedProduct.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,
					"The product with id: " + productId + " cannot be found");
		} else {
			Product tobeDeleted = tobeDeletedProduct.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
