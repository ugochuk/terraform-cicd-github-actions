config {
  format = "compact"
}

plugin "azurerm" {
  enabled = true
  preset  = "recommended"
  version = "0.27.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}
