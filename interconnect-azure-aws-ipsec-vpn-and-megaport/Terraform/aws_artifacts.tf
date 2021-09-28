provider "aws" {
  region = var.aws_region
  shared_credentials_file = file(var.aws_credentials)
}

data "aws_caller_identity" "current" {}

resource "aws_vpc" "vpc_to_azure" {
  cidr_block = var.aws_vpc_cidr
}

resource "aws_subnet" "ec2_subnet" {
    vpc_id = aws_vpc.vpc_to_azure.id
    cidr_block = cidrsubnet(var.aws_vpc_cidr,8,0)

    depends_on = [aws_internet_gateway.vpc_igw]
}

resource "aws_security_group" "ec2_vpc_sg" {
    name = var.aws_vpc_sg_name
    description = "ALLOW ALL TRAFFIC FOR TESTING PURPOSES"
    vpc_id = aws_vpc.vpc_to_azure.id

    ingress = [
        {
            description = "Allow all traffic"
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
            prefix_list_ids = []
            security_groups = []
            self = false
        }
    ]

    egress = [
    {
      description = "Allow all traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]
}

resource "aws_network_acl" "vpc_acl" {
    vpc_id = aws_vpc.vpc_to_azure.id
    subnet_ids = [aws_subnet.ec2_subnet.id]

    ingress = [
        {
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_block = "0.0.0.0/0"
            action = "allow"
            rule_no = 100
            icmp_code = 0
            icmp_type = 0
            ipv6_cidr_block = ""
        }
    ]

    egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_block      = "0.0.0.0/0"
      action = "allow"
      rule_no = 100
      icmp_code = 0
      icmp_type = 0
      ipv6_cidr_block = ""
    }
  ]
}

resource "aws_internet_gateway" "vpc_igw" {
    vpc_id = aws_vpc.vpc_to_azure.id
}

resource "aws_route_table" "vpc_route_table" {
    vpc_id = aws_vpc.vpc_to_azure.id

    route = [
        {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.vpc_igw.id
        carrier_gateway_id = ""
        destination_prefix_list_id = ""
        egress_only_gateway_id = ""
        instance_id = ""
        ipv6_cidr_block = ""
        local_gateway_id = ""
        nat_gateway_id = ""
        network_interface_id = ""
        transit_gateway_id = ""
        vpc_endpoint_id = ""
        vpc_peering_connection_id = ""
        }
    ]
}

resource "aws_route_table_association" "ec2_subnet_rt" {
  subnet_id      = aws_subnet.ec2_subnet.id
  route_table_id = aws_route_table.vpc_route_table.id
}
resource "aws_vpn_gateway" "aws_vpc_vngw" {
    vpc_id = aws_vpc.vpc_to_azure.id
    amazon_side_asn = var.aws_vpn_asn
}

resource "aws_vpn_gateway_route_propagation" "aws_vngw_rt" {
    vpn_gateway_id = aws_vpn_gateway.aws_vpc_vngw.id
    route_table_id = aws_route_table.vpc_route_table.id
}

resource "aws_customer_gateway" "azure_vngw_in_0" {
    depends_on = [azurerm_virtual_network_gateway.vpn_example]

    bgp_asn = var.azure_vpngw_asn
    device_name = var.azure_vng_vip_0
    type = "ipsec.1"
    ip_address = data.azurerm_public_ip.vng_vip_0.ip_address
}

resource "aws_customer_gateway" "azure_vngw_in_1" {
    depends_on = [azurerm_virtual_network_gateway.vpn_example]

    bgp_asn = var.azure_vpngw_asn
    device_name = var.azure_vng_vip_1
    type = "ipsec.1"
    ip_address = data.azurerm_public_ip.vng_vip_1.ip_address
}

