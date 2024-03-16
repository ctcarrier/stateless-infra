terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.7.5"
    }
}

provider "aws" {  
  region  = var.aws_region
}

resource "aws_vpc" "stateless_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.stateless_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.availability_zones[0]
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.stateless_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.availability_zones[1]
}

resource "aws_security_group" "stateless_sg" {
  name        = "stateless-sg"
  description = "Security group for EKS cluster"
  vpc_id      = aws_vpc.stateless_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eks_cluster" "stateless_cluster" {
  name     = "stateless-cluster"
  role_arn = aws_iam_role.stateless_cluster_role.arn

  vpc_config {
    subnet_ids         = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
    security_group_ids = [aws_security_group.stateless_sg.id]
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_attach_policy]
}

resource "aws_iam_role" "stateless_cluster_role" {
  name = "stateless-cluster-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_attach_policy" {
  role       = aws_iam_role.stateless_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
