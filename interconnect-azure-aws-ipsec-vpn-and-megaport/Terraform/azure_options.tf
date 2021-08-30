variable "azure_location" {
    type = map(string)
    default = {
    "East US":"eastus"
"East US 2":"eastus2"
"South Central US":"southcentralus"
"West US 2":"westus2"
"Australia East":"australiaeast"
"Southeast Asia":"southeastasia"
"North Europe":"northeurope"
"UK South":"uksouth"
"West Europe":"westeurope"
"Central US":"centralus"
"North Central US":"northcentralus"
"West US":"westus"
"South Africa North":"southafricanorth"
"Central India":"centralindia"
"East Asia":"eastasia"
"Japan East":"japaneast"
"Korea Central":"koreacentral"
"Canada Central":"canadacentral"
"France Central":"francecentral"
"Germany West Central":"germanywestcentral"
"Norway East":"norwayeast"
"Switzerland North":"switzerlandnorth"
"Brazil South":"brazilsouth"
"West Central US":"westcentralus"
"West US 3":"westus3"
"South Africa West":"southafricawest"
"Australia Central":"australiacentral"
"Australia Central 2":"australiacentral2"
"Australia Southeast":"australiasoutheast"
"Japan West":"japanwest"
"Korea South":"koreasouth"
"South India":"southindia"
"West India":"westindia"
"Canada East":"canadaeast"
"France South":"francesouth"
"Germany North":"germanynorth"
"Norway West":"norwaywest"
"Switzerland West":"switzerlandwest"
"UK West":"ukwest"
"Brazil Southeast":"brazilsoutheast"
    }
}
variable "azure_resource_group_name" {
    type = string
    description = "Name of the Azure Resource Group to Deploy Resources"
    default = "vpn-rg"
}
variable "azure_vnet_name" {
    type = string
    description = "Name of the Azure VNET to deploy the VPN Gateway to"
    default = "VPN-VNET"
}
variable "azure_vm_subnet_name" {
    type = string
    description = "Name of the subnet to deploy the VM to"
    default = "servers"
}
variable "azure_vnet_address_space" {
    type = list(string)
    description = "Azure VNET CIDR"
    default = ["172.29.0.0/16"]
}

