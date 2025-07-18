output "values" {
  value = tomap(data.external.mvnets.result)
}

output "id" {
  value = data.external.mvnets.result.id
}

output "name" {
  value = data.external.mvnets.result.name
}