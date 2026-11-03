variable  "ec2_instance_type" {
 default = "t2.micro"
 type = string

}

variable  "ec2_ami"{
    default = "ami-0c7632fb77f35db43"
    type = string

}
variable "ec2_default_root_volume_size" {
    default = 8
    type = number
}

variable "env"{
    default ="dev"
    type = string
}