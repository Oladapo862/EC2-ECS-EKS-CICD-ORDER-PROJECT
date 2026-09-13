# EC2-ECS-EKS-CICD-ORDER-PROJECT

Production-style AWS order application built with **Terraform, Docker, AWS, and GitHub Actions**.

The project is designed to demonstrate how the same application can be deployed using different AWS compute platforms:

* Amazon EC2
* Amazon ECS / Fargate
* Amazon EKS

Infrastructure is managed with **Terraform**, application deployment is handled through **GitHub Actions**, and AWS services provide networking, security, storage, database, monitoring, and application delivery.

---

## Project Architecture

The application follows this general production architecture:

```text
                         INTERNET
                             |
                             v
                           ALB
                             |
              +--------------+--------------+
              |              |              |
              v              v              v
             EC2           ECS/Fargate      EKS
              |              |              |
              +--------------+--------------+
                             |
                             v
                            RDS
```

The different compute environments share the same general AWS production foundation.

---

# AWS Infrastructure

## Networking

The production environment uses:

* VPC
* Public subnets
* Private application subnets
* Private database subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Route Associations
* Security Groups
* VPC Endpoints

### Network Design

```text
                    INTERNET
                       |
                       v
                      IGW
                       |
                PUBLIC SUBNETS
                       |
                +------+------+
                |             |
               ALB       NAT Gateway
                              |
                              v
                    PRIVATE APP SUBNETS
                              |
                    +---------+---------+
                    |                   |
                   EC2              ECS/EKS
                    |
                    v
             PRIVATE DB SUBNETS
                    |
                   RDS
```

The application resources are placed in private subnets while the Application Load Balancer is placed in public subnets.

The NAT Gateway provides outbound internet access for private application resources.

The database subnets do not provide direct internet access.

---

# Application

The application is a simple production-style order application.

```text
app/
├── app.py
├── orders.py
├── db.py
├── index.html
└── _init_.py
```

## Application Components

### `app.py`

Provides the Flask application and HTTP routes.

Main endpoints:

```text
GET  /
GET  /health
POST /orders
```

### `orders.py`

Handles order creation and database interaction.

### `db.py`

Retrieves database credentials from AWS Secrets Manager and creates the database connection.

### `index.html`

Provides the simple web interface for creating orders.

---

# Database

The application uses:

**Amazon RDS MySQL**

The application does not hardcode database credentials.

The database credentials are stored in:

**AWS Secrets Manager**

The application retrieves the credentials at runtime using its AWS IAM permissions.

```text
EC2 / ECS / EKS
       |
       v
Secrets Manager
       |
       v
Database Credentials
       |
       v
      RDS
```

---

# Containerization

The application is containerized using Docker.

```text
Dockerfile
    |
    v
Docker Image
    |
    v
Amazon ECR
    |
    v
EC2 / ECS / EKS
```

The Docker image contains the Flask application and its Python dependencies.

---

# AWS Services

The project uses the following AWS services.

## Core Infrastructure

* Amazon VPC
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups
* VPC Endpoints

## Compute

* Amazon EC2
* Amazon ECS / Fargate
* Amazon EKS

## Load Balancing

* Application Load Balancer
* Target Groups
* Listeners

## Database

* Amazon RDS MySQL

## Storage

* Amazon S3

## Container Registry

* Amazon ECR

## Security and Access

* AWS IAM
* AWS Secrets Manager
* AWS Systems Manager

## Monitoring

* Amazon CloudWatch

## Notifications

* Amazon SNS

## DNS / TLS

* Amazon Route 53
* AWS Certificate Manager

---

# Terraform Structure

Terraform infrastructure is separated according to the production environment.

```text
Terraform-files/
│
├── common/
│
├── ec2/
│
├── ecs/
│
└── eks/
```

## Common

The `common` directory contains infrastructure shared across the production environments.

Examples include:

```text
vpc.tf
public_subnets.tf
private_subnets.tf
private_db_subnets.tf
nat_gateway.tf
security_groups.tf
rds.tf
s3.tf
ecr.tf
secrets_manager.tf
cloudwatch.tf
sns.tf
```

## EC2

The EC2 environment contains resources specific to an EC2 production deployment.

```text
ec2/
├── alb.tf
├── target_group.tf
├── listener.tf
├── launch_template.tf
├── autoscaling.tf
├── iam.tf
└── ...
```

The EC2 deployment uses:

```text
ALB
 |
 v
Target Group
 |
 v
Auto Scaling Group
 |
 v
EC2 Instances
```

## ECS

The ECS environment contains resources required for an ECS/Fargate deployment.

```text
ecs/
├── cluster.tf
├── task_definition.tf
├── service.tf
├── autoscaling.tf
├── alb.tf
└── ...
```

