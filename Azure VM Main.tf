resource "azurerm_resource_group" "RG" {
  name     = "Test-RG"
  location = "East US"
}

resource "azurerm_virtual_network" "VNET" {
  name                = "Test-VNET"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
}

resource "azurerm_subnet" "AzureSubnet" {
  name                 = "AzureSubnet"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.VNET.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "Test-nic"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.AzureSubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}