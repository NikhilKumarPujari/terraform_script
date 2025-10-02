variable "env" {
  description = "This is the environment"
  type        = string
}

variable "bucket_name" {
  description = "This is the bucket name of infra"
  type        = string
}

variable "instance_count" {
  description = "This is the number of EC2 instances"
  type        = number
}


variable "instance_type" {
  description = "This is the instance type"
  type        = string
}

variable "ec2_ami_id" {
  description = "This is the AMI ID"
  type        = string
}

variable "hash_key" {
  description = "This is the hash key for DynamoDB infra"
  type        = string
}