## EKS

The EKS environment contains resources required for Kubernetes deployment.

```text
eks/
├── cluster.tf
├── node_group.tf
├── addons.tf
├── alb.tf
└── ...
```

---

# Infrastructure as Code

Terraform is used to create and manage the AWS infrastructure.

The infrastructure is separated into different Terraform directories so that each compute platform can have its own configuration.

```text
Terraform
    |
    +---- Common Infrastructure
    |
    +---- EC2
    |
    +---- ECS
    |
    +---- EKS
```

Terraform manages the infrastructure while GitHub Actions handles automated deployment.

---

# CI/CD

GitHub Actions is used for application deployment.

Workflow files are stored in:

```text
.github/workflows/
```

Current deployment workflows include:

```text
deploy-ec2.yml
deploy-ecs.yml
```

The deployment process is designed around:

```text
Developer
    |
    v
GitHub
    |
    v
GitHub Actions
    |
    v
Docker Build
    |
    v
Amazon ECR
    |
    v
AWS Production Environment
```

---

# EC2 Production Flow

The EC2 production environment follows:

```text
Internet
   |
   v
Application Load Balancer
   |
   v
Target Group
   |
   v
EC2 Auto Scaling Group
   |
   v
Docker Application
   |
   v
RDS MySQL
```

EC2 instances run in private subnets.

The Application Load Balancer is placed in public subnets.

---

# Security

The project follows a private-subnet production architecture.

### Public

* Application Load Balancer
* NAT Gateway

### Private Application

* EC2
* ECS tasks
* EKS workloads

### Private Database

* RDS

Security Groups restrict communication between the different layers.

Example:

```text
Internet
   |
   | 80 / 443
   v
ALB
   |
   | 8000
   v
Application
   |
   | 3306
   v
RDS
```

---

# Secrets Management

Database credentials are stored in AWS Secrets Manager.

The application retrieves them at runtime instead of storing credentials inside application code.

Terraform variables containing sensitive values are excluded from Git using `.gitignore`.

```text
*.tfvars
*.tfstate
*.tfstate.*
.terraform/
```

---

# Monitoring

Amazon CloudWatch is used as the monitoring layer.

Monitoring covers areas such as:

* EC2 metrics
* ECS metrics
* EKS metrics
* Application metrics
* ALB metrics
* RDS metrics
* Logs
* Application health
* Errors
* Performance

The project separates **monitoring** from **troubleshooting**.

---

# Troubleshooting

Production troubleshooting documentation is stored in:

```text
troubleshooting/
└── troubleshooting.md
```

The troubleshooting process focuses on:

```text
Process
   |
   v
Resources
   |
   v
Logs
   |
   v
Network
   |
   v
Application
   |
   v
Database
```

---

# Repository Structure

```text
EC2-ECS-EKS-CICD-ORDER-PROJECT/
│
├── .github/
│   └── workflows/
│       ├── deploy-ec2.yml
│       └── deploy-ecs.yml
│
├── app/
│   ├── app.py
│   ├── db.py
│   ├── index.html
│   ├── orders.py
│   └── _init_.py
│
├── Terraform-files/
│   ├── common/
│   ├── ec2/
│   ├── ecs/
│   └── eks/
│
├── troubleshooting/
│   └── troubleshooting.md
│
├── Dockerfile
├── requirements.txt
├── .gitignore
└── README.md
```

---

# Technology Stack

| Category       | Technology                |
| -------------- | ------------------------- |
| Cloud          | AWS                       |
| Infrastructure | Terraform                 |
| Application    | Python / Flask            |
| Database       | Amazon RDS MySQL          |
| Container      | Docker                    |
| Registry       | Amazon ECR                |
| Compute        | EC2 / ECS / EKS           |
| Load Balancer  | Application Load Balancer |
| Secrets        | AWS Secrets Manager       |
| Monitoring     | Amazon CloudWatch         |
| Storage        | Amazon S3                 |
| CI/CD          | GitHub Actions            |
| DNS            | Route 53                  |
| TLS            | AWS Certificate Manager   |
| Access         | IAM / Systems Manager     |
| Notifications  | Amazon SNS                |

---

# Project Goal

The goal of this project is to build and operate a production-style AWS application using Infrastructure as Code and automated CI/CD.

The project covers:

```text
Application
     |
     v
Docker
     |
     v
ECR
     |
     v
Terraform Infrastructure
     |
     v
EC2 / ECS / EKS
     |
     v
ALB
     |
     v
RDS
     |
     v
CloudWatch
```

The project also provides hands-on practice with production monitoring and troubleshooting across the different AWS compute environments.
