locals {
  project = "Project-IAC"
  project_owner = "Nasim Ahmad"
  cost_center = "cost12324"
  managed_by = "IAC"
}

locals {
  common_tag ={
    project = locals.project
    project_owner = locals.project_owner
    cost_center = locals.cost_center
    managed_by = locals.managed_by
  }
}