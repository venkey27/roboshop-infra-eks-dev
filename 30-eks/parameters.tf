# creating cluster name and storing parameters  store
resource "aws_ssm_parameter" "eks_cluster_name" {
  name  = "/${var.project}/${var.environment}/eks_cluster_name"
  type  = "String"
  value = module.eks.cluster_name
  overwrite = true
}

# value = module.eks_cluster_name
# "module." is used to access the exported output (cluster_name) from the EKS module block defined as 'module "eks"' in main.tf