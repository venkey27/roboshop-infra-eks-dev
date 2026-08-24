variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "eks_version" {
    default = "1.36"
}

variable "enable_blue" {
    default = false
}

variable "blue_version" {
    default = "1.36"
}

variable "enable_green" {
    default = true
}

variable "green_version" {
    default = "1.35"
}
