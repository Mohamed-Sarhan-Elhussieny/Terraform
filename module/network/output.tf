output "public_subnet_ids" {
  value = [
    aws_subnet.subnet-public1.id,
    aws_subnet.subnet-public2.id,
    aws_subnet.subnet-public3.id
  ]
}