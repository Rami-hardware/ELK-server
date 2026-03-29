data "alicloud_vpcs" "existing" {
  name_regex = "FAC-VPC"
}

data "alicloud_vswitches" "existing" {
  ids = ["vsw-l4vvxjkc508ncrc9lin9k"]
}

module "ecs" {
  source = "./modules"
  vpc_id     = data.alicloud_vpcs.existing.vpcs[0].id
  vswitch_id = data.alicloud_vswitches.existing.vswitches[0].id
}

