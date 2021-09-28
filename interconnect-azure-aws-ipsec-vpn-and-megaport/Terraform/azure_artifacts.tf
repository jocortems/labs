terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.74.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.56.0"
    }
    megaport = {
      source = "megaport/megaport"
      version = "0.1.9"
    }
  }  
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "vpn_example" {
  name     = var.azure_resource_group_name
  location = var.azure_location["East US 2"]
}

resource "azurerm_virtual_network" "vpn_example" {
  name                = var.azure_vnet_name
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name
  address_space       = var.azure_vnet_address_space
}

resource "azurerm_subnet" "vpngateway_example" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.vpn_example.name
  virtual_network_name = azurerm_virtual_network.vpn_example.name
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.vpn_example.address_space[0],8,255)]
}

resource "azurerm_subnet" "vm_subnet" {
  name                 = var.azure_vm_subnet_name
  resource_group_name  = azurerm_resource_group.vpn_example.name
  virtual_network_name = azurerm_virtual_network.vpn_example.name
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.vpn_example.address_space[0],8,0)]
}

resource "azurerm_express_route_circuit" "er_ckt" {
    name = var.azure_expressroute_circuit
    location            = azurerm_resource_group.vpn_example.location
    resource_group_name = azurerm_resource_group.vpn_example.name
    service_provider_name = var.expressroute_serviceprovider_name["Megaport"]
    peering_location = var.expressroute_peering_location["WashingtonDC2"]
    bandwidth_in_mbps = var.expressroute_bandwidth["50"]

    sku {
        tier = var.expressroute_tier["standard"]
        family = var.expressroute_family["metered"]
    }

}

resource "azurerm_virtual_network_gateway" "ergw" {
    name = var.expressroute_gateway
    location            = azurerm_resource_group.vpn_example.location
    resource_group_name = azurerm_resource_group.vpn_example.name

    type = "ExpressRoute"
    sku = var.expressroute_gateway_sku["Standard"]

    ip_configuration {
    name = "ergw_ipconfig"
    public_ip_address_id          = azurerm_public_ip.erg_vip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vpngateway_example.id
  }
}

resource "azurerm_express_route_circuit_authorization" "exr_auth_key" {
  name                       = var.exr_auth_key
  express_route_circuit_name = azurerm_express_route_circuit.er_ckt.name
  resource_group_name        = azurerm_resource_group.vpn_example.name
}

resource "azurerm_virtual_network_gateway_connection" "exr_connection" {
  depends_on = [megaport_azure_connection.azure_vcx]

  name                = var.exr_connection
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name

  type                       = "ExpressRoute"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.ergw.id
  authorization_key = azurerm_express_route_circuit_authorization.exr_auth_key.authorization_key
  express_route_circuit_id = azurerm_express_route_circuit.er_ckt.id
}

resource "azurerm_local_network_gateway" "aws_vpn_cgw_0" {
  depends_on = [aws_vpn_connection.aws_to_azure_vngw_in_0]

  name                = var.azure_lng_connection_1
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name
  gateway_address     = aws_vpn_connection.aws_to_azure_vngw_in_0.tunnel1_address
  address_space       = [format("%s/32",aws_vpn_connection.aws_to_azure_vngw_in_0.tunnel1_vgw_inside_address)]

  bgp_settings {
    asn = var.aws_vpn_asn
    bgp_peering_address = aws_vpn_connection.aws_to_azure_vngw_in_0.tunnel1_vgw_inside_address
    peer_weight = 200 
  }
}

resource "azurerm_local_network_gateway" "aws_vpn_cgw_0_b" {
  depends_on = [aws_vpn_connection.aws_to_azure_vngw_in_0]

  name                = var.azure_lng_connection_1_b
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name
  gateway_address     = aws_vpn_connection.aws_to_azure_vngw_in_0.tunnel2_address
  address_space       = [format("%s/32",aws_vpn_connection.aws_to_azure_vngw_in_0.tunnel2_vgw_inside_address)]

  bgp_settings {
    asn = var.aws_vpn_asn
    bgp_peering_address = aws_vpn_connection.aws_to_azure_vngw_in_0.tunnel2_vgw_inside_address
    peer_weight = 200 
  }
}

resource "azurerm_local_network_gateway" "aws_vpn_cgw_1" {
  depends_on = [aws_vpn_connection.aws_to_azure_vngw_in_1]

  name                = var.azure_lng_connection_2
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name
  gateway_address     = aws_vpn_connection.aws_to_azure_vngw_in_1.tunnel1_address
  address_space       = [format("%s/32",aws_vpn_connection.aws_to_azure_vngw_in_1.tunnel1_vgw_inside_address)]

  bgp_settings {
    asn = var.aws_vpn_asn
    bgp_peering_address = aws_vpn_connection.aws_to_azure_vngw_in_1.tunnel1_vgw_inside_address
    peer_weight = 200 
  }
}

resource "azurerm_local_network_gateway" "aws_vpn_cgw_1_b" {
  depends_on = [aws_vpn_connection.aws_to_azure_vngw_in_1]

  name                = var.azure_lng_connection_2_b
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name
  gateway_address     = aws_vpn_connection.aws_to_azure_vngw_in_1.tunnel2_address
  address_space       = [format("%s/32",aws_vpn_connection.aws_to_azure_vngw_in_1.tunnel2_vgw_inside_address)]

  bgp_settings {
    asn = var.aws_vpn_asn
    bgp_peering_address = aws_vpn_connection.aws_to_azure_vngw_in_1.tunnel2_vgw_inside_address
    peer_weight = 200 
  }
}

