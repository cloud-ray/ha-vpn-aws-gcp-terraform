## Orchestrating Inter-Module Communication with Terraform Module Outputs and Inputs

This repository utilizes a modular approach to Terraform configuration, enhancing organization and maintainability. To facilitate seamless interaction between these modules, we leverage Terraform's mechanism of module outputs and inputs. 

### Key Concepts

- **Module Outputs**: These act as gateways for modules to share specific values with other parts of your Terraform configuration. They can encompass resource IDs, attributes, calculated data, or configuration details. Outputs are defined within the `outputs.tf` file.
- **Module Inputs**: These serve as placeholders within a module, ready to receive data from outputs of other modules. This enables customization and integration. Inputs are defined in the `variables.tf` file.

### Orchestrating Inter-Module Communication

This strategy is crucial in the context of our automated HA VPN creation between GCP and AWS.

#### Creating a Value

When constructing an HA VPN, two IP interfaces (0 and 1) are automatically generated. While typically retrieved manually from the GCP console, our automated approach necessitates dynamic access to these values.

```hcl
# root/gcp-modules/gcp-vpn/main.tf

resource "google_compute_ha_vpn_gateway" "gcp_vpn_ha_gateway" {}
```
#### Outputting a Value

The gcp-vpn module exposes the IP address of HA VPN Interface 0 through the interface_0_ip output, defined in root/gcp-modules/gcp-vpn/outputs.tf:

```hcl
# root/gcp-modules/gcp-vpn/outputs.tf

output "interface_0_ip" {
    value       = google_compute_ha_vpn_gateway.gcp_vpn_ha_gateway.vpn_interfaces.0.ip_address
    description = "IP address from GCP HA VPN Interface 0"
}
```

#### Passing the Output as Input

In the root module’s main.tf, we invoke the aws_vpn module and relay the interface_0_ip output from the gcp-vpn module as an input variable:

```hcl
# root/main.tf

module "aws_vpn" {
    source                            = "./aws-modules/aws-vpn"
    gcp_ha_vpn_int_0                  = module.gcp_vpn.interface_0_ip
}
```

#### Receiving the Input

The aws_vpn module anticipates this input through a corresponding variable in its variables.tf:

```hcl
# root/aws-modules/aws-vpn/main.tf 

resource "aws_customer_gateway" "customer_gateway_0" {
    ip_address = var.gcp_ha_vpn_int_0  # IP address from GCP HA VPN Interface 0
}
```

It then seamlessly utilizes this input value to configure the ip_address attribute of the aws_customer_gateway resource in its main.tf:

```hcl
# root/aws-modules/aws-vpn/main.tf 

resource "aws_customer_gateway" "customer_gateway_0" {
    ip_address = var.gcp_ha_vpn_int_0  # IP address from GCP HA VPN Interface 0
}
```