output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.security_vpc.id
}


output "s3_bucket_name" {
  description = "Secure S3 bucket name"
  value       = aws_s3_bucket.secure_bucket.id
}


output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.security_ec2.id
}


output "ec2_private_ip" {
  description = "Private IP address of EC2"
  value       = aws_instance.security_ec2.private_ip
}


output "security_group_id" {
  description = "EC2 security group ID"
  value       = aws_security_group.ec2_security_group.id
}