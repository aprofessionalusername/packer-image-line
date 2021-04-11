
variable "local-pw" {
  type    = string
  default = "password"
  sensitive = true
}

variable "local-user" {
  type    = string
  default = "root"
}

variable "template-bios" {
  type    = string
}

variable "template-cpu" {
  type    = string
  default = "2"
}

variable "template-guestos-type" {
  type    = string
}

variable "template-iso" {
  type    = string
}

variable "template-iso-volume" {
  type    = string
}

variable "template-iso-sha" {
  type    = string
}

variable "template-ram" {
  type    = string
  default = "2048"
}

variable "template-storage" {
  type    = string
  default = "10240"
}

variable "template-thin-prov" {
  type    = string
  default = "true"
}

variable "template-vm-name" {
  type    = string
}

variable "vsphere-cluster" {
  type    = string
  default = "nodes"
}

variable "vsphere-datacenter" {
  type    = string
  default = "Datacenter"
}

variable "vsphere-datastore" {
  type    = string
  default = "fpool"
}

variable "vsphere-folder" {
  type    = string
  default = "packer"
}

variable "vsphere-host" {
  type    = string
}

variable "vsphere-network" {
  type    = string
  default = "VM Network"
}

variable "vsphere-password" {
  type      = string
  sensitive = true
}

variable "vsphere-server" {
  type    = string
}

variable "vsphere-user" {
  type    = string
}

variable "boot-command" {
  type    = list(string)
}

source "vsphere-iso" "core" {
  CPUs                 = "${var.template-cpu}"
  RAM                  = "${var.template-ram}"
  RAM_reserve_all      = false
  boot_command         = "${var.boot-command}"
  boot_order           = "disk,cdrom"
  cluster              = "${var.vsphere-cluster}"
  convert_to_template  = "true"
  datacenter           = "${var.vsphere-datacenter}"
  datastore            = "${var.vsphere-datastore}"
  disk_controller_type = ["pvscsi"]
  firmware             = "${var.template-bios}"
  folder               = "${var.vsphere-folder}"
  guest_os_type        = "${var.template-guestos-type}"
  host                 = "${var.vsphere-host}"
  http_directory       = "./http"
  http_port_max        = "8080"
  http_port_min        = "8080"
  insecure_connection  = "false"
  iso_checksum         = "${var.template-iso-sha}"
  iso_paths            = ["${var.template-iso-volume} ${var.template-iso}"]
  network_adapters {
    network      = "${var.vsphere-network}"
    network_card = "vmxnet3"
  }
  password     = "${var.vsphere-password}"
  ssh_password = "${var.local-pw}"
  ssh_username = "${var.local-user}"
  storage {
    disk_size             = "${var.template-storage}"
    disk_thin_provisioned = "${var.template-thin-prov}"
  }
  username       = "${var.vsphere-user}"
  vcenter_server = "${var.vsphere-server}"
  vm_name        = "${var.template-vm-name}"
}

build {
  sources = ["source.vsphere-iso.core"]

  provisioner "shell" {
    scripts       = ["scripts/main-script.sh"]
    pause_before  = "0s"
  }

}
