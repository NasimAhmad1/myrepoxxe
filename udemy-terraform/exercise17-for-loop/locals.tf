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

locals {
  doubled_number = [for num in var.number_list: num * 2 ]
}

locals {
  even_number = [for num in var.number_list : num if num % 2 == 0]
}

locals {
  firstname = [for name in var.objet_list: name.firstname]
}

locals {
  fullname = [for name in var.objet_list: "${name.firstname} ${name.lastname}" ]
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