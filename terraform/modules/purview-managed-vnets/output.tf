output "values" {
  value = tomap(data.external.mvnets.result)
}