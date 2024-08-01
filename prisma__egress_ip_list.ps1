#------------------------------[Collecting the Prisma Egress IP Address]-------------------------------#
<#
:DESCRIPTION:
	To get the output of "XML API > Operational Commands > request plugins > cloud_services > prisma-access > egress_ip" from Prisma API >>> parse the json output >>> write the output in CSV file
:REQUIREMENTS:
	Powershell
  CSV
    
:INPUTS:
	Regular json file ending with ".json"
	

{"location_name": "United States West", "allow_listed_ip_count": 2, "allow_listed_ipv6_count": 0, "allocated_ip_count": 2, "allocated_ipv6_count": 0, "ip_list": [{"addr": "1.1.1.1", "allow_listed": true, "candidate_allow_listed": true}, {"addr": "1.1.1.2", "allow_listed": true, "candidate_allow_listed": true}], "ingress_ip_list": [], "ipv6_subnet_list": [], "active_ip_list": ["1.1.1.1"], "active_ipv6_list": [], "allow_provisioning": true, "provisioning_status": "Provisioned", "ipv6_provisioning_status": "provisioned", "autoscale_status": "Allowed", "timestamp": "2020-10-11 14:18:22 +0000", "epoch_timestamp": 1789574102, "instance_count": 1, "display_location_name": "United States South", "candidate_allow_listed_ip_count": 2, "candidate_allow_provisioning": true, "candidate_autoscale_status": "allowed", "candidate_confirmed_over_allocated": "2/2 Egress IPs Confirmed Allowlisted", "candidate_provisioning_status": "Enabled and provisioned", "candidate_ip_list": []}
{"location_name": "Australia East", "allow_listed_ip_count": 2, "allow_listed_ipv6_count": 0, "allocated_ip_count": 2, "allocated_ipv6_count": 0, "ip_list": [{"addr": "2.2.2.1", "allow_listed": true, "candidate_allow_listed": true}, {"addr": "2.2.2.2", "allow_listed": true, "candidate_allow_listed": true}], "ingress_ip_list": [], "ipv6_subnet_list": [], "active_ip_list": ["2.2.2.2"], "active_ipv6_list": [], "allow_provisioning": true, "provisioning_status": "Provisioned", "ipv6_provisioning_status": "provisioned", "autoscale_status": "Allowed", "timestamp": "2020-10-11 14:18:22 +0000", "epoch_timestamp": 1789574102, "instance_count": 1, "display_location_name": "Australia East", "candidate_allow_listed_ip_count": 2, "candidate_allow_provisioning": true, "candidate_autoscale_status": "allowed", "candidate_confirmed_over_allocated": "2/2 Egress IPs Confirmed Allowlisted", "candidate_provisioning_status": "Enabled and provisioned", "candidate_ip_list": []}
{"location_name": "Japan North", "allow_listed_ip_count": 2, "allow_listed_ipv6_count": 0, "allocated_ip_count": 2, "allocated_ipv6_count": 0, "ip_list": [{"addr": "3.3.3.1", "allow_listed": true, "candidate_allow_listed": true}, {"addr": "3.3.3.2", "allow_listed": true, "candidate_allow_listed": true}], "ingress_ip_list": [], "ipv6_subnet_list": [], "active_ip_list": ["3.3.3.1"], "active_ipv6_list": [], "allow_provisioning": true, "provisioning_status": "Provisioned", "ipv6_provisioning_status": "provisioned", "autoscale_status": "Allowed", "timestamp": "2020-10-11 14:18:22 +0000", "epoch_timestamp": 1789574102, "instance_count": 1, "display_location_name": "Japan North", "candidate_allow_listed_ip_count": 2, "candidate_allow_provisioning": true, "candidate_autoscale_status": "allowed", "candidate_confirmed_over_allocated": "2/2 Egress IPs Confirmed Allowlisted", "candidate_provisioning_status": "Enabled and provisioned", "candidate_ip_list": []}
{"location_name": "India South", "allow_listed_ip_count": 6, "allow_listed_ipv6_count": 0, "allocated_ip_count": 6, "allocated_ipv6_count": 0, "ip_list": [{"addr": "4.4.4.1", "allow_listed": true, "candidate_allow_listed": true}, {"addr": "4.4.4.2", "allow_listed": true, "candidate_allow_listed": true}, {"addr": "4.4.4.3", "allow_listed": true, "candidate_allow_listed": true}, {"addr": "4.4.4.4", "allow_listed": true, "candidate_allow_listed": true}, {"addr": "4.4.4.4", "allow_listed": true, "candidate_allow_listed": true}, {"addr": "4.4.4.5", "allow_listed": true, "candidate_allow_listed": true}, {"addr": "4.4.4.6", "allow_listed": true, "candidate_allow_listed": true}], "ingress_ip_list": [], "ipv6_subnet_list": [], "active_ip_list": ["4.4.4.4"], "active_ipv6_list": [], "allow_provisioning": true, "provisioning_status": "Provisioned", "ipv6_provisioning_status": "provisioned", "autoscale_status": "Allowed", "timestamp": "2020-10-11 14:18:22 +0000", "epoch_timestamp": 1789574102, "instance_count": 1, "display_location_name": "India South", "candidate_allow_listed_ip_count": 2, "candidate_allow_provisioning": true, "candidate_autoscale_status": "allowed", "candidate_confirmed_over_allocated": "2/2 Egress IPs Confirmed Allowlisted", "candidate_provisioning_status": "Enabled and provisioned", "candidate_ip_list": []}

