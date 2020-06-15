#!/bin/bash

# debug
#export TF_LOG=TRACE

terraform validate
terraform plan -var 'secret-map={target1="1", target2="2"}'
terraform apply -var 'secret-map={target1="1", target2="2"}' -auto-approve