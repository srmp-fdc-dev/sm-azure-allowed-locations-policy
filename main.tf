terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.50.0"
    }
  }
}

provider "azurerm" {
  features {}

  # More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
}

resource "azurerm_policy_definition" "policy" {
  name         = "allowedlocations"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = var.name
  description  = "This policy enables you to restrict the locations your organization can specify when deploying resources. Use to enforce your geo-compliance requirements. Excludes resource groups, Microsoft.AzureActiveDirectory/b2cDirectories, and resources that use the 'global' region."
metadata = <<METADATA
    {
    "version": "1.0.0",
    "category": "${var.policy_definition_category}"
    }
METADATA
policy_rule = <<POLICY_RULE
    {
      "if": {
        "allOf": [
          {
            "field": "location",
            "notIn": "[parameters('location')]"
          },
          {
            "field": "location",
            "notEquals": "global"
          },
          {
            "field": "type",
            "notEquals": "Microsoft.AzureActiveDirectory/b2cDirectories"
          }
        ]
      },
      "then": {
        "effect": "deny"
      }
    }
POLICY_RULE
parameters = <<PARAMETERS
  {
      "location": {
        "type": "Array",
        "metadata": {
          "description": "The list of locations that can be specified when deploying resources.",
          "strongType": "location",
          "displayName": "Allowed locations"
        }
      }
    }
PARAMETERS
}

resource "azurerm_subscription_policy_assignment" "policy_assignment" {
  name                 = var.assign_name
  policy_definition_id = azurerm_policy_definition.policy.id
  display_name         = var.assign_name
  subscription_id      = "/subscriptions/${var.subscription_id}"
  parameters = jsonencode({
  location = {
    value = var.location
  }})
}
