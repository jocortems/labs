provider "megaport" {
    username                = var.megaport_username
    password                = var.megaport_password
    accept_purchase_terms   = true
    delete_ports            = true
    environment             = "production"
}

data "megaport_location" "megaport_location" {
  name    = var.mcr_location
  has_mcr = true
}

// aws partner port
data "megaport_partner_port" "aws_port" {
  connect_type = "AWS"
  company_name = "AWS"
  product_name = var.aws_destination_port
  location_id  = data.megaport_location.megaport_location.id
}

// mcr
resource "megaport_mcr" "megaport_mcr" {
  mcr_name    = var.mcr_name
  location_id = data.megaport_location.megaport_location.id

  router {
    port_speed    = 5000
    requested_asn = var.mcr_asn
  }
}

resource "megaport_azure_connection" "azure_vcx" {
  vxc_name = var.vcx_azure
  rate_limit = 1000

  a_end {
    requested_vlan = var.expressroute_vlan
  }

  csp_settings {
    attached_to = megaport_mcr.megaport_mcr.id
    service_key = azurerm_express_route_circuit.er_ckt.service_key
    peerings {
      private_peer = true
      microsoft_peer = false
    }
  }
}

// mcr to aws vxc
resource "megaport_aws_connection" "aws_vcx" {
  vxc_name   = var.vcx_aws
  rate_limit = 1000

  a_end {
    requested_vlan = var.dx_vlan
  }

  csp_settings {
    attached_to          = megaport_mcr.megaport_mcr.id
    requested_product_id = data.megaport_partner_port.aws_port.id
    requested_asn        = var.aws_csp_asn
    amazon_asn           = aws_dx_gateway.dx_gateway.amazon_side_asn
    amazon_account       = data.aws_caller_identity.current.account_id
  }
}