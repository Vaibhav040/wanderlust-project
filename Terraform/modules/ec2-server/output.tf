output "ec2_public_ip" {
    description = "Public IP Address of wanderlust EC2 Server"
    value = aws_instance.my_instance[*].public_ip
}
output "public_dns" {
    description = "Public DNS for wanderlust EC2 Server"
    value = aws_instance.my_instance[*].public_dns
}