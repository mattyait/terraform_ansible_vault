## Setting the host/dev machine
Build the docker image

    docker build -t terraform/terraform_ansible_vault:latest -f Dockerfile .

Run the docker container

    docker run -i -d -v $(pwd):/mnt/workspace:Z terraform/terraform_ansible_vault:latest

Enter the Container and use it as a Dev Environment

    docker exec -it $(docker ps | grep terraform_ansible_vault:latest | awk '{print $1}') bash

Setup the AWS Credentials which has sufficient permission

    aws configure
    AWS Access Key ID [None]: *********
    AWS Secret Access Key [None]: **********
    Default region name [None]: ap-southeast-2
    Default output format [Noµne]:

After Setup the Credentials, Initialize the terraform and execute the plan
Set the Ansible vault password env variable ANSIBLE_VAULT_PASSWORD

    export ANSIBLE_VAULT_PASSWORD=devops
    terraform init
    terraform plan

## Module extract-secret

> This module will decrypt the provided encrypted file by using ansible vault and return a json pattern
Use the output in any resource to pass the decrypted value as below

    module.extract-secret.mysecret_out

## Sample encrypted content

    $ANSIBLE_VAULT;1.1;AES256
    38333665636535383365343465306563306137656332386566333837343364356161316364366165
    3562353036323231636362343331623635316366633236630a623834653031336431356535363666
    30633733386163633232376165623765303930646366383261313961616432666331643161626434
    3062306331363038620a373138333064616432386234346338316137396463646161316639623736
    62653863613236616562323862326637343033393163623166346564663734353761646237306138
    39363537383164613534653534623830353764373265663530323338366133343063616665613430
    34643636383937616136343537663866636539623961303535613931316332626537326430653837
    64353265653732313566386162653966333561356162363662303066303766653234646463663538
    34613836366536313961646230363034386163333231656430383033393731643066343334643537
    6439373836336364326166623064643538643466656237373662

# Original value for the above content

    secret_values:
      RDS_Password_sample: "abc1234"
      Ec2_password_sample: "password"
      Private_key_sample: "secret-value"
