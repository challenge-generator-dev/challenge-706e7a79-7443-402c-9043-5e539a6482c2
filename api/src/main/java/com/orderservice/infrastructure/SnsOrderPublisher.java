package com.orderservice.infrastructure;

import com.amazonaws.services.sns.AmazonSNS;
import com.amazonaws.services.sns.model.PublishRequest;
import com.amazonaws.services.sns.model.PublishResult;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.orderservice.domain.Order;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class SnsOrderPublisher {

    private static final Logger logger = LoggerFactory.getLogger(SnsOrderPublisher.class);
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ISO_LOCAL_DATE_TIME;

    private final AmazonSNS amazonSNS;
    private final ObjectMapper objectMapper;
    private final String topicArn;

    public SnsOrderPublisher(
            AwsConfig awsConfig,
            ObjectMapper objectMapper,
            @Value("${aws.sns.topic-arn:}") String topicArn) {
        this.amazonSNS = awsConfig.amazonSNS();
        this.objectMapper = objectMapper;
        this.topicArn = topicArn;
    }

    public void publishOrderCreated(Order order) {
        if (topicArn == null || topicArn.isBlank()) {
            logger.warn("SNS topic ARN no configurado, omitiendo publicación de orden creada: {}", order.getId());
            return;
        }

        try {
            Map<String, Object> message = buildOrderMessage(order, "ORDER_CREATED");
            String jsonMessage = objectMapper.writeValueAsString(message);

            PublishRequest request = new PublishRequest()
                    .withTopicArn(topicArn)
                    .withSubject("Nueva orden creada")
                    .withMessage(jsonMessage)
                    .withMessageGroupId(order.getCustomerId());

            PublishResult result = amazonSNS.publish(request);
            logger.info("Orden {} publicada en SNS con mensaje ID: {}", order.getId(), result.getMessageId());
        } catch (JsonProcessingException e) {
            logger.error("Error al serializar mensaje de orden {}: {}", order.getId(), e.getMessage());
            throw new RuntimeException("Error al publicar orden en SNS", e);
        } catch (Exception e) {
            logger.error("Error al publicar orden {} en SNS: {}", order.getId(), e.getMessage());
            throw new RuntimeException("Error al publicar orden en SNS", e);
        }
    }

    public void publishOrderUpdated(Order order) {
        if (topicArn == null || topicArn.isBlank()) {
            logger.warn("SNS topic ARN no configurado, omitiendo publicación de orden actualizada: {}", order.getId());
            return;
        }

        try {
            Map<String, Object> message = buildOrderMessage(order, "ORDER_UPDATED");
            String jsonMessage = objectMapper.writeValueAsString(message);

            PublishRequest request = new PublishRequest()
                    .withTopicArn(topicArn)
                    .withSubject("Orden actualizada")
                    .withMessage(jsonMessage)
                    .withMessageGroupId(order.getCustomerId());

            PublishResult result = amazonSNS.publish(request);
            logger.info("Orden {} actualizada publicada en SNS con mensaje ID: {}", order.getId(), result.getMessageId());
        } catch (JsonProcessingException e) {
            logger.error("Error al serializar mensaje de orden actualizada {}: {}", order.getId(), e.getMessage());
            throw new RuntimeException("Error al publicar orden actualizada en SNS", e);
        } catch (Exception e) {
            logger.error("Error al publicar orden actualizada {} en SNS: {}", order.getId(), e.getMessage());
            throw new RuntimeException("Error al publicar orden actualizada en SNS", e);
        }
    }

    public void publishOrderDeleted(String orderId, String customerId) {
        if (topicArn == null || topicArn.isBlank()) {
            logger.warn("SNS topic ARN no configurado, omitiendo publicación de orden eliminada: {}", orderId);
            return;
        }

        try {
            Map<String, Object> message = new HashMap<>();
            message.put("eventType", "ORDER_DELETED");
            message.put("orderId", orderId);
            message.put("customerId", customerId);
            message.put("timestamp", LocalDateTime.now().format(FORMATTER));

            String jsonMessage = objectMapper.writeValueAsString(message);

            PublishRequest request = new PublishRequest()
                    .withTopicArn(topicArn)
                    .withSubject("Orden eliminada")
                    .withMessage(jsonMessage)
                    .withMessageGroupId(customerId);

            PublishResult result = amazonSNS.publish(request);
            logger.info("Orden {} eliminada publicada en SNS con mensaje ID: {}", orderId, result.getMessageId());
        } catch (JsonProcessingException e) {
            logger.error("Error al serializar mensaje de orden eliminada {}: {}", orderId, e.getMessage());
            throw new RuntimeException("Error al publicar orden eliminada en SNS", e);
        } catch (Exception e) {
            logger.error("Error al publicar orden eliminada {} en SNS: {}", orderId, e.getMessage());
            throw new RuntimeException("Error al publicar orden eliminada en SNS", e);
        }
    }

    private Map<String, Object> buildOrderMessage(Order order, String eventType) {
        Map<String, Object> message = new HashMap<>();
        message.put("eventType", eventType);
        message.put("orderId", order.getId());
        message.put("customerId", order.getCustomerId());
        message.put("status", order.getStatus());
        message.put("totalAmount", order.getTotalAmount());
        message.put("createdAt", order.getCreatedAt() != null ? order.getCreatedAt().format(FORMATTER) : null);
        message.put("timestamp", LocalDateTime.now().format(FORMATTER));

        if (order.getItems() != null) {
            List<Map<String, Object>> itemsList = order.getItems().stream()
                    .map(item -> {
                        Map<String, Object> itemMap = new HashMap<>();
                        itemMap.put("productId", item.getProductId());
                        itemMap.put("quantity", item.getQuantity());
                        itemMap.put("price", item.getPrice());
                        return itemMap;
                    })
                    .toList();
            message.put("items", itemsList);
        }

        return message;
    }
}