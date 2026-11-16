# Stub: Exports de recursos de mensajería
# El estudiante debe exportar:
# - URL de la cola de órdenes
# - URL de la cola dead-letter
# - ARN del tema SNS
# - ARN de la suscripción

# TODO(reto): Exportar URL de cola de órdenes
output "orders_queue_url" {
  value       = aws_sqs_queue.orders.url
  description = "URL de la cola de órdenes"
}

# TODO(reto): Exportar URL de cola dead-letter
output "orders_dlq_url" {
  value       = aws_sqs_queue.orders_dlq.url
  description = "URL de la cola dead-letter para mensajes fallidos"
}

# TODO(reto): Exportar ARN del tema SNS
output "orders_topic_arn" {
  value       = aws_sns_topic.orders.arn
  description = "ARN del tema SNS para notificaciones de órdenes"
}

# TODO(reto): Exportar ARN de suscripción
output "orders_subscription_arn" {
  value = null # TODO(reto): aws_sns_topic_subscription.orders_sqs.arn
  description = "ARN de la suscripción SNS a SQS"
}