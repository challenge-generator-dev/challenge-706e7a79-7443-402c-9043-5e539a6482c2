# Stub: Implementar recursos de mensajería (SQS/SNS)
# El estudiante debe definir:
# - Colas SQS para procesamiento de órdenes
# - Temas SNS para notificaciones
# - Suscripciones entre SQS y SNS
# - Políticas de dead-letter queue
# - Configuración de FIFO si aplica

# TODO(reto): Implementar aws_sqs_queue para órdenes
resource "aws_sqs_queue" "orders" {
}

# TODO(reto): Implementar cola dead-letter
resource "aws_sqs_queue" "orders_dlq" {
  # name = "dev-orders-dlq"
}

# TODO(reto): Implementar tema SNS para notificaciones de órdenes
resource "aws_sns_topic" "orders" {
  # name = "dev-orders-topic"
}

# TODO(reto): Implementar suscripción SQS -> SNS
# TODO(reto): implementa este bloque
# resource "aws_sns_topic_subscription" "orders_sqs" {
# }