resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = "West US"
}

resource "azurerm_virtual_network" "example" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"
}

resource "azurerm_subnet" "example" {
  name                 = "acctsub"
  resource_group_name  = "${azurerm_resource_group.example.name}"
  virtual_network_name = "${azurerm_virtual_network.example.name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_storage_account" "example" {
  name                     = "${var.prefix}stor"
  resource_group_name      = "${azurerm_resource_group.example.name}"
  location                 = "${azurerm_resource_group.example.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "example" {
  name                  = "vhds"
  resource_group_name   = "${azurerm_resource_group.example.name}"
  storage_account_name  = "${azurerm_storage_account.example.name}"
  container_access_type = "private"
}