resource "azurerm_public_ip" "vng_vip_0" {
  name                = var.azure_vng_vip_0
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "vng_vip_1" {
  name                = var.azure_vng_vip_1
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "erg_vip" {
  name                = var.azure_erg_vip
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vpn_example" {
  name                = var.azure_vpn_gateway_name
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name

  type     = "Vpn"
  vpn_type = "RouteBased"
  generation = "Generation2"

  active_active = true
  enable_bgp    = true
  sku           = var.azure_vpn_gateway_sku["VpnGw2"]  
  
  bgp_settings {
    asn = var.azure_vpngw_asn
    peering_addresses {
      ip_configuration_name = "vnetGatewayConfig_in0"
      apipa_addresses = [
           cidrhost(var.aws_vpn_connection_1_tunnel1_bgp_cidr, 2)
      ]
    }
  peering_addresses  {
      ip_configuration_name = "vnetGatewayConfig_in1"
      apipa_addresses = [
          cidrhost(var.aws_vpn_connection_2_tunnel1_bgp_cidr, 2)
      ]
  }    
  }

  ip_configuration {
    name = "vnetGatewayConfig_in0"
    public_ip_address_id          = azurerm_public_ip.vng_vip_0.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vpngateway_example.id
  }

  ip_configuration {
    name = "vnetGatewayConfig_in1"
    public_ip_address_id          = azurerm_public_ip.vng_vip_1.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vpngateway_example.id
  }
}

data "azurerm_public_ip" "vng_vip_0" {
  depends_on = [azurerm_virtual_network_gateway.vpn_example]

  name                = azurerm_public_ip.vng_vip_0.name
  resource_group_name = azurerm_public_ip.vng_vip_0.resource_group_name
}

data "azurerm_public_ip" "vng_vip_1" {
  depends_on = [azurerm_virtual_network_gateway.vpn_example]

  name                = azurerm_public_ip.vng_vip_1.name
  resource_group_name = azurerm_public_ip.vng_vip_1.resource_group_name
}

resource "azurerm_virtual_network_gateway_connection" "aws_cgw_connection_0" {
  name                = var.azure_aws_vpn_connection_name_1
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_example.id
  local_network_gateway_id   = azurerm_local_network_gateway.aws_vpn_cgw_0.id

  shared_key = var.azure_aws_vpn_shared_key
  enable_bgp = true

  ipsec_policy {
      dh_group = "DHGroup14"
      ike_encryption = "AES256"
      ike_integrity = "SHA256"
      ipsec_encryption = "GCMAES256"
      ipsec_integrity = "GCMAES256"
      pfs_group = "PFS14"
      sa_lifetime = 3600
  }
}

resource "azurerm_virtual_network_gateway_connection" "aws_cgw_connection_0_b" {
  name                = var.azure_aws_vpn_connection_name_1_b
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_example.id
  local_network_gateway_id   = azurerm_local_network_gateway.aws_vpn_cgw_0_b.id

  shared_key = var.azure_aws_vpn_shared_key
  enable_bgp = true

  ipsec_policy {
      dh_group = "DHGroup14"
      ike_encryption = "AES256"
      ike_integrity = "SHA256"
      ipsec_encryption = "GCMAES256"
      ipsec_integrity = "GCMAES256"
      pfs_group = "PFS14"
      sa_lifetime = 3600
  }
}

resource "azurerm_virtual_network_gateway_connection" "aws_cgw_connection_1" {
  name                = var.azure_aws_vpn_connection_name_2
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_example.id
  local_network_gateway_id   = azurerm_local_network_gateway.aws_vpn_cgw_1.id

  shared_key = var.azure_aws_vpn_shared_key
  enable_bgp = true

  ipsec_policy {
      dh_group = "DHGroup14"
      ike_encryption = "AES256"
      ike_integrity = "SHA256"
      ipsec_encryption = "GCMAES256"
      ipsec_integrity = "GCMAES256"
      pfs_group = "PFS14"
      sa_lifetime = 3600
  }
}

resource "azurerm_virtual_network_gateway_connection" "aws_cgw_connection_1_b" {
  name                = var.azure_aws_vpn_connection_name_2_b
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_example.id
  local_network_gateway_id   = azurerm_local_network_gateway.aws_vpn_cgw_1_b.id

  shared_key = var.azure_aws_vpn_shared_key
  enable_bgp = true

  ipsec_policy {
      dh_group = "DHGroup14"
      ike_encryption = "AES256"
      ike_integrity = "SHA256"
      ipsec_encryption = "GCMAES256"
      ipsec_integrity = "GCMAES256"
      pfs_group = "PFS14"
      sa_lifetime = 3600
  }
}

resource "azurerm_public_ip" "vm_vip" {
  name                = var.azure_vm_vip
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "vpn_vm" {
  name                = var.azure_vm_nic_name
  location            = azurerm_resource_group.vpn_example.location
  resource_group_name = azurerm_resource_group.vpn_example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = cidrhost(azurerm_subnet.vm_subnet.address_prefixes[0],10)
    public_ip_address_id = azurerm_public_ip.vm_vip.id
  }
}

resource "azurerm_linux_virtual_machine" "vpn_vm" {
  name                = var.azure_vm_name
  resource_group_name = azurerm_resource_group.vpn_example.name
  location            = azurerm_resource_group.vpn_example.location
  size                = var.azure_vm_sku
  admin_username      = var.azure_vm_admin_username
  network_interface_ids = [
    azurerm_network_interface.vpn_vm.id,
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

output "azure_vm_public_ip" {
    value = azurerm_linux_virtual_machine.vpn_vm.public_ip_address
}