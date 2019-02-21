provider "aws" {
  # Change your default region here
  region = "us-east-1"
}

# Used to determine your public IP for forwarding rules
data "http" "whatismyip" {
  url = "http://whatismyip.akamai.com/"
}

module "dcos" {
  source  = "../../modules/aws/dcos"
  version = "~> 0.1"

  cluster_name        = "dcos-terraform-test"
  ssh_public_key_file = "./ssh-key.pub"
  admin_ips           = ["${data.http.whatismyip.body}/32"]

  num_masters        = "3"
  num_private_agents = "1"
  num_public_agents  = "0"

  masters_private_ip_list = ["172.12.0.4","172.12.0.5","172.12.0.6"]

  dcos_version = "1.10.9"
  custom_dcos_download_path = "<INSERT_DCOS_1.10.9_DOWNLOAD.SH>"

  #dcos_instance_os    = "rhel_7.6"
  dcos_instance_os    = "coreos_1632.3.0"

  providers = {
    aws = "aws"
  }

  # dcos_variant              = "ee"
  # dcos_license_key_contents = "${file("./license.txt")}"
  dcos_variant = "open"

  dcos_install_mode = "${var.dcos_install_mode}"
}

variable "dcos_install_mode" {
  description = "specifies which type of command to execute. Options: install or upgrade"
  default     = "install"
}

output "masters-ips" {
  value = "${module.dcos.masters-ips}"
}

output "cluster-address" {
  value = "${module.dcos.masters-loadbalancer}"
}

output "public-agents-loadbalancer" {
  value = "${module.dcos.public-agents-loadbalancer}"
}

output "masters-private-ips" {
  value = "${module.dcos.masters-private-ips}"
}
