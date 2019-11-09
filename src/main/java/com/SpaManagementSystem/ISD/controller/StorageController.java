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

import com.SpaManagementSystem.ISD.model.Storage;
import com.SpaManagementSystem.ISD.repository.StorageRepository;

@RestController
@RequestMapping("/v1/storage")
public class StorageController {

	private StorageRepository repository;

	public StorageController(StorageRepository repository) {
		this.repository = repository;
	}

	@GetMapping
	public List<Storage> getAll() {
		return repository.findAll(Sort.by(Sort.Direction.DESC, "id"));
	}

	@PostMapping
	public Storage create(@RequestBody Storage storage) {
		return repository.save(storage);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Storage> findById(@PathVariable long id) {
		Optional<Storage> optionalStorage = repository.findById(id);
		if (!optionalStorage.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Storage with id: " + id + " cannot be found");
		} else {
			Storage Storage = optionalStorage.get();
			return new ResponseEntity<Storage>(Storage, HttpStatus.OK);
		}
	}

	@PutMapping("/{id}")
	public ResponseEntity<Storage> update(@PathVariable long id, @RequestBody Storage newStorage) {
		Optional<Storage> optionalOldStorage = repository.findById(id);
		if (!optionalOldStorage.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Storage with id: " + id + " cannot be found");
		} else {
			Storage oldStorage = optionalOldStorage.get();
			oldStorage.setImport(newStorage.isImport());
			oldStorage.setPrice(newStorage.getPrice());
			oldStorage.setProduct(newStorage.getProduct());
			oldStorage.setQuantity(newStorage.getQuantity());
			repository.save(oldStorage);
			return new ResponseEntity<Storage>(HttpStatus.OK);
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> delete(@PathVariable("id") long id) {
		Optional<Storage> tobeDeletedStorage = repository.findById(id);
		if (!tobeDeletedStorage.isPresent()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The Storage with id: " + id + " cannot be found");
		} else {
			Storage tobeDeleted = tobeDeletedStorage.get();
			repository.delete(tobeDeleted);
			return new ResponseEntity<Object>(HttpStatus.OK);
		}
	}

	// fixing
	@GetMapping("/product-quantity/{id}")
	public String getInStockProductQuantity(@PathVariable("id") long id) {
		List<Storage> allImportAndExport = repository.findByProduct_id(id);
		if (allImportAndExport.isEmpty()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,
					"No import or export with  product id: " + id + " can be found");
		}

		int initialQuantity = 0;
		long initialPrice = 0;
		for (int i = 0; i < allImportAndExport.size(); i++) {
			Storage storageOrder = allImportAndExport.get(i);
			long quantity = (long) storageOrder.getQuantity();
			if (storageOrder.isImport()) {
				initialPrice += quantity*storageOrder.getPrice();
				initialQuantity += quantity;
			} else {
				initialPrice -= quantity*storageOrder.getPrice();
				initialQuantity -= quantity;
			}
		}
		return initialQuantity+"/"+initialPrice;
	}
}
