resource "aws_secretsmanager_secret" "secret" {
  name        = "${var.secret_name}"
  description = "${var.secret_description}"
  tags = {
    Name       = "${var.secret_name}"
    Created_By = "Terraform"
  }
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = "${aws_secretsmanager_secret.secret.id}"
  secret_string = "${jsonencode(module.extract-secret.mysecret_out)}"
}

#Fetching the whole collection of secrets as map from encrypted.tfvar.yaml
module "extract-secret" {
  source                  = "./modules/extract-secret"
  secret_value_key        = "secret_values"
  encrypted_ansible_vault = "encrypted.tfvar.yaml"
}
