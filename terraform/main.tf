# Fetch AWS credentials from Vault
data "vault_generic_secret" "aws_credentials" {
  path = "aws/creds/dev-role" # Replace <your-role-name> with your Vault AWS role
}

provider "vault" {
  address = var.vault_address  # Vault server address, fetched from variables
  token   = var.vault_token    # Vault token, fetched from variables
}

# Configure the AWS provider

provider "aws" {
  # Configuration options
  region     = "us-east-1" # Update with your preferred region
  access_key = data.vault_generic_secret.aws_credentials.data.access_key
  secret_key = data.vault_generic_secret.aws_credentials.data.secret_key
}
  

# Security group to allow SSH (22) and HTTP (80) traffic
resource "aws_security_group" "tfsec_sg" {
  name        = "tfsec-example-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (update to restrict access)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Name = "tfsec-example-sg"
  }
}

# EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-05576a079321f21f8" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "Devsecops" # Use your keypair

  # Attach the security group to the instance
  vpc_security_group_ids = [aws_security_group.tfsec_sg.id]

  tags = {
    Name = "tfsec-example"
  }
}
