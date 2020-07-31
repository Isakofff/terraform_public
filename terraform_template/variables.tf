variable "bucket_name" {
  type = string
}
variable "main-region" {
  description = "Main operational region"
}

variable "AK" {
  type = string
}
variable "SK" {
  type = string
}
variable "golden_ami" {
  type = string
}
variable "private_key_path" {
  type = string
}
variable "key_name" {}

variable "AZs" {
  type = map
}

variable "dev-list-of-target" {
  type = list
}


//// Input variables - enter the value during Apply
//variable db_pass {
//
//}

//// terraform apply -var 'secret-map={target1="1", target2="2"}'
//variable secret-map {
//  type = map
//}


// Output variables
output "explain1" {
  value = "This is our output variable. You can see it only in Apply or Show"
}

//output "aws_cidr_subnet1" {
//  value = aws_subnet.subnet1.cidr_block
//}