variable "azure_vpn_gateway_name" {
    type = string
    description = "Azure VPN Gateway Name"
    default = "vnet-gateway"
}
variable "azure_vpn_gateway_sku" {
    type = map
    description = "Azure VPN Gateway SKU"
    default = {
        "VpnGw1":"VpnGw1"
        "VpnGw2":"VpnGw2"
        "VpnGw3":"VpnGw3"
        "VpnGw4":"VpnGw4"
        "VpnGw5":"VpnGw5"
        "VpnGw1AZ":"VpnGw1AZ"
        "VpnGw2AZ":"VpnGw2AZ"
        "VpnGw3AZ":"VpnGw3AZ"
        "VpnGw4AZ":"VpnGw4AZ"
        "VpnGw5AZ":"VpnGw5AZ"
    }
}
variable "azure_expressroute_circuit" {
    type = string
    description = "Name of the ExR circuit connected to Azure"
    default = "to-megaport"
}
variable "expressroute_serviceprovider_name" {
    type = map
    description = "ExpressRoute Provider"    
    default = {
        "AARNet":"AARNet"
"Airtel":"Airtel"
"AIS":"AIS"
"AryakaNetworks":"AryakaNetworks"
"Ascenty":"Ascenty"
"AT&T":"AT&T"
"AT&TNetbond":"AT&TNetbond"
"AtTokyo":"AtTokyo"
"BBIX":"BBIX"
"BCX":"BCX"
"BellCanada":"BellCanada"
"BICS":"BICS"
"BritishTelecom":"BritishTelecom"
"BSNL":"BSNL"
"C3ntro":"C3ntro"
"CDC":"CDC"
"CenturyLinkCloudConnect":"CenturyLinkCloudConnect"
"ChiefTelecom":"ChiefTelecom"
"ChinaMobileInternational":"ChinaMobileInternational"
"ChinaTelecomGlobal":"ChinaTelecomGlobal"
"ChinaUnicomGlobal":"ChinaUnicomGlobal"
"ChunghwaTelecom":"ChunghwaTelecom"
"Claro":"Claro"
"Cologix":"Cologix"
"ColtEthernet":"ColtEthernet"
"ColtIPVPN":"ColtIPVPN"
"Comcast":"Comcast"
"Coresite":"Coresite"
"DE-CIX":"DE-CIX"
"DeutscheTelekomAG":"DeutscheTelekomAG"
"DeutscheTelekomAGIntraSelect":"DeutscheTelekomAGIntraSelect"
"Devoli":"Devoli"
"DISASCCA":"DISASCCA"
"dudatamena":"dudatamena"
"eir":"eir"
"EpsilonGlobalCommunications":"EpsilonGlobalCommunications"
"Equinix":"Equinix"
"EtisalatUAE":"EtisalatUAE"
"euNetworks":"euNetworks"
"FarEasTone":"FarEasTone"
"FastWeb":"FastWeb"
"Fibrenoire":"Fibrenoire"
"GBI":"GBI"
"GEANT":"GEANT"
"GlobalcloudXchange":"GlobalcloudXchange"
"GlobalConnect":"GlobalConnect"
"GTT":"GTT"
"iAdvantage":"iAdvantage"
"IIJ":"IIJ"
"Intelsat":"Intelsat"
"InterCloud":"InterCloud"
"InterCloudforAzure":"InterCloudforAzure"
"InternetSolutions":"InternetSolutions"
"InternetSolutions-CloudConnect":"InternetSolutions-CloudConnect"
"Internet2":"Internet2"
"Interxion":"Interxion"
"IRIDEOS":"IRIDEOS"
"IronMountain":"IronMountain"
"IXReach":"IXReach"
"JaguarNetwork":"JaguarNetwork"
"Jio":"Jio"
"Jisc":"Jisc"
"KINX":"KINX"
"Kordia":"Kordia"
"KPN":"KPN"
"KT":"KT"
"Level3Communications-Exchange":"Level3Communications-Exchange"
"Level3Communications-IPVPN":"Level3Communications-IPVPN"
"LGCNS":"LGCNS"
"LGUPLUS":"LGUPLUS"
"LiquidTelecom":"LiquidTelecom"
"Megaport":"Megaport"
"MTN":"MTN"
"MTNGlobalConnect":"MTNGlobalConnect"
"NationalTelecom":"NationalTelecom"
"NeutronaNetworks":"NeutronaNetworks"
"NextGenerationData":"NextGenerationData"
"NEXTDC":"NEXTDC"
"NOS":"NOS"
"NTTCommunications":"NTTCommunications"
"NTTCommunications-FlexibleInterConnect":"NTTCommunications-FlexibleInterConnect"
"NTTEAST":"NTTEAST"
"NTTGlobalDataCentersEMEA":"NTTGlobalDataCentersEMEA"
"NTTSmartConnect":"NTTSmartConnect"
"OoredooCloudconnect":"OoredooCloudconnect"
"Optus":"Optus"
"OracleCloudFastConnect":"OracleCloudFastConnect"
"Orange":"Orange"
"Orixcom":"Orixcom"
"PacificNorthwestGigapop":"PacificNorthwestGigapop"
"Packet":"Packet"
"PacketFabric":"PacketFabric"
"PCCWGlobalLimited":"PCCWGlobalLimited"
"REANNZ":"REANNZ"
"RedCLARA":"RedCLARA"
"RelianceJio":"RelianceJio"
"Retelit":"Retelit"
"SejongTelecom":"SejongTelecom"
"SES":"SES"
"SIFY":"SIFY"
"SingTelDomestic":"SingTelDomestic"
"SingTelInternational":"SingTelInternational"
"SKTelecom":"SKTelecom"
"SkyTapProd":"SkyTapProd"
"SKTelecom":"SKTelecom"
"SkyTapProd":"SkyTapProd"
"SkytapInDCProd":"SkytapInDCProd"
"SoftBank":"SoftBank"
"Sohonet":"Sohonet"
"SparkNZ":"SparkNZ"
"Sprint":"Sprint"
"Swisscom":"Swisscom"
"TataCommunications":"TataCommunications"
"Telefonica":"Telefonica"
"Telehouse-KDDI":"Telehouse-KDDI"
"Telenor":"Telenor"
"TelenorSecureCloudConnect":"TelenorSecureCloudConnect"
"TeliaCarrier":"TeliaCarrier"
"Telin":"Telin"
"Telmex":"Telmex"
"TelstraCorporation":"TelstraCorporation"
"Telus":"Telus"
"Teraco":"Teraco"
"TimedotCom":"TimedotCom"
"TOKAICommunications":"TOKAICommunications"
"TPGTelecom":"TPGTelecom"
"Transtelco":"Transtelco"
"UIH":"UIH"
"UOLDIVEO":"UOLDIVEO"
"Verizon":"Verizon"
"Viasat":"Viasat"
"VocusGroupNZ":"VocusGroupNZ"
"Vodacom":"Vodacom"
"Vodafone":"Vodafone"
"VodafoneIdeaLimited":"VodafoneIdeaLimited"
"XLAxiata":"XLAxiata"
"Zayo":"Zayo"
"ZayoGroup":"ZayoGroup"
    }
}
variable "expressroute_peering_location" {
    type = map
    description = "ExpressRoute Locations"
    default = {
        "Amsterdam":"Amsterdam"
"Amsterdam2":"Amsterdam2"
"AsiaSouthEastSIN22Skytap":"AsiaSouthEastSIN22 Skytap"
"Atlanta":"Atlanta"
"Auckland":"Auckland"
"Bangkok":"Bangkok"
"Berlin":"Berlin"
"Bogota":"Bogota"
"Busan":"Busan"
"Campinas":"Campinas"
"Canberra":"Canberra"
"Canberra2":"Canberra2"
"CapeTown":"CapeTown"
"Chennai":"Chennai"
"Chennai2":"Chennai2"
"Chicago":"Chicago"
"Copenhagen":"Copenhagen"
"Dallas":"Dallas"
"Denver":"Denver"
"Dubai":"Dubai"
"Dubai2":"Dubai2"
"Dublin":"Dublin"
"Dublin2":"Dublin2"
"EastAsiaHKG20Skytap":"EastAsiaHKG20 Skytap"
"Frankfurt":"Frankfurt"
"Frankfurt2":"Frankfurt2"
"Geneva":"Geneva"
"HongKong":"Hong Kong"
"HongKong2":"Hong Kong2"
"Jakarta":"Jakarta"
"Jamnagar":"Jamnagar"
"Johannesburg":"Johannesburg"
"KualaLumpur":"KualaLumpur"
"LasVegas":"Las Vegas"
"London":"London"
"London2":"London2"
"LosAngeles":"Los Angeles"
"LosAngeles2":"Los Angeles2"
"Madrid":"Madrid"
"Marseille":"Marseille"
"Melbourne":"Melbourne"
"Miami":"Miami"
"Milan":"Milan"
"Minneapolis":"Minneapolis"
"Montreal":"Montreal"
"Mumbai":"Mumbai"
"Mumbai2":"Mumbai2"
"Mumbai3":"Mumbai3"
"Munich":"Munich"
"Nagpur":"Nagpur"
"NewYork":"NewYork"
"Newport":"Newport"
"Osaka":"Osaka"
"Oslo":"Oslo"
"Paris":"Paris"
"Perth":"Perth"
"Phoenix":"Phoenix"
"QuebecCity":"Quebec City"
"Queretaro":"Queretaro"
"RiodeJaneiro":"Rio de Janeiro"
"SanAntonio":"San Antonio"
"SaoPaulo":"Sao Paulo"
"Seattle":"Seattle"
"Seoul":"Seoul"
"SiliconValley":"Silicon Valley"
"SiliconValley2":"Silicon Valley2"
"Singapore":"Singapore"
"Singapore2":"Singapore2"
"SouthCentralUSSAT09Skytap":"SouthCentralUSSAT09 Skytap"
"Stavanger":"Stavanger"
"Stockholm":"Stockholm"
"Sydney":"Sydney"
"Sydney2":"Sydney2"
"Taipei":"Taipei"
"Tokyo":"Tokyo"
"Tokyo2":"Tokyo2"
"Toronto":"Toronto"
"UkSouthLON23Skytap":"UkSouthLON23 Skytap"
"UkSouthLON24Skytap":"UkSouthLON24 Skytap"
"Vancouver":"Vancouver"
"WashingtonDC":"Washington DC"
"WashingtonDC2":"Washington DC2"
"WestEuropeAMS23Skytap":"WestEuropeAMS23 Skytap"
"Zurich":"Zurich"
    }
}
variable "expressroute_bandwidth" {
 type = map
 description = "Bandwidth for the ExpressRoute Circuit"
 default = {
     "100":100
"1000":1000
"10000":10000
"200":200
"2000":2000
"50":50
"500":500
"5000":5000
 }
}
variable "expressroute_tier" {
    type = map
    description = "Circuit SKU"
    default = {
        "basic":"Basic"
        "local":"Local"
        "standard":"Standard"
        "premium":"Premium"
    }
}
variable "expressroute_family" {
    type = map
    description = "Metered or Unlimited"
    default = {
        "metered":"MeteredData"
        "unlimited":"UnlimitedData"
    }
}
variable "expressroute_vlan" {
    type = number
    description = "ExpressRoute Private Peering VLAN"
    default = 150
}
variable "expressroute_gateway" {
    type = string
    description = "ERGW name"
    default = "ergw"
}
variable "expressroute_gateway_sku" {
    type = map
    description = "Azure VPN Gateway SKU"
    default = {
        "Standard":"Standard"
        "HighPerformance":"HighPerformance"
        "UltraPerformance":"UltraPerformance"
        "ErGw1AZ":"ErGw1AZ"
        "ErGw2AZ":"ErGw2AZ"
        "ErGw3AZ":"ErGw3AZ"
    }
}
variable "azure_exr_connection" {
    type = string
    description = "Name of the connection between the ExpressRoute circuit and ExpressRoute gateway"
    default = "exr-connection"
}
variable "express_route_circuit_auth_key" {
    type = string
    description = "ExpressRoute Authorization Key"
    default = "exr-auth-key-megaport"
}
variable "azure_vng_vip_0" {
    type =  string
    description = "Public IP address for Azure VPN Gateway"
    default = "vnet-gateway-vip-0"
}
variable "azure_vng_vip_1" {
    type =  string
    description = "Public IP address for Azure VPN Gateway"
    default = "vnet-gateway-vip-1"
}
variable "azure_erg_vip" {
    type =  string
    description = "Public IP address for Azure VPN Gateway"
    default = "expressroute-gateway-vip"
}
variable "exr_auth_key" {
    type = string
    description = "Authorization Key to connect ExR circuit"
    default = "mcr-auth-key"
}
variable "exr_connection" {
    type = string
    description = "ExpressRoute connection with ERGW"
    default = "to-megaport"
}
variable "exr_bgp_key" {
    type = string
    description = "BGP TCP MD5 HASH for private peering"
    default = "BgpMd5"
}
variable "azure_vpngw_asn" {
    type = number
    description = "Azure Virtual Network Gateway BGP ASN. Must be 65515 for ExpressRoute coexistence"
    default = 65515
}
variable "azure_lng_connection_1" {
    type = string
    description = "Azure Local Network Gateway Name to Connect to AWS Connection 1 Tunnel 1"
    default = "aws-connection_1"
}
variable "azure_lng_connection_1_b" {
    type = string
    description = "Azure Local Network Gateway Name to Connect to AWS Connection 1 Tunnel 2"
    default = "aws-connection_1_b"
}
variable "azure_lng_connection_2" {
    type = string
    description = "Azure Local Network Gateway Name to Connect to AWS connection 2 Tunnel 1"
    default = "aws-connection_2"
}
variable "azure_lng_connection_2_b" {
    type = string
    description = "Azure Local Network Gateway Name to Connect to AWS Connection 2 Tunnel 2"
    default = "aws-connection_2_b"
}
variable "azure_aws_vpn_connection_name_1" {
    type = string
    description = "Name of the connection to AWS connection 1 Tunnel 1"
    default = "to-aws-connection-1"
}
variable "azure_aws_vpn_connection_name_1_b" {
    type = string
    description = "Name of the connection to AWS connection 1 Tunnel 2"
    default = "to-aws-connection-1_b"
}
variable "azure_aws_vpn_connection_name_2" {
    type = string
    description = "Name of the connection to AWS connection 2 Tunnel 1"
    default = "to-aws-connection-2"
}
variable "azure_aws_vpn_connection_name_2_b" {
    type = string
    description = "Name of the connection to AWS connection 2 Tunnel 2"
    default = "to-aws-connection-2_b"
}
variable "azure_aws_vpn_shared_key" {
    type = string
    description = "Shared key used between Azure and AWS"
    default = "P455w0rd.1"
}
variable "azure_vm_vip" {
    type = string
    description = "Public IP associated with the Azure VM"
    default = "vm-vip"
}
variable "azure_vm_nic_name" {
    type = string
    description = "Azure VM NIC Name"
    default = "vm-nic"
}
variable "azure_vm_name" {
    type = string
    description = "Azure VM Name"
    default = "vpn-vm"
}
variable "azure_vm_sku" {
    type = string
    description = "Azure VM Sku"
    default = "Standard_D1_v2"
}
variable "azure_vm_admin_username" {
    type = string
    description = "Admin user to log into the Azure VM"
    default = "AzureAdmin"
}
variable "ssh_pubkey" {
    type = string
    description = "File with the SSH Public key"
    default = "ssh-key.pub"
}