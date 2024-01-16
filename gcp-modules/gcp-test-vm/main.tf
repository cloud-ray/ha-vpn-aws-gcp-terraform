# root/gcp-modules/gcp-test-vm/main.tf

# 4. GCP - Create VM in GCP in private subnet
resource "google_compute_instance" "gcp_test_vm" {
  name         = var.gcp_test_vm_name
  machine_type = var.gcp_test_vm_machine_type
  zone         = var.gcp_test_vm_zone

  boot_disk {
    initialize_params {
      image = var.gcp_test_vm_image
      labels = {
        my_label = var.gcp_test_vm_my_label
      }
    }
  }

  network_interface { 
    network    = var.network_id
    subnetwork = var.private_subnetwork_id
  } 

  # service_account {
  #   email  = var.gcp_test_vm_sa_email
  #   scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  # }
  tags = [var.gcp_test_vm_tags] # Apply the tag for firewall targeting
}