
provider "azurerm" {
  subscription_id = "*************"
  client_id       = "***********"
  client_secret   = "*********"
  tenant_id       = "***************"
}

resource "azure_instance" "goserver" {
  name                 = "DEMO_Go_Server"
    hosted_service_name  = "${azure_hosted_service.terraform-service.name}"
  image                = "Ubuntu Server 14.04 LTS"
  size                 = "Basic_A1"
  storage_service_name = "yourstorage"
  location             = "West US"
  user_data_file = "userdata_goserver.sh"
 }
 
 resource "azure_instance" "goagent" {
  name                 = "DEMO_Go_Agent_Kubernetes"
  hosted_service_name  = "${azure_hosted_service.terraform-service.name}"
  image                = "Ubuntu Server 14.04 LTS"
  size                 = "Basic_A1"
  storage_service_name = "yourstorage"
  location             = "West US"
  user_data_file = "userdata_gokube.sh"
 }
 
 
 
 
