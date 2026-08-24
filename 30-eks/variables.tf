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
    default = false # if create equals to false then blue will not create. if create equals to true then blue will create
}

variable "blue_version" {
    default = "1.36"
}

variable "enable_green" {
    default = true # if create equals to false then green will not create. if create equals to true then green will create
}

variable "green_version" {
    default = "1.35"
}
