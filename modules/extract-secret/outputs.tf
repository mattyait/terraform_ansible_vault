# Returning the Json format of output
output "mysecret_out" {
  value = "${data.external.mysecret.result}"
}
