# security_group_id (The Destination/Target):
# The security group that receives the rule attached to it.
# Because this is an ingress rule, it means traffic comes into / goes to the resources associated with this security group (local.mongodb_sg_id).

# source_security_group_id (The Source/Origin):
# The security group where the allowed traffic originates / comes from (local.bastion_sg_id).

# MongoDB allowing connections from bastion on port 22
resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"                     # Destination: The MongoDB database.
  source_security_group_id = local.bastion_sg_id # Source security group id means the traffic coming form the bastion security group id
  security_group_id = local.mongodb_sg_id # security group id means the traffic coming from bastion security group id will be accepted by mongodb_sg_id    
}                                               

resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.redis_sg_id
}

resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.mysql_sg_id
}

resource "aws_security_group_rule" "rabbitmq_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.rabbitmq_sg_id
}

# public ALB
resource "aws_security_group_rule" "public_alb_https" {
  type              = "ingress"
  from_port         = 443                     # 443 means secure public web traffic (HTTPS)
  to_port           = 443                     # Whenever you see HTTPS, it always uses port 443 behind the scenes
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]       # accepting all traffic from public 
  security_group_id = local.public_alb_sg_id
}

resource "aws_security_group_rule" "public_alb_http" {           # http for testing purpose 
  type              = "ingress"
  from_port         = 80                                   
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]                                         #allow traffic from any IP address on the internet
  security_group_id = local.public_alb_sg_id
}

# Bastion
resource "aws_security_group_rule" "bastion_my_public_ip" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["73.18.232.81/32"]   # in our roboshop project giving vpn public ipaddress # in real time we keep elastic IP here so we dont have to change vpn ip addess vry time
  # cidr_blocks = ["73.18.232.81/32"]  # i am using this here because i am connecting from my laptop to bastion. not form ec2 instance to  bastion
  security_group_id = local.bastion_sg_id 
  #source_security_group_id = local.bastion_sg_id # we use this in real-time for ece to ec2
} 

# "eks_control_plane" should accept traffic from bastion
resource "aws_security_group_rule" "eks_control_plane_bastion" { 
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id 
  security_group_id = local.eks_control_plane_sg_id
} 

# "eks_node" should accept traffic from eks_control_plane
resource "aws_security_group_rule" "eks_node_eks_control_plane" { 
  type              = "ingress"
  from_port         = 0  # all ports
  to_port           = 0  # all ports
  protocol          = "-1" # all traffic
  source_security_group_id = local.eks_control_plane_sg_id  
  security_group_id = local.eks_node_sg_id   
} 

# "eks_control_plane" should accept traffic from "eks_node"
resource "aws_security_group_rule" "eks_control_plane_eks_node_" { 
  type              = "ingress"
  from_port         = 0  # all ports
  to_port           = 0  # all ports
  protocol          = "-1" # all traffic
  source_security_group_id = local.eks_node_sg_id  
  security_group_id = local.eks_control_plane_sg_id 
} 

# internal traffic of VPC 
# mongodb is in node-2, cataloge is in node-1
# traffic crosses from cataloge pod, then cross node-1 and then enters node-2 and enters to mongodb
resource "aws_security_group_rule" "eks_node_vpc" { 
  type              = "ingress"
  from_port         = 0  # all ports   # to enable POD to POD communciation 
  to_port           = 0  # all ports
  protocol          = "-1" # all traffic
  cidr_blocks = ["10.0.0.0/16"]
  security_group_id = local.eks_node_sg_id 
}     