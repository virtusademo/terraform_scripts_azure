
provider "azurerm" {
  subscription_id = "*************"
  client_id       = "***********"
  client_secret   = "*********"
  tenant_id       = "***************"
}

resource "azure_instance" "goserver" {
  name                 = "DEMOGoServer"
  hosted_service_name  = "${azure_hosted_service.terraform-service.name}"
  image                = "Ubuntu Server 14.04 LTS"
  size                 = "Basic_A1"
  storage_service_name = "CloudPracticeTeam"
  location             = "Southeast Asia"
  user_data_file = "userdata_goserver.sh"
 }
 
 resource "azure_instance" "goagent" {
  name                 = "DEMOGoAgentKubernetes"
  hosted_service_name  = "${azure_hosted_service.terraform-service.name}"
  image                = "Ubuntu Server 14.04 LTS"
  size                 = "Basic_A1"
  storage_service_name = "CloudPracticeTeam"
  location             = "Southeast Asia
  user_data_file = "userdata_gokube.sh"
 }
 
 
 
 
