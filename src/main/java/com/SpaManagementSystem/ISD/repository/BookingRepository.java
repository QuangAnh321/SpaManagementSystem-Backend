package com.SpaManagementSystem.ISD.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.SpaManagementSystem.ISD.model.Booking;
import com.SpaManagementSystem.ISD.model.Coupon;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {

	
}
