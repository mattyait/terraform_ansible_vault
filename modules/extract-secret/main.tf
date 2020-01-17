data "external" "mysecret" {
  # Call the script to run the `ansible -m debug` command
  program = ["bash", "-c", "${path.module}/get_ansible_secret.sh"]

  query = {
    # Set the output in this key
    var                 = "${var.secret_value_key}"
    vault_password_file = "${path.module}/vault-password.sh"
    # The file containing the secret we want to decrypt
    file = "${var.encrypted_ansible_vault}"
  }
}
