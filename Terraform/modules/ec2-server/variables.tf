variable "env" {
    description = "This is enviorenment for wanderlust App"
    type = string
}

variable "instance_count" {
    description = "This is Instance-Count for wanderlust App"
    type = number
}

variable "instance_type" {
    description = "This is Instance-Type for wanderlust App"
    type = string
}

variable "ec2_ami_id" {
    description = "This i AMI-ID for wanderlust App"
    type = string
}
variable "ec2_state" {
    description = "This make sure if you want to run the instance or stop"
    type = string
    default = "running"
}