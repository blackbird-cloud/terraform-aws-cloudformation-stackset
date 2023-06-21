output "stackset" {
  value       = aws_cloudformation_stack_set.default
  description = "The AWS Cloudformation StackSet."
}

output "stackset_instance" {
  value       = try(aws_cloudformation_stack_set_instance.default[0], null)
  description = "The AWS Cloudformation StackSet Instance."
}