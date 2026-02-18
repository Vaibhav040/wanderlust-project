output "instance_public_ip" {
    description = "Public ip for wanderlust Dev server"
    value = module.wanderlust_dev.ec2_public_ip
}
output "instance_public_dns" {
    description = "Public DNS for wanderlust Dev Server"
    value = module.wanderlust_dev.public_dns
}