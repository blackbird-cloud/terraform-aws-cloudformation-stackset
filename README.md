<!-- BEGIN_TF_DOCS -->
# Terraform Aws Cloudformation Stackset Module
Terraform module to create an AWS CloudFormation StackSet

[![blackbird-logo](https://raw.githubusercontent.com/blackbird-cloud/terraform-module-template/main/.config/logo_simple.png)](https://blackbird.cloud)

## Example
```hcl
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
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack_set.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set) | resource |
| [aws_cloudformation_stack_set_instance.accounts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set_instance) | resource |
| [aws_cloudformation_stack_set_instance.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administration_role_arn"></a> [administration\_role\_arn](#input\_administration\_role\_arn) | (Optional) Amazon Resource Number (ARN) of the IAM Role in the administrator account. This must be defined when using the SELF\_MANAGED permission model. | `string` | `null` | no |
| <a name="input_auto_deployment"></a> [auto\_deployment](#input\_auto\_deployment) | (Optional) Whether or not auto-deployment is enabled. | <pre>object({<br/>    enabled                          = bool,<br/>    retain_stacks_on_account_removal = bool<br/>  })</pre> | <pre>{<br/>  "enabled": false,<br/>  "retain_stacks_on_account_removal": false<br/>}</pre> | no |
| <a name="input_call_as"></a> [call\_as](#input\_call\_as) | (Optional) Specifies whether you are acting as an account administrator in the organization's management account or as a delegated administrator in a member account. Valid values: SELF (default), DELEGATED\_ADMIN. | `string` | `"SELF"` | no |
| <a name="input_capabilities"></a> [capabilities](#input\_capabilities) | (Optional) A list of capabilities. Valid values: CAPABILITY\_IAM, CAPABILITY\_NAMED\_IAM, CAPABILITY\_AUTO\_EXPAND | `list(string)` | `[]` | no |
| <a name="input_create_instance"></a> [create\_instance](#input\_create\_instance) | (Optional) Whether to create a stackset instance. Defaults to true. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the StackSet. | `string` | n/a | yes |
| <a name="input_execution_role_name"></a> [execution\_role\_name](#input\_execution\_role\_name) | (Optional) Name of the IAM Role in all target accounts for StackSet operations. Defaults to AWSCloudFormationStackSetExecutionRole when using the SELF\_MANAGED permission model. This should not be defined when using the SERVICE\_MANAGED permission model. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the StackSet. The name must be unique in the region where you create your StackSet. The name can contain only alphanumeric characters (case-sensitive) and hyphens. It must start with an alphabetic character and cannot be longer than 128 characters. | `string` | n/a | yes |
| <a name="input_operation_preferences"></a> [operation\_preferences](#input\_operation\_preferences) | (Optional) Option to configure failure\_tolerance\_count, failure\_tolerance\_percentage, max\_concurrent\_count, max\_concurrent\_percentage, region\_concurrency\_type, and a list of region\_order. | `any` | <pre>{<br/>  "failure_tolerance_count": null,<br/>  "failure_tolerance_percentage": null,<br/>  "max_concurrent_count": null,<br/>  "max_concurrent_percentage": null,<br/>  "region_concurrency_type": null,<br/>  "region_order": null<br/>}</pre> | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Key-value map of input parameters for the StackSet template. All template parameters, including those with a Default, must be configured or ignored with lifecycle configuration block ignore\_changes argument. All NoEcho template parameters must be ignored with the lifecycle configuration block ignore\_changes argument. | `map(string)` | `{}` | no |
| <a name="input_permission_model"></a> [permission\_model](#input\_permission\_model) | (Optional) Describes how the IAM roles required for your StackSet are created. Valid values: SELF\_MANAGED (default), SERVICE\_MANAGED. | `string` | `"SELF_MANAGED"` | no |
| <a name="input_stackset_instance_account_id"></a> [stackset\_instance\_account\_id](#input\_stackset\_instance\_account\_id) | (Optional) Target AWS Account ID to create a Stack based on the StackSet. Defaults to current account. | `string` | `null` | no |
| <a name="input_stackset_instance_accounts"></a> [stackset\_instance\_accounts](#input\_stackset\_instance\_accounts) | The list of AWS Account IDs to which StackSets instance deploys. | `list(string)` | `null` | no |
| <a name="input_stackset_instance_call_as"></a> [stackset\_instance\_call\_as](#input\_stackset\_instance\_call\_as) | (Optional) Specifies whether you are acting as an account administrator in the organization's management account or as a delegated administrator in a member account. Valid values: SELF (default), DELEGATED\_ADMIN. | `string` | `"SELF"` | no |
| <a name="input_stackset_instance_organizational_unit_ids"></a> [stackset\_instance\_organizational\_unit\_ids](#input\_stackset\_instance\_organizational\_unit\_ids) | The organization root ID or organizational unit (OU) IDs to which StackSets instance deploys. | `list(string)` | `null` | no |
| <a name="input_stackset_instance_region"></a> [stackset\_instance\_region](#input\_stackset\_instance\_region) | (Optional) Target AWS Region to create a Stack based on the StackSet. Defaults to current region. | `string` | `null` | no |
| <a name="input_stackset_instance_retain_stack"></a> [stackset\_instance\_retain\_stack](#input\_stackset\_instance\_retain\_stack) | (Optional) During Terraform resource destroy, remove Instance from StackSet while keeping the Stack and its associated resources. Must be enabled in Terraform state before destroy operation to take effect. You cannot reassociate a retained Stack or add an existing, saved Stack to a new StackSet. Defaults to false. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Key-value map of tags to associate with this StackSet and the Stacks created from it. AWS CloudFormation also propagates these tags to supported resources that are created in the Stacks. A maximum number of 50 tags can be specified. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_template_body"></a> [template\_body](#input\_template\_body) | (Optional) String containing the CloudFormation template body. Maximum size: 51,200 bytes. Conflicts with template\_url. | `string` | `null` | no |
| <a name="input_template_url"></a> [template\_url](#input\_template\_url) | (Optional) String containing the location of a file containing the CloudFormation template body. The URL must point to a template that is located in an Amazon S3 bucket. Maximum location file size: 460,800 bytes. Conflicts with template\_body. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_stackset"></a> [stackset](#output\_stackset) | The AWS Cloudformation StackSet. |
| <a name="output_stackset_instance"></a> [stackset\_instance](#output\_stackset\_instance) | The AWS Cloudformation StackSet Instance. |

## About

We are [Blackbird Cloud](https://blackbird.cloud), Amsterdam based cloud consultancy, and cloud management service provider. We help companies build secure, cost efficient, and scale-able solutions.

Checkout our other :point\_right: [terraform modules](https://registry.terraform.io/namespaces/blackbird-cloud)

## Copyright

Copyright © 2017-2025 [Blackbird Cloud](https://blackbird.cloud)
<!-- END_TF_DOCS -->