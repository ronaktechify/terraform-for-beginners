#############################################################
# Generate SSH Private & Public Key for Developer Access
# Terraform will create RSA 4096 bit secure key
#############################################################
resource "tls_private_key" "dev_key" {

  # Encryption algorithm used for SSH key
  algorithm = "RSA"

  # Key length (4096 is highly secure)
  rsa_bits  = 4096
}

#############################################################
# Upload Public Key to AWS as EC2 Key Pair
# This will allow EC2 to trust the generated key
#############################################################
resource "aws_key_pair" "generated_key" {

  # Name of key pair in AWS Console
  key_name   = "developer-key"

  # Public key generated from tls_private_key
  public_key = tls_private_key.dev_key.public_key_openssh
}

#############################################################
# Save Private Key Locally as PEM File
# This PEM file will be shared with developer for SSH login
#############################################################
resource "local_file" "pem_file" {

  # Name of the generated PEM file
  filename = "developer-key.pem"

  # Private key content in PEM format
  content  = tls_private_key.dev_key.private_key_pem

  # Required permission for SSH login
  file_permission = "0400"
}

#############################################################
# Security Group to Allow SSH Access (Port 22)
#############################################################
resource "aws_security_group" "ssh_access" {

  name        = "allow-ssh"
  description = "Allow SSH inbound traffic"

  # Allow SSH from anywhere
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh-sg"
  }
}

#############################################################
# Create EC2 Instance
# Attach Generated Key Pair to EC2
#############################################################
resource "aws_instance" "example" {

  # AMI defines OS (Amazon Linux / Ubuntu etc.)
  ami = "ami-019715e0d74f695be"

  # Instance type from terraform.tfvars
  instance_type = var.instance_type

  # Attach Developer Key Pair to EC2
  key_name = aws_key_pair.generated_key.key_name

  # Attach Security Group
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  # Tags for identification
  tags = {
    Name = "Techify-Instance"
  }
}
