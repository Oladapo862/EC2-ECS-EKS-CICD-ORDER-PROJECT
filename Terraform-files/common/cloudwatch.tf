resource "aws_cloudwatch_log_group" "production_application_logs" {
  name              = "/production/application"
  retention_in_days = 30

  tags = {
    Name = "production-application-logs"
  }
}
resource "aws_cloudwatch_metric_alarm" "production_ec2_cpu_high" {
  alarm_name          = "production-ec2-cpu-high"
  alarm_description   = "Alarm when production EC2 CPU utilization is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    InstanceId = "REPLACE_WITH_EC2_INSTANCE_ID"
  }

  treat_missing_data = "notBreaching"

  tags = {
    Name = "production-ec2-cpu-high"
  }
}
resource "aws_cloudwatch_metric_alarm" "production_ec2_status_check_failed" {
  alarm_name          = "production-ec2-status-check-failed"
  alarm_description   = "Alarm when production EC2 status checks fail"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Maximum"
  threshold           = 0

  dimensions = {
    InstanceId = "REPLACE_WITH_EC2_INSTANCE_ID"
  }

  treat_missing_data = "notBreaching"

  tags = {
    Name = "production-ec2-status-check-failed"
  }
}
resource "aws_cloudwatch_metric_alarm" "production_ec2_network_in_high" {
  alarm_name          = "production-ec2-network-in-high"
  alarm_description   = "Alarm when production EC2 network traffic in is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 100000000

  dimensions = {
    InstanceId = "REPLACE_WITH_EC2_INSTANCE_ID"
  }

  treat_missing_data = "notBreaching"

  tags = {
    Name = "production-ec2-network-in-high"
  }
}
resource "aws_cloudwatch_metric_alarm" "production_ec2_network_out_high" {
  alarm_name          = "production-ec2-network-out-high"
  alarm_description   = "Alarm when production EC2 network traffic out is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "NetworkOut"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 100000000

  dimensions = {
    InstanceId = "REPLACE_WITH_EC2_INSTANCE_ID"
  }

  treat_missing_data = "notBreaching"

  tags = {
    Name = "production-ec2-network-out-high"
  }
}
resource "aws_cloudwatch_metric_alarm" "production_ec2_disk_used_high" {
  alarm_name          = "production-ec2-disk-used-high"
  alarm_description   = "Alarm when production EC2 disk usage is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    InstanceId = "REPLACE_WITH_EC2_INSTANCE_ID"
    path       = "/"
    fstype     = "ext4"
  }

  treat_missing_data = "notBreaching"

  tags = {
    Name = "production-ec2-disk-used-high"
  }
}
resource "aws_cloudwatch_dashboard" "production_ec2" {
  dashboard_name = "production-ec2-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "EC2 CPU Utilization"
          region = "eu-west-1"
          period = 300
          stat   = "Average"

          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "InstanceId",
              "REPLACE_WITH_EC2_INSTANCE_ID"
            ]
          ]
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "EC2 Network Traffic"
          region = "eu-west-1"
          period = 300
          stat   = "Average"

          metrics = [
            [
              "AWS/EC2",
              "NetworkIn",
              "InstanceId",
              "REPLACE_WITH_EC2_INSTANCE_ID"
            ],
            [
              "AWS/EC2",
              "NetworkOut",
              "InstanceId",
              "REPLACE_WITH_EC2_INSTANCE_ID"
            ]
          ]
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "EC2 Status Check"
          region = "eu-west-1"
          period = 300
          stat   = "Maximum"

          metrics = [
            [
              "AWS/EC2",
              "StatusCheckFailed",
              "InstanceId",
              "REPLACE_WITH_EC2_INSTANCE_ID"
            ]
          ]
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "EC2 Disk Usage"
          region = "eu-west-1"
          period = 300
          stat   = "Average"

          metrics = [
            [
              "CWAgent",
              "disk_used_percent",
              "InstanceId",
              "REPLACE_WITH_EC2_INSTANCE_ID",
              "path",
              "/",
              "fstype",
              "ext4"
            ]
          ]
        }
      }
    ]
  })
}
