# terraform.tfvars file is used to store variable values
# Terraform automatically loads this file during plan and apply

# instance_type is the variable name
# "t2.micro" is the actual value assigned to that variable
# This value will be used wherever var.instance_type is referenced
instance_type = "t2.micro"
