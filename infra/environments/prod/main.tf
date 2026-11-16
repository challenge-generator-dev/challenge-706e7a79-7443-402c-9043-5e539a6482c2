terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  backend "s3" {
    bucket = "terraform-state-prod-orders"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}

module "networking" {
  source = "../../modules/networking"
}

module "database" {
  source = "../../modules/database"
}

module "compute" {
  source = "../../modules/compute"
}

module "messaging" {
  source = "../../modules/messaging"
}

# TODO(reto): implementa este bloque
# resource "aws_s3_bucket" "orders_state" {
# }

# TODO(reto): implementa este bloque
# resource "aws_s3_bucket_versioning" "orders_state" {
# }

# TODO(reto): implementa este bloque
# resource "aws_cloudwatch_log_group" "orders_service" {
# }

# TODO(reto): implementa este bloque
# resource "aws_kms_key" "orders_encryption" {
# }

# TODO(reto): implementa este bloque
# resource "aws_kms_alias" "orders_encryption" {
# }

# TODO(reto): implementa este bloque
# resource "aws_security_group" "alb" {
# }

# TODO(reto): implementa este bloque
# resource "aws_lb" "orders" {
# }

# TODO(reto): implementa este bloque
# resource "aws_lb_target_group" "orders" {
# }

# TODO(reto): implementa este bloque
# resource "aws_lb_listener" "orders_https" {
# }

# TODO(reto): implementa este bloque
# resource "aws_ecs_cluster" "orders" {
# }

# TODO(reto): implementa este bloque
# resource "aws_ecs_task_definition" "orders" {
# }

# TODO(reto): implementa este bloque
# resource "aws_ecs_service" "orders" {
# }

# TODO(reto): implementa este bloque
# resource "aws_security_group" "ecs_tasks" {
# }

# TODO(reto): implementa este bloque
# resource "aws_appautoscaling_target" "ecs" {
# }

# TODO(reto): implementa este bloque
# resource "aws_appautoscaling_policy" "orders_cpu" {
# }

# TODO(reto): implementa este bloque
# resource "aws_appautoscaling_policy" "orders_memory" {
# }

# TODO(reto): implementa este bloque
# resource "aws_dynamodb_table" "orders" {
# }

# TODO(reto): implementa este bloque
# resource "aws_sns_topic_subscription" "orders_updates" {
# }

# TODO(reto): implementa este bloque
# resource "aws_sqs_queue_policy" "orders_dlq" {
# }

output "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  value = null # TODO(reto): aws_ecs_cluster.orders.name
}

output "ecs_service_name" {
  description = "Nombre del servicio ECS"
  value = null # TODO(reto): aws_ecs_service.orders.name
}

output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB"
  value = null # TODO(reto): aws_dynamodb_table.orders.name
}

output "kms_key_arn" {
  description = "ARN de la clave KMS"
  value = null # TODO(reto): aws_kms_key.orders_encryption.arn
}