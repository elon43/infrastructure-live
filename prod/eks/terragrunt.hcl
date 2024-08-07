terraform {
  source = "git@github.com:elon43/infrastructure-modules.git//eks?ref=eks-v0.0.3"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path = find_in_parent_folders("env.hcl")
  expose = true
  merge_strategy = "no_merge"
}

inputs = {

  eks_version = "1.29"
  env = include.env.locals.env
  eks_name = "demo"
  subnet_ids = dependency.vpc.outputs.private_subnet_ids
  node_groups = {
    general = {
      capacity_type = "SPOT"
      instance_types = ["t3a.xlarge","t3.xlarge","t2.large","m4.xlarge","m5.xlarge"]
      scaling_config = {
        desired_size = 1
        max_size = 10
        min_size = 0
      }
    }
  }
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    private_subnet_ids = ["subnet-1234","subnet-5678"]
  }


}
