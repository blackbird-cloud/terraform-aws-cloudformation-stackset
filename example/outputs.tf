output "stackset" {
  value       = module.stackset.stackset
  description = "The AWS Cloudformation StackSet."
}

output "stackset_instance" {
  value       = module.stackset.stackset_instance
  description = "The AWS Cloudformation StackSet Instance."
}
