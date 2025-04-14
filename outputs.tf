output "stackset" {
  value       = (
    var.permission_model == "SERVICE_MANAGED"
    ? aws_cloudformation_stack_set.default[0]
    : aws_cloudformation_stack_set.self_managed[0]
  )
  description = "The AWS Cloudformation StackSet."
}

output "stackset_instance" {
  value       = try(aws_cloudformation_stack_set_instance.default[0], null)
  description = "The AWS Cloudformation StackSet Instance."
}