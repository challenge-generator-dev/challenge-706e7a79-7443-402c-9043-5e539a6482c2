package com.orderservice.application;

import jakarta.validation.constraints.NotBlank;

public class UpdateOrderRequest {
    @NotBlank(message = "Status is required")
    private String status;

    public UpdateOrderRequest() {
    }

    public UpdateOrderRequest(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}