resource "aws_vpn_connection" "aws_to_azure_vngw_in_0" {
    depends_on = [azurerm_virtual_network_gateway.vpn_example]

    vpn_gateway_id      = aws_vpn_gateway.aws_vpc_vngw.id
    customer_gateway_id = aws_customer_gateway.azure_vngw_in_0.id
    type                = "ipsec.1"
    tunnel1_inside_cidr = var.aws_vpn_connection_1_tunnel1_bgp_cidr
    tunnel2_inside_cidr = var.aws_vpn_connection_1_tunnel2_bgp_cidr
    tunnel1_preshared_key = var.azure_aws_vpn_shared_key
    tunnel2_preshared_key = var.azure_aws_vpn_shared_key
    tunnel1_ike_versions = ["ikev2"]
    tunnel2_ike_versions = ["ikev2"]
    tunnel1_phase1_dh_group_numbers = [14]
    tunnel2_phase1_dh_group_numbers = [14]
    tunnel1_phase1_encryption_algorithms = ["AES256"]
    tunnel2_phase1_encryption_algorithms = ["AES256"]
    tunnel1_phase1_integrity_algorithms = ["SHA2-256"]
    tunnel2_phase1_integrity_algorithms = ["SHA2-256"]
    tunnel1_phase2_dh_group_numbers = [14]
    tunnel2_phase2_dh_group_numbers = [14]
    tunnel1_phase2_encryption_algorithms = ["AES256-GCM-16"]
    tunnel2_phase2_encryption_algorithms = ["AES256-GCM-16"]
    tunnel1_startup_action = "start"
    tunnel2_startup_action = "start"
    tunnel1_phase1_lifetime_seconds = 28000
    tunnel2_phase1_lifetime_seconds = 28000
    tunnel1_phase2_lifetime_seconds = 3600
    tunnel2_phase2_lifetime_seconds = 3600
}

resource "aws_vpn_connection" "aws_to_azure_vngw_in_1" {
    depends_on = [azurerm_virtual_network_gateway.vpn_example]

    vpn_gateway_id      = aws_vpn_gateway.aws_vpc_vngw.id
    customer_gateway_id = aws_customer_gateway.azure_vngw_in_1.id
    type                = "ipsec.1"
    tunnel1_inside_cidr = var.aws_vpn_connection_2_tunnel1_bgp_cidr
    tunnel2_inside_cidr = var.aws_vpn_connection_2_tunnel2_bgp_cidr
    tunnel1_preshared_key = var.azure_aws_vpn_shared_key
    tunnel2_preshared_key = var.azure_aws_vpn_shared_key
    tunnel1_ike_versions = ["ikev2"]
    tunnel2_ike_versions = ["ikev2"]
    tunnel1_phase1_dh_group_numbers = [14]
    tunnel2_phase1_dh_group_numbers = [14]
    tunnel1_phase1_encryption_algorithms = ["AES256"]
    tunnel2_phase1_encryption_algorithms = ["AES256"]
    tunnel1_phase1_integrity_algorithms = ["SHA2-256"]
    tunnel2_phase1_integrity_algorithms = ["SHA2-256"]
    tunnel1_phase2_dh_group_numbers = [14]
    tunnel2_phase2_dh_group_numbers = [14]
    tunnel1_phase2_encryption_algorithms = ["AES256-GCM-16"]
    tunnel2_phase2_encryption_algorithms = ["AES256-GCM-16"]
    tunnel1_startup_action = "start"
    tunnel2_startup_action = "start"
    tunnel1_phase1_lifetime_seconds = 28000
    tunnel2_phase1_lifetime_seconds = 28000
    tunnel1_phase2_lifetime_seconds = 3600
    tunnel2_phase2_lifetime_seconds = 3600
}

resource "aws_dx_gateway" "dx_gateway" {
  name            = var.dx_gateway
  amazon_side_asn = var.dx_asn
}

resource "aws_dx_gateway_association" "dx_gateway_to_vpn_gateway" {
  dx_gateway_id         = aws_dx_gateway.dx_gateway.id
  associated_gateway_id = aws_vpn_gateway.aws_vpc_vngw.id
}

resource "aws_dx_hosted_private_virtual_interface_accepter" "megaport_vif" {
  virtual_interface_id = megaport_aws_connection.aws_vcx.aws_id
  dx_gateway_id         = aws_dx_gateway.dx_gateway.id
  
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.aws_ec2_key_pair
  public_key = file(var.ssh_pubkey)
}

resource "aws_network_interface" "ec2_nic" {
  subnet_id   = aws_subnet.ec2_subnet.id
  private_ips = [cidrhost(aws_subnet.ec2_subnet.cidr_block,10)]
  security_groups = [aws_security_group.ec2_vpc_sg.id]
}

resource "aws_eip" "ec2_eip" {
  vpc                       = true
  network_interface         = aws_network_interface.ec2_nic.id

  depends_on = [aws_internet_gateway.vpc_igw]
}

resource "aws_instance" "ec2_instance" {
  ami           = var.aws_ami
  instance_type = "t2.micro"
  key_name = aws_key_pair.ec2_key_pair.key_name

  network_interface {
    network_interface_id = aws_network_interface.ec2_nic.id
    device_index         = 0
  }
}

output "aws_ec2_eip" {
    value = aws_eip.ec2_eip.public_ip
}


