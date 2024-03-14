resource "aws_eks_cluster" "eks_cluster" {
    name = "eks-cluster-levelup"
    vpc_config {
      subnet_ids = [ module.vpc.public_subnets ]
    }
    role_arn = aws_iam_role.eks_cluster.arn

    depends_on = [ 
        aws_iam_policy_attachment.AmazonEKSClusterPolicy,
        aws_iam_policy_attachment.AmazonEKSServicePolicy,
     ]
    
    tags = {
      name = "EKS-CLUSTER_LEVELUP"
    }
  
}

resource "aws_eks_node_group" "eks_nodes" {
    cluster_name = aws_eks_cluster.eks_cluster.name
    node_group_name = "node_levelup"
    node_role_arn = aws_iam_role.eks_nodes.arn
    subnet_ids = [ module.vpc.public_subnets ]

    scaling_config {
      desired_size = 1
      max_size = 1
      min_size = 1
    }
  depends_on = [ 
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   ]
}