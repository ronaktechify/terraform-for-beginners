# This block tells Terraform that we want to create a resource
# "aws_instance" means an EC2 instance in AWS
# "example" is a local name used by Terraform to identify this resource
resource "aws_instance" "example" {

  # AMI (Amazon Machine Image) defines the operating system of the server
  # This AMI ID is region-specific (for example: ap-south-1)
  # Think of it as: Ubuntu / Amazon Linux / RedHat image
  ami = "ami-0b6c6ebed2801a5cb"

  # Instance type defines the size of the server
  # Instead of hardcoding, we are using a variable
  # The actual value is taken from terraform.tfvars
  instance_type = var.instance_type

  # Tags are key-value pairs used to identify and manage resources
  # Very useful in real projects for billing, ownership, and environment tracking
  tags = {

    # Name tag helps us easily recognize the EC2 instance in AWS Console
    Name = "HelloWorld"
  }
}
