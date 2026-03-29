resource "alicloud_security_group" "ecs_sg" {
  vpc_id              = var.vpc_id
  security_group_name = "ELK-sg"          # fixed: name → security_group_name
}

locals {
  ecs_instances = {
    ELK = {
      disk_size = 100
    }
  }
}

resource "alicloud_instance" "ecs" {
  for_each             = local.ecs_instances
  instance_name        = "ELK-server"
  instance_type        = "ecs.c6.xlarge"
  image_id             = "ubuntu_24_04_x64_20G_alibase_20250916.vhd"
  vswitch_id           = var.vswitch_id
  security_groups      = [alicloud_security_group.ecs_sg.id]
  system_disk_category = "cloud_essd"
  system_disk_size     = each.value.disk_size
  key_name             = "RamiKey"
}