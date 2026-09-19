variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}
variable "subnet_private1_cidr_block" {
  description = "The CIDR block for the first private subnet"
  type        = string
}
variable "subnet_private2_cidr_block" {
  description = "The CIDR block for the second private subnet"
  type        = string
} 
variable "subnet_public1_cidr_block" {
  description = "The CIDR block for the first public subnet"
  type        = string
}
variable "subnet_public2_cidr_block" {
  description = "The CIDR block for the second public subnet"
  type        = string
} 
variable "subnet_public3_cidr_block" {
  description = "The CIDR block for the third public subnet"
  type        = string
} 

variable "map_public_ip_on_launch" {
  description = "Whether to assign a public IP address to instances launched in this subnet"
  type = bool
  default = true
}
# security group variables
variable "ip_allow_ssh" {
  description = "The IP address allowed to access the EC2 instance via SSH"
  type        = string
}
variable "port_allow" {
  description = "The port number allowed for access"
  type        = list(number)
}
variable "port_allow_egress" {
  description = "The port number allowed for egress access"
  type        = list(number)
}