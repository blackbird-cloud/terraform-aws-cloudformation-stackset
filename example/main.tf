module "account_info" {
  source  = "blackbird-cloud/account-info/aws"
  version = "~> 1"
}

module "stackset" {
  source  = "blackbird-cloud/cloudformation-stackset/aws"
  version = "~> 1"

  name         = "AWSCloudFormationStackSetExecutionRole"
  template_url = "https://s3.amazonaws.com/cloudformation-stackset-sample-templates-us-east-1/AWSCloudFormationStackSetExecutionRole.yml"
  description  = "Cloudformation account execution role."

  parameters = {
    AdministratorAccountId = module.account_info.account_id
  }

  auto_deployment = {
    enabled                          = true
    retain_stacks_on_account_removal = false
  }

  capabilities = ["CAPABILITY_NAMED_IAM"]

  operation_preferences = {
    max_concurrent_count    = 10
    failure_tolerance_count = 9
    region_concurrency_type = "PARALLEL"
  }

  permission_model = "SERVICE_MANAGED"
  stackset_instance_organizational_unit_ids = [
    "r-12345"
  ]
}
