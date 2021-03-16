local-user             = "root"
local-pw               = "password"
template-cpu           =  2
template-ram           =  2048
template-storage       =  10240
template-thin-prov     =  true
template-vm-name       = "suse-15-2-cloudinit"
template-guestos-type  = "sles15_64Guest"
template-bios          = "efi"
template-iso           = "openSUSE-Leap-15.2-DVD-x86_64.iso"
template-iso-volume    = "[silvervol]"
template-iso-sha       = "sha1:0fd2d4e630b6579b933b5cb4930a8100acca6b4e29cd2738c4b7a9b2f76d80e4"
vsphere-network        = "VM Network"
boot-command           = ["<esc><wait><wait><wait>", "e<down><down><end><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "<down><down><end><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs> autoyast=http://{{ .HTTPIP }}:8080/suse-15-autoyast.xml<leftCtrlOn>x<leftCtrlOff>"]