variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "sg_names" {
    type = list
    default = [
        "mongodb", "redis", "mysql", "rabbitmq",             # for  database
        # "catalogue", "user", "cart", "shipping", "payment",    # for backend    # all this are in "eks_control_plane" 
        # "backend_alb",                                                          
        # "frontend",                                                              # all this are in "eks_control_plane"
        "public_alb",    # public_alb = _ is for programming 
        "bastion",         # roboshop-dev = - is for human readability
        #"vpn"
        "eks_control_plane", # "eks_control_plane" also called "master node" consist of "catalogue", "user", "cart", "shipping", "payment", 
        "eks_node"                                                                                             # "backend_alb", "frontend",                                                              
    ]
}

