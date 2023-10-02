# Introduction


This Project does the following:
- Deploys an azure policy that prevents resources from being created within the subscription unless they have a tag.
- Uses packer to create a VM template which hosts a website that displays the message 'Hello World!'
- Uses terraform to provision the following resources in azure:
  - Availability set
  - OS disks
  - Data disks
  - Load balancer
  - Network interfaces
  - Network security groups
  - Public IP address
  - Virtual Machines
  - Virtual Network

# Instructions

## Deploy the policy

Create the policy definitition:
```
az policy definition create --name tagging-policy --mode indexed --rules policy.json
```
Assign the policy definition:
```
az policy assignment create --policy tagging-policy --name tagging-policy
```

## Create a template using packer

Login to azure:
```
az login
```

Before running packer, create a resource group to contain all the resources:
```
az group create -n myproj-resources -l southindia
```
Create a service principal to allow packer to build templates in azure:
```
az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password }"
```


The following values need to be customised in server.json file:
- managed_image_resource_group_name - The name of the resource group you created in azure
- managed_image_name - The name to give to your template
- os_type - The OS type of the base image
- image_publisher - The publisher of the base image
- image_offer -  The offer of the base image
- image_sku - The SKU of the base image
- location - The region of the image
- vm_size - The size of the VM
- azure_tags:
  - environment: Environment tag
  - project - Project tag
  - owner - Owner tag
  - image - Image tag
- provisioners:
  - inline - The commands to execute on your template

Create the template in azure:
```
packer build server.json
```

## Provision resources using terraform

Download plugins:
```
terraform init
```
The following settings can be customized by editing the variables in the [terraform.tfvars](terraform.tfvars) file:
- prefix - The prefix of all resources in the deployment
- location - The azure region for deployment 
- number_of_vms - Number of VMs to be provisioned
- admin_username - The admin username for the VMs
- admin_password - The admin password for the VMs
- address_space - VNET address space
- subnet - Subnet address space
- environment - Environment tag
- project - Project tag
- owner - Owner tag
- image - The VM image to deploy

Provison the resources:
```
terraform apply
```
Once your resources are no longer required, delete them:
```
terraform destroy
```

