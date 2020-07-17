## Kubernetes on AWS with Terraform

**Overview:**

This project will create:
* VPC with Public and Private Subnets in # Availability Zones
* Bastion Hosts and NAT Gateways in the Public Subnet
* A dynamic number of masters, etcd, and worker nodes in the Private Subnet
 * even distributed over the # of Availability Zones
* AWS ELB in the Public Subnet for accessing the Kubernetes API from the internet

**Requirements**
- Terraform 0.12.0 or newer

**How to Use:**

- Export the variables for your AWS credentials or edit `credentials.tfvars`:

```
export TF_VAR_AWS_ACCESS_KEY_ID="www"
export TF_VAR_AWS_SECRET_ACCESS_KEY ="xxx"
export TF_VAR_AWS_SSH_KEY_NAME="yyy"
export TF_VAR_AWS_DEFAULT_REGION="zzz"
```
- Update `contrib/terraform/aws/terraform.tfvars` with your data. 
- By default, the Terraform scripts use Centos 7 as base image.
- Create an AWS EC2 SSH Key
- Run with `terraform apply --var-file="credentials.tfvars"` or `terraform apply` depending if you exported your AWS credentials

Example:
```
terraform init
terraform plan -var-file=credentials.tfvars
terraform apply -var-file=credentials.tfvars
terraform destroy -var-file=credentials.tfvars
```

```


**Troubleshooting**

***Remaining AWS IAM Instance Profile***:

If the cluster was destroyed without using Terraform it is possible that
the AWS IAM Instance Profiles still remain. To delete them you can use
the `AWS CLI` with the following command:
```
aws iam delete-instance-profile --region <region_name> --instance-profile-name <profile_name>
```
