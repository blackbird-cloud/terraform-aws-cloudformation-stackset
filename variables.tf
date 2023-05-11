variable "administration_role_arn" {
  type        = string
  description = "(Optional) Amazon Resource Number (ARN) of the IAM Role in the administrator account. This must be defined when using the SELF_MANAGED permission model."
  default     = null
}

variable "auto_deployment" {
  type = object({
    enabled                          = bool,
    retain_stacks_on_account_removal = bool
  })
  default = {
    enabled : false,
    retain_stacks_on_account_removal : false
  }
  description = "(Optional) Whether or not auto-deployment is enabled."
}

variable "name" {
  type        = string
  description = "Name of the StackSet. The name must be unique in the region where you create your StackSet. The name can contain only alphanumeric characters (case-sensitive) and hyphens. It must start with an alphabetic character and cannot be longer than 128 characters."
}

variable "capabilities" {
  type        = list(string)
  description = "(Optional) A list of capabilities. Valid values: CAPABILITY_IAM, CAPABILITY_NAMED_IAM, CAPABILITY_AUTO_EXPAND"
  default     = []
}

variable "operation_preferences" {
  type = any
  default = {
    failure_tolerance_count      = null
    failure_tolerance_percentage = null
    max_concurrent_count         = null
    max_concurrent_percentage    = null
    region_concurrency_type      = null
    region_order                 = null
  }
  description = "(Optional) Option to configure failure_tolerance_count, failure_tolerance_percentage, max_concurrent_count, max_concurrent_percentage, region_concurrency_type, and a list of region_order."
}

variable "description" {
  type        = string
  description = "Description of the StackSet."
}

variable "execution_role_name" {
  type        = string
  description = "(Optional) Name of the IAM Role in all target accounts for StackSet operations. Defaults to AWSCloudFormationStackSetExecutionRole when using the SELF_MANAGED permission model. This should not be defined when using the SERVICE_MANAGED permission model."
  default     = null
}

variable "parameters" {
  description = "Key-value map of input parameters for the StackSet template. All template parameters, including those with a Default, must be configured or ignored with lifecycle configuration block ignore_changes argument. All NoEcho template parameters must be ignored with the lifecycle configuration block ignore_changes argument."
  default     = {}
  type        = map(string)
}

variable "permission_model" {
  description = "(Optional) Describes how the IAM roles required for your StackSet are created. Valid values: SELF_MANAGED (default), SERVICE_MANAGED."
  type        = string
  default     = "SELF_MANAGED"
}

variable "call_as" {
  type        = string
  description = "(Optional) Specifies whether you are acting as an account administrator in the organization's management account or as a delegated administrator in a member account. Valid values: SELF (default), DELEGATED_ADMIN."
  default     = "SELF"
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Key-value map of tags to associate with this StackSet and the Stacks created from it. AWS CloudFormation also propagates these tags to supported resources that are created in the Stacks. A maximum number of 50 tags can be specified. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "template_body" {
  type        = string
  description = "(Optional) String containing the CloudFormation template body. Maximum size: 51,200 bytes. Conflicts with template_url."
  default     = null
}

variable "template_url" {
  type        = string
  description = "(Optional) String containing the location of a file containing the CloudFormation template body. The URL must point to a template that is located in an Amazon S3 bucket. Maximum location file size: 460,800 bytes. Conflicts with template_body."
  default     = null
}

variable "create_instance" {
  type        = bool
  default     = true
  description = "(Optional) Whether to create a stackset instance. Defaults to true."
}

variable "stackset_instance_region" {
  type        = string
  description = "(Optional) Target AWS Region to create a Stack based on the StackSet. Defaults to current region."
  default     = null
}

variable "stackset_instance_account_id" {
  type        = string
  description = "(Optional) Target AWS Account ID to create a Stack based on the StackSet. Defaults to current account."
  default     = null
}

variable "stackset_instance_call_as" {
  type        = string
  description = "(Optional) Specifies whether you are acting as an account administrator in the organization's management account or as a delegated administrator in a member account. Valid values: SELF (default), DELEGATED_ADMIN."
  default     = "SELF"
}

variable "stackset_instance_retain_stack" {
  type        = bool
  description = "(Optional) During Terraform resource destroy, remove Instance from StackSet while keeping the Stack and its associated resources. Must be enabled in Terraform state before destroy operation to take effect. You cannot reassociate a retained Stack or add an existing, saved Stack to a new StackSet. Defaults to false."
  default     = false
}

variable "stackset_instance_organizational_unit_ids" {
  type = list(string)
  description = "The organization root ID or organizational unit (OU) IDs to which StackSets instance deploys."
}

