data "aws_caller_identity" "current" {}

resource "aws_iam_openid_connect_provider" "production_github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  tags = {
    Name = "production-github-oidc"
  }
}

data "aws_iam_policy_document" "production_github_actions_assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.production_github.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:Oladapo862/EC2-ECS-EKS-CICD-ORDER-PROJECT:*"
      ]
    }
  }
}

resource "aws_iam_role" "production_github_actions" {
  name               = "production-github-actions-role"
  assume_role_policy = data.aws_iam_policy_document.production_github_actions_assume_role.json

  tags = {
    Name = "production-github-actions-role"
  }
}
