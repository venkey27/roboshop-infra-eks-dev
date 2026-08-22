locals {
    eks_control_plane_sg_id = data.aws_ssm_parameter.eks_control_plane_sg_id.value
    eks_node_sg_id = data.aws_ssm_parameter.eks_node_sg_id.value
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)  # will get values of private_subnet_ids below
                    # private_subnet_ids = ["subnet-0abc123", "subnet-0def456", "subnet-0ghi789"]
    common_tags = {
        Project = var.project
        Environment = var.environment
        Name = "${var.project}-${var.environment}"
    }
    common_name = "${var.project}-${var.environment}"
}
  