# key pair (login)
resource "aws_key_pair" "my_key"{
    key_name = "${var.env}-wanderlust-key"
    public_key = file("wanderlust.pub")

    tags = {
        Environment = var.env
    }
}
# VPC & Security Group
resource "aws_default_vpc" "default"{

}
resource "aws_security_group" "allow_tls"{
    name = "${var.env}-wanderlust-sg"
    description = "Allow Inbound and Outbound rule"
    vpc_id = aws_default_vpc.default.id

    # Inbound
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH port open"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP port open"
    }
    ingress {
        from_port = 5173
        to_port = 5173
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Frontend Port open"
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Backend Port open"
    }

    # Outbound
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "All Ports are open for Outbound"

    }

    tags = {
        name = "${var.env}-wanderlust-sg"
    }
}
# EC2 instance
resource "aws_instance" "my_instance" {
    count = var.instance_count

    depends_on = [ aws_security_group.allow_tls, aws_key_pair.my_key ]

    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.allow_tls.name]
    instance_type = var.instance_type
    ami = var.ec2_ami_id # Ubuntu
    user_data = file("${path.module}/scripts/install_guide.sh")

    root_block_device {
      volume_size = var.env == "dev" ? 20 : 10
      volume_type = "gp3"
    }

    tags = {
      Name = "wanderlust-ec2-server"
      Environment = var.env
    }

}
resource "aws_ec2_instance_state" "my_instance_state" {
    count = var.instance_count
    instance_id = aws_instance.my_instance[count.index].id
    state = var.ec2_state
}