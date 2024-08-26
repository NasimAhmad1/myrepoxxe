locals {
  project = "Project-IAC"
  project_owner = "Nasim Ahmad"
  cost_center = "cost12324"
  managed_by = "IAC"
}

locals {
  common_tag ={
    project = local.project
    project_owner = local.project_owner
    cost_center = local.cost_center
    managed_by = local.managed_by
    sensative_tag = var.sensative_tag
  }
}