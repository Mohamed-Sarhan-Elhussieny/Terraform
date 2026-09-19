# ********************************** network.tfvars ********************
vpc_cidr_block = "10.0.0.0/16" // CIDR block for the VPC
region         = "us-east-1"
# architecture for vpc 2private subnets and 3 public subnets
subnet_private1_cidr_block = "10.0.1.0/24"
subnet_private2_cidr_block = "10.0.2.0/24"
subnet_public1_cidr_block  = "10.0.3.0/24"
subnet_public2_cidr_block  = "10.0.4.0/24"
subnet_public3_cidr_block  = "10.0.5.0/24"
# map public IP on launch
map_public_ip_on_launch = false
# security group variables 4 ingress and 1 egress
ip_allow_ssh      = "192.168.1.6/32"    // Replace with your actual IP address to allow SSH access
port_allow        = [22, 80, 443, 8080] // List of ports to allow access
port_allow_egress = [0]                 // List of ports to allow egress access
# ---------------------------------------------------------------------------