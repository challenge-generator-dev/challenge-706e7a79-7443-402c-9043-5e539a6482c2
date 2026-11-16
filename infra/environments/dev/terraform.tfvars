# AWS Credentials and General Configuration
aws_region = "us-east-1"
aws_profile = "default"

# Networking Module Variables
vpc_cidr_block = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]

# Compute Module Variables
instance_type = "t3.micro"
key_name = "dev-keypair"
min_size = 1
max_size = 2
desired_capacity = 1

# Database Module Variables
db_instance_class = "db.t3.micro"
db_name = "devdb"
db_username = "admin"
db_password = "securepassword123" # In production, use secrets manager
allocated_storage = 20

# Messaging Module Variables
queue_name = "dev-events-queue"
topic_name = "dev-events-topic"