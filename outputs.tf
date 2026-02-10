# Output block is used to display values after Terraform creates resources
# These values are shown on the terminal after `terraform apply`
output "public_ip" {

  # This value fetches the public IP address of the EC2 instance
  # aws_instance.example → refers to the EC2 resource we created
  # public_ip → attribute provided by AWS
  value = aws_instance.example.public_ip
}