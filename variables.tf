# This block defines an input variable for Terraform
# Variables allow us to pass values from outside the code
variable "instance_type" {

  # Description explains what this variable is used for
  # Helpful for documentation and when working in teams
  description = "EC2 instance type"

  # Type defines what kind of value this variable accepts
  # string means text value (example: "t2.micro")
  type = string
}
