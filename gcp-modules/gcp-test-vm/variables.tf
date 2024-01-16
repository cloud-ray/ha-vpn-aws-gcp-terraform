# root/gcp-modules/gcp-test-vm/variables.tf

# For use with root/main.tf module values
variable "network_id" {}
variable "private_subnetwork_id" {}

# 4. Create VM in GCP in private subnet
variable "gcp_test_vm_name" {}
variable "gcp_test_vm_machine_type" {}
variable "gcp_test_vm_zone" {}
variable "gcp_test_vm_image" {}
variable "gcp_test_vm_my_label" {}
# variable "gcp_test_vm_sa_email" {}
variable "gcp_test_vm_tags" {}