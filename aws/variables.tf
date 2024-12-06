variable "aws_region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "ap-southeast-1"
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}

variable "ubuntu_ami_id" {
  description = "The AMI ID for Ubuntu 22"
  type        = string
  default     = "ami-03fa85deedfcac80b" 
}


variable "subnet_id" {
  description = "The ID of the subnet where instances will be launched"
  type        = string
  default     = "subnet-0981463b3709fe87a"
}

variable "block_storage_size" {
  description = "Size of the block storage in GiB"
  type        = number
  default     = 20
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
  default     = "alvaro"
}

variable "security_group_id" {
  description = "The ID of the security group"
  type        = string
  default     = "sg-07c45add12bcb8e1d"
}

