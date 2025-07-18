output "stackset" {
  value = (
    var.permission_model == "SERVICE_MANAGED"
    ? aws_cloudformation_stack_set.default[0]
    : aws_cloudformation_stack_set.self_managed[0]
  )
  description = "The AWS Cloudformation StackSet."
}

output "stackset_instances" {
  value       = aws_cloudformation_stack_set_instance.this
  description = "All AWS CloudFormation StackSet instances created (keyed by OU ID)."
}
