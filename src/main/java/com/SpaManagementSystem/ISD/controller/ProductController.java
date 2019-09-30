package com.SpaManagementSystem.ISD.controller;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.SpaManagementSystem.ISD.model.Product;
import com.SpaManagementSystem.ISD.model.ProductCategory;
import com.SpaManagementSystem.ISD.repository.ProductCategoryRepository;
import com.SpaManagementSystem.ISD.repository.ProductRepository;

@RestController
public class ProductController {

	private ProductRepository productRepository;
	private ProductCategoryRepository productCategoryRepository;
	
	public ProductController(ProductRepository repository, ProductCategoryRepository productCategoryRepository) {
		this.productRepository = repository;
		this.productCategoryRepository = productCategoryRepository;
	}
	
	@GetMapping("/v1/product")
	public List<Product> getAllProduct() {
		return productRepository.findAll();
	}
	
	@GetMapping("/v1/product_category/{id}/product")
	public List<Product> getAllProductByProductCategory(@PathVariable Long id) {
		Optional<ProductCategory> optionalProductCategory = productCategoryRepository.findById(id);
		if(!optionalProductCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product category with id: "+id+" cannot be found");
		}
		List<Product> productList = productRepository.findAllByProductCategoryId(id);
		return productList;
	}
	
	@GetMapping("/v1/product_category/{category_id}/product/{product_id}")
	public ResponseEntity<Product> getProductById(@PathVariable("product_id") long productId, @PathVariable("category_id") long productCategoryId) {
		Optional<Product> optionalProduct = productRepository.findById(productId);
		Optional<ProductCategory> optionalProductCategory = productCategoryRepository.findById(productCategoryId);
		if(!optionalProductCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product category with id: "+productCategoryId+" cannot be found");
		} else if(!optionalProduct.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product with id: "+productId+" cannot be found");
		} else {
			Product product = optionalProduct.get();
			return new ResponseEntity<Product>(product, HttpStatus.OK);
		}
	}
	
	@PostMapping("/v1/product_category/{id}/product")
	public ResponseEntity<Product> createProduct(@RequestBody Product product, @PathVariable Long id) {
		Optional<ProductCategory> optionalProductCategory = productCategoryRepository.findById(id);
		if(!optionalProductCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product category with id: "+id+" cannot be found");
		} else {
			ProductCategory productCategory = optionalProductCategory.get();
			product.setProductCategory(productCategory);
			productRepository.save(product);
			return new ResponseEntity<Product>(HttpStatus.OK);
		}
	}
	
	@PutMapping("/v1/product_category/{category_id}/product/{product_id}")
	public ResponseEntity<Product> updateProduct(@PathVariable("product_id") long productId, @PathVariable("category_id") long productCategoryId, @RequestBody Product newProduct, @RequestParam(name="newProductCategoryId", required=false) Long newProductCategoryId) {
		Optional<Product> optionalOldProduct = productRepository.findById(productId);
		Optional<ProductCategory> optionalOldProductCategory = productCategoryRepository.findById(productCategoryId);
		if(!optionalOldProductCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product category with id: "+productCategoryId+" cannot be found");
		} else if(!optionalOldProduct.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product with id: "+productId+" cannot be found");
		} else {
			Product oldProduct = optionalOldProduct.get();
			oldProduct.setName(newProduct.getName());
			oldProduct.setPhoto_dir(newProduct.getPhoto_dir());
			oldProduct.setPrice(newProduct.getPrice());
			oldProduct.setBrand_name(newProduct.getBrand_name());
			oldProduct.setDescription(newProduct.getDescription());
			if(!Objects.isNull(newProductCategoryId)) {
				Optional<ProductCategory> optionalNewProductCategory = productCategoryRepository.findById(newProductCategoryId);
				if(!optionalNewProductCategory.isPresent()) {
					throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product category with id: "+newProductCategoryId+" cannot be found");
				} else {
					ProductCategory newProductCategory =  optionalNewProductCategory.get();
					oldProduct.setProductCategory(newProductCategory);
				}
			}
			productRepository.save(oldProduct);
			return new ResponseEntity<Product>(HttpStatus.OK);
		}
	}
	
	@DeleteMapping("/v1/product_category/{category_id}/product/{product_id}")
	public ResponseEntity<Object> deleteProduct(@PathVariable("product_id") long productId, @PathVariable("category_id") long productCategoryId) {
		Optional<Product> tobeDeletedProduct = productRepository.findById(productId);
		Optional<ProductCategory> optionalProductCategory = productCategoryRepository.findById(productCategoryId);
		if(!optionalProductCategory.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product category with id: "+productCategoryId+" cannot be found");
		} else if(!tobeDeletedProduct.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The product with id: "+productId+" cannot be found");
		} else {
			Product tobeDeleted = tobeDeletedProduct.get();
			productRepository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}
}
