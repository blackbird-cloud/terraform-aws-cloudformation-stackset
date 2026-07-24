mock_provider "aws" {}

run "plan" {
  command = plan
  variables {
    name        = "test-stackset"
    description = "Test stackset"
    # length(null) fails in the stack_set_instance for_each; the module
    # defaults this to null, so consumers must always pass a list.
    stackset_instance_organizational_unit_ids = []
  }
}
