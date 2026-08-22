# giving access entry to bastion, so bastion now access "kubectl commands"
resource "aws_eks_access_entry" "bastion" {
  cluster_name      = local.eks_cluster_name
  principal_arn     = local.bastion_iam_role_arn
  type              = "STANDARD"
}

# attaching "eks admin policy" for "bastion"
resource "aws_eks_access_policy_association" "bastion" {
  cluster_name  = local.eks_cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = local.bastion_iam_role_arn  # given eks admin access for bastion

  access_scope {
    type       = "cluster"
  }
}