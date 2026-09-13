# Production Troubleshooting

I used a structured troubleshooting model to investigate and resolve
production incidents across three different AWS production environments:

- EC2 Production
- ECS Production
- Lambda / Event-Driven Production

The model provides a consistent way to move from the initial incident
to the affected component and root cause.

## Troubleshooting Model

```text
INCIDENT
   ↓
CAN APP BE REACHED / TRIGGERED?
   ↓
WHAT RESPONSE / FAILURE?
   ↓
IDENTIFY SERVICE
   ↓
CHECK METRICS
   ↓
READ LOGS
   ↓
FOLLOW DEPENDENCIES
   ↓
IDENTIFY ROOT CAUSE
   ↓
FIX
   ↓
VERIFY

I applied this troubleshooting model to the following production
incidents across the three environments.

EC2 Production — Top 20 Incidents
Application completely unreachable
EC2 instance is down
ALB reports unhealthy target
HTTP 500
HTTP 502
HTTP 503
HTTP 504
High CPU
High memory / OOM
Disk full
Docker container stopped
Docker restart loop
Gunicorn is not running
RDS connection failure
RDS is slow
Secrets Manager failure
DNS failure to RDS
Port 3306 unreachable
ALB cannot connect to EC2
Application suddenly becomes slow
ECS Production — Top 20 Incidents
ECS application completely unreachable
ECS service has zero running tasks
ECS task repeatedly stops
ECS task stuck in PENDING
ECS target unhealthy
ECS HTTP 500
ECS HTTP 502
ECS HTTP 503
ECS HTTP 504
ECS CPU too high
ECS memory too high
ECS container fails to start
ECR image pull failure
ECS cannot retrieve Secrets Manager secret
ECS deployment fails
ECS deployment succeeds but application is broken
ECS service keeps replacing tasks
ECS application suddenly becomes slow
ECS task cannot connect to RDS
ECS healthy but requests return errors
Lambda / Event-Driven Production — Top 20 Incidents
API completely unreachable
API returns 4XX
API returns 5XX
API is slow
Submit Lambda returns errors
Submit Lambda is timing out
Submit Lambda throttled
Submit Lambda cannot access Secrets Manager
SQS queue is growing
SQS messages are old
Process Lambda failing
Process Lambda throttled
Process Lambda is slow
DynamoDB writes failing
DynamoDB throttling
S3 write failing
EventBridge event not being delivered
EventBridge → SNS notification fails
SNS publishes but email isn't received
Complete event-driven processing failure
Production Troubleshooting Coverage

These 60 incidents cover the major troubleshooting areas I practiced
across the three production environments.

The troubleshooting model was used to investigate issues across:

Application availability
HTTP errors
Load balancers
EC2
Docker
Gunicorn
ECS
Fargate
Lambda
API Gateway
SQS
RDS
Secrets Manager
DynamoDB
S3
EventBridge
SNS
IAM
Networking
DNS
Security groups
CPU
Memory
Disk
Latency
Timeouts
Throttling
Health checks
Container failures
Deployment failures

The goal was to develop a repeatable production troubleshooting
process rather than troubleshooting each AWS service in isolation.