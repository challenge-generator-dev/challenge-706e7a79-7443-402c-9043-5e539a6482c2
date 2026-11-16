package com.orderservice.infrastructure;

import com.orderservice.domain.Order;
import com.orderservice.domain.OrderRepository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface OrderJpaRepository extends JpaRepository<Order, String>, OrderRepository {
    @Override
    default Order save(Order order) {
        return saveAndFlush(order);
    }

    @Override
    default Optional<Order> findById(String id) {
        return findById(id);
    }

    @Override
    default void deleteById(String id) {
        deleteById(id);
    }
}