resource "aws_cloudformation_stack_set" "default" {
  name        = var.name
  description = var.description
  tags        = var.tags

  permission_model = var.permission_model
  call_as          = var.call_as

  execution_role_name     = var.execution_role_name
  administration_role_arn = var.administration_role_arn

  capabilities = var.capabilities
  parameters   = var.parameters

  dynamic "auto_deployment" {
    for_each = var.auto_deployment.enabled ? [1] : []
    content {
      retain_stacks_on_account_removal = var.auto_deployment.retain_stacks_on_account_removal
      enabled                          = var.auto_deployment.enabled
    }
  }

  operation_preferences {
    failure_tolerance_count      = try(var.operation_preferences.failure_tolerance_count, null)
    failure_tolerance_percentage = try(var.operation_preferences.failure_tolerance_percentage, null)
    max_concurrent_count         = try(var.operation_preferences.max_concurrent_count, null)
    max_concurrent_percentage    = try(var.operation_preferences.max_concurrent_percentage, null)
    region_concurrency_type      = try(var.operation_preferences.region_concurrency_type, null)
    region_order                 = try(var.operation_preferences.region_order, null)
  }

  template_body = var.template_body
  template_url  = var.template_url
}

resource "aws_cloudformation_stack_set_instance" "default" {
  count = var.create_instance == true ? 1 : 0

  dynamic "deployment_targets" {
    for_each = var.stackset_instance_organizational_unit_ids != null ? [1] : []

    content {
      organizational_unit_ids = var.stackset_instance_organizational_unit_ids
    }
  }

  dynamic "deployment_targets" {
    for_each = var.stackset_instance_accounts != null ? [1] : []

    content {
      accounts = var.stackset_instance_accounts
    }
  }

  retain_stack   = var.stackset_instance_retain_stack
  call_as        = var.stackset_instance_call_as
  region         = var.stackset_instance_region
  account_id     = var.stackset_instance_account_id
  stack_set_name = aws_cloudformation_stack_set.default.name
}
