locals {
  math = 2 * 2
  equality = 2 != 2
  comparison = 2 < 1
  logical = true || false
}

output "operator" {
    value = {
 Multiplicatin = local.math
  equality = local.equality
  comparison = local.comparison
  logical = local.logical

    }

}
## List and Map
locals {
  doubled_number = [for num in var.number_list: num * 2 ]
  even_number = [for num in var.number_list : num if num % 2 == 0]
  firstname = [for name in var.objet_list: name.firstname]
  fullname = [for name in var.objet_list: "${name.firstname} ${name.lastname}" ]
}

##List of map

locals {
  doubled_number_map = {for key, value in var.list_map: key => value *2 }
  even_number_map = {for key, value in var.list_map: key => value * 2 if value % 2 ==0 }
}

## List into map and vice versa

locals {
  user_map = {
    for user_map in var.users: user_map.username => user_map.roles...
  }
}

locals {
  user_map2 = {
    for username, roles in local.user_map: username => { role = roles}
  }
}


output "doubled_number" {
  value = local.doubled_number
}

output "even_number" {
  value = local.even_number
}
output "firstname" {
  value = local.firstname
}

output "fullname" {
  value = local.fullname
}

output "doubled_number_map" {
  value = local.doubled_number_map
}

output "even_number_map" {
  value = local.even_number_map 
}

output "user_map" {
  value = local.user_map
}

output "user_map2" {
  value = local.user_map2
}

output "user_to_roles" {
  value = local.user_map2[var.user_to_output].roles
}