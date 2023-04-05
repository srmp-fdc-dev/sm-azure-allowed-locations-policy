# Terraform Azure Allowed Locations Policy Module

This module creates an Azure Policy Definition and Assignment to enforce required tags on Azure resources.

## Usage

module "tagging_policy" {
source = "./tagging_policy"
policy_name = "required-tags"
display_name = "Enforce Required Tags"
description = "This policy requires that all resources are tagged with specific key-value pairs."
policy_mode = "All"
required_tags = [
{
tagName = "Environment"
tagValue = "Prod"
},
{
tagName = "Owner"
tagValue = "IT"
}
]
scope = "/subscriptions/b1db2d61-6edf-4e6f-b42f-286904728d93/resourceGroups/OfficeVMs"
}


## Inputs

| Name              | Description                                                                      | Type   | Default | Required |
|-------------------|----------------------------------------------------------------------------------|--------|---------|----------|
| allowed_locations | The list of locations that can be specified when deploying resources             | list   | n/a     | yes      |
| subscriptions     | A list of subscriptions to apply the policy                                      | list   | n/a     | yes      |


## Example

terraform plan -var 'location=["westus2","westus"]' -var 'subscription=["b1db2d61-6edf-4e6f-b42f-286904728d93"]'

Sign in using az login from Powershell is required to run the main.tf 

