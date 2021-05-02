source "vmware-iso" "consul-server" {
  guest_os_type = "debian10_64Guest"
  disk_size = 4096
  cpus = 1
  memory = 1024
  vm_name = "ConsulServer"
  http_directory = "http"
  iso_url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.9.0-amd64-netinst.iso"
  iso_checksum = "sha256:8660593d10de0ce7577c9de4dab886ff540bc9843659c8879d8eea0ab224c109"
  ssh_username = "debian"
  ssh_password = "default"
  shutdown_command = "sudo shutdown -h now"
  vmx_data = {
    "mks.noBeep" = "TRUE"
  }
  boot_command = [
    "<esc><wait>",
    "install <wait>",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
    "debian-installer=en_US.UTF-8 <wait>",
    "auto <wait>",
    "locale=en_US.UTF-8 <wait>",
    "kbd-chooser/method=us <wait>",
    "keyboard-configuration/xkb-keymap=us <wait>",
    "netcfg/get_hostname={{ .Name }} <wait>",
    "netcfg/get_domain=redtalks.lab <wait>",
    "fb=false <wait>",
    "debconf/frontend=noninteractive <wait>",
    "console-setup/ask_detect=false <wait>",
    "console-keymaps-at/keymap=us <wait>",
    "grub-installer/bootdev=/dev/sda <wait>",
    "<enter><wait>"
  ]
}

build {
  sources = ["sources.vmware-iso.consul-server"]
}