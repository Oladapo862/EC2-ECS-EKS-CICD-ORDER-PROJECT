data "aws_ssm_parameter" "production_amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_launch_template" "production_app" {
  name          = "production-app-launch-template"
  instance_type = "t3.micro"

  image_id = data.aws_ssm_parameter.production_amazon_linux_2023.value

  iam_instance_profile {
    name = aws_iam_instance_profile.production_ec2.name
  }

  vpc_security_group_ids = [
    aws_security_group.production_app.id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash

    dnf update -y

    dnf install -y docker

    systemctl enable docker
    systemctl start docker

    mkdir -p /opt/production-app

    aws ecr get-login-password --region eu-west-1 | \
      docker login --username AWS --password-stdin \
      ${aws_ecr_repository.production_app.repository_url}

    docker pull ${aws_ecr_repository.production_app.repository_url}:latest

    docker stop production-app 2>/dev/null || true
    docker rm production-app 2>/dev/null || true

    docker run -d \
      --name production-app \
      --restart unless-stopped \
      -p 8000:8000 \
      ${aws_ecr_repository.production_app.repository_url}:latest

    echo "EC2 production server initialized successfully" > /opt/production-app/status.txt
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "production-app"
    }
  }
}
