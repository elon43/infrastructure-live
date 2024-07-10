terraform {
  source = "/home/ubuntu/human-gov-infrastructure/terraform/modules/aws_humangov_infrastructure"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  state_name = ["california","wyoming"] 
}
