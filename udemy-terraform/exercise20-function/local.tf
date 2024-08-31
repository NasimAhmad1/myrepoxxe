locals {
  name = "Nasim Ahmad"
  age = 32
  my_object = {
    key1 = 10
    key2 = "my_value"
  }
}

output "example1" {
  value = lower(local.name)
}

output "upper_name" {
  value = upper(local.name)
}

output "power" {
  value = pow(local.age, 2)
}

output "startwith" {
  value = startswith(lower(local.name), "Nasim")
}
output "userlist" {
  value = yamldecode(file("${path.module}/user.yaml"))
}