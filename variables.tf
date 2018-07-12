
variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.1.0.0/16"
}

variable "company-pub-sub-1a_cidr" {
    description = "CIDR for the Public Subnet a "
    default = "10.1.1.0/24"
}

variable "company-pub-sub-1b_cidr" {
    description = "CIDR for the Public Subnet b "
    default = "10.1.2.0/24"
}
variable "company-pub-sub-1c_cidr" {
    description = "CIDR for the Public Subnet c "
    default = "10.1.3.0/24"
}
