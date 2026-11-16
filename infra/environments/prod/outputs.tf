# Outputs del entorno de producción
# Superficie de práctica: el estudiante debe implementar los outputs requeridos

output "vpc_id" {
  description = "ID de la VPC de producción"
  value       = module.networking.vpc_id
}

output "orders_queue_url" {
  description = "URL de la cola SQS de órdenes"
  value       = module.messaging.orders_queue_url
}

output "orders_dlq_url" {
  description = "URL de la cola SQS de letras muertas"
  value       = module.messaging.orders_dlq_url
}

output "orders_topic_arn" {
  description = "ARN del tema SNS de órdenes"
  value       = module.messaging.orders_topic_arn
}

output "service_url" {
  description = "URL pública del servicio de órdenes"
  value       = "http://${module.messaging.orders_queue_url}"
}