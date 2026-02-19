# Module for single Environment(Dev)
module "wanderlust_dev" {
    source = "../modules/ec2-server"
    env = "dev"
    instance_count = 1
    instance_type = "c7i-flex.large"
    ec2_ami_id = "ami-019715e0d74f695be"
    ec2_state = "running" # later can be changed to "stopped" to stop the server
}