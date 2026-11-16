package com.orderservice.application;

import com.orderservice.domain.Order;
import com.orderservice.domain.OrderRepository;
import jakarta.validation.Valid;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class OrderService {
    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public Order createOrder(@Valid CreateOrderRequest request) {
        List<Order.OrderItem> items = request.getItems().stream()
                .map(item -> new Order.OrderItem(item.getProductId(), item.getQuantity(), item.getPrice()))
                .collect(Collectors.toList());

        Order order = new Order(request.getCustomerId(), items, "CREATED", 0.0);
        order.calculateTotalAmount();
        return orderRepository.save(order);
    }

    public Order getOrder(String id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new OrderNotFoundException("Order not found with id: " + id));
    }

    public Order updateOrder(String id, @Valid UpdateOrderRequest request) {
        Order order = orderRepository.findById(id)
                .orElseThrow(() -> new OrderNotFoundException("Order not found with id: " + id));

        order.setStatus(request.getStatus());
        return orderRepository.save(order);
    }

    public void deleteOrder(String id) {
        if (!orderRepository.findById(id).isPresent()) {
            throw new OrderNotFoundException("Order not found with id: " + id);
        }
        orderRepository.deleteById(id);
    }
}

class OrderNotFoundException extends RuntimeException {
    public OrderNotFoundException(String message) {
        super(message);
    }
}