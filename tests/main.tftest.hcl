mock_provider "aws" {}

run "plan" {
  command = plan
  variables {
    name        = "test-stackset"
    description = "Test stackset"
  }
}
