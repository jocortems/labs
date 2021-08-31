resource "azurerm_public_ip" "nva_vm_vip" {
  name                = "nva-vm-vip"
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nva_vm_nic" {
  name                = "nva-vm-nic"
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name  
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = cidrhost(azurerm_subnet.vm_subnet.address_prefixes[0],100)
    public_ip_address_id = azurerm_public_ip.nva_vm_vip.id
  }
}

resource "azurerm_linux_virtual_machine" "nva_vm" {
  name                = "nva-vm"
  resource_group_name = azurerm_resource_group.vpn_example.name
  location            = azurerm_resource_group.vpn_example.location
  size                = var.azure_vm_sku
  admin_username      = var.azure_vm_admin_username
  network_interface_ids = [
    azurerm_network_interface.nva_vm_nic.id,
  ]

  custom_data = filebase64("cloud-init.txt")

  disable_password_authentication = true
  admin_ssh_key {
        public_key = file(var.ssh_pubkey)
        username = var.azure_vm_admin_username
    }
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_route_table" "gatewaysubnet_rt" {
  name                          = "gatewaysubnet-rt"
  location                      = azurerm_resource_group.vpn_example.location
  resource_group_name           = azurerm_resource_group.vpn_example.name
  disable_bgp_route_propagation = false

  route {
    name           = "to-nva-vm"
    address_prefix = azurerm_virtual_network.vpn_example.address_space[0]
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_network_interface.nva_vm_nic.private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "gatewaysubnet_rt_association" {
  subnet_id      = azurerm_subnet.vpngateway_example.id
  route_table_id = azurerm_route_table.gatewaysubnet_rt.id
}