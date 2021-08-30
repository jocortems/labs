variable "megaport_username" {
    type = string
    description = "Megaport Dashboard login username"
}
variable "megaport_password" {
    type = string
    description = "Megaport Dashboard login password"
}

variable "mcr_location" {
    type = string
    description = "Megaport Cloud Router Location"
    default = "Equinix DC2"
}

variable "aws_destination_port" {
    type = string
    description = "AWS Destination Port from Megaport"
    default = "US East (N. Virginia) (us-east-1)"
}

variable "mcr_name" {
    type = string
    description = "Megaport MCR Name"
}

variable "mcr_asn" {
    type = number
    description = "Megaport MCR ASN. Must be different from AWS and AZURE"
    default = 64600
}

variable "aws_csp_asn" {
    type = number
    description = "Megaport MCR AWS VCX ASN. Must be different from mcr_asn, AWS DxGW ASN and Azure"
    default = 64650
}

variable "vcx_azure" {
    type = string
    description = "Megaport MCR VCX to Azure"
    default = "azure-expressroute"
}

variable "vcx_aws" {
    type = string
    description = "Megaport MCR VCX to AWS"
    default = "aws-hostedvif"
}