Parse this output with the custom template 
    
       
	
:OUTPUT:
    Following output is the sample output of csv file 
['Location',	'Allowed_ip_count',	'Allocated_ip_count',	'IP_Address	Active_ip',]
['United States West',	'2',	'2',	'1.1.1.1,1.1.1.2',	'1.1.1.1',]
['Australia East',	'2',	2',	'2.2.2.1,2.2.2.2',	'2.2.2.2',]
['Japan North',	'2',	'2',	'3.3.3.1,3.3.3.2',	'3.3.3.1',]
['India South',	'2',	'6',	'4.4.4.1,4.4.4.2,4.4.4.3,4.4.4.4,4.4.4.5,4.4.4.6',	4.4.4.4',]

:DRAWBACKS:
    - anyother let me know
	
:NOTES:
  Version:        1.0
  Author:         bala-murugan-s
  Creation Date:  JUL-2024
  Purpose/Change: Initial script development

#>
#---------------------------------------------[Code Starts]------------------------------------------------------#

#Getting the content to parse the json file

function Export-prisma_egress {
    param (
        [Parameter(Mandatory = $true)]
        [string]$JsonFilePath, #Mention the Path and filename of input json file
        [Parameter(Mandatory = $true)]
        [string]$CsvOutputPath #Mention the path to save output csv file
        )

        #Read the JSON content from the input file
        $jsoncontent = Get-Content -Path $JsonFilePath -Raw
        #Convert Json content to a Powershell Object
        $input_data =  $jsoncontent | ConvertFrom-Json
        #Create a custom object to format a table
        $input_data | ForEach-Object {
                                        [PSCustomObject]@{
                                                          #location_name = $_.location_name
                                                          Location = $_.display_location_name
                                                          Allowed_ip_count = $_.allow_listed_ip_count
                                                          Allocated_ip_count = $_.allocated_ip_count
                                                          IP_Address = $_.ip_list.addr -join ","
                                                          Active_ip = $_.active_ip_list -join ","
                                                   
                                         }
         } |  Export-Csv -Path $CsvOutputPath -NoTypeInformation

}

<# Example Usage

$JsonFilePath = "C:\path\to\input.json"
$CsvOutputPath = "C:\path\to\output.csv"

Export-prisma_egress -JsonFilePath $JsonFilePath -CsvOutputPath $CsvOutputPath
#>
 
#---------------------------------------------[Code Ends]------------------------------------------------------#    



