# Activate TFTP server
/ip tftp set enabled=yes

# Enable BOOTP
/ip dhcp-server set 0 bootp-support=dynamic

# === UEFI x86_64 ===
/tool fetch mode=https http-method=get url="https://boot.netboot.xyz/ipxe/netboot.xyz.efi"
/ip tftp add real-filename=netboot.xyz.efi req-filename=netboot.xyz.efi allow=yes read-only=yes
/ip dhcp-server option add code=67 name=pxe-uefi-netboot value=0x6e6574626f6f742e78797a2e2e65666900
# /ip dhcp-server option add name=pxe-uefi-netboot code=67 value="'netboot.xyz.efi'"
/ip dhcp-server option sets add name=pxe-uefi options=pxe-uefi-netboot
/ip dhcp-server matcher add name=pxe-uefi-matcher server=dhcp1 address-pool=dhcp_pool option-set=pxe-uefi code=93 value="0x0007"

# === UEFI ARM64 ===
/tool fetch mode=https http-method=get url="https://boot.netboot.xyz/ipxe/netboot.xyz-arm64.efi"
/ip tftp add real-filename=netboot.xyz-arm64.efi req-filename=netboot.xyz-arm64.efi allow=yes read-only=yes
/ip dhcp-server option add code=67 name=pxe-uefi-arm64-netboot value=0x6e6574626f6f742e78797a2d61726436342e65666900
# /ip dhcp-server option add name=pxe-uefi-arm64-netboot code=67 value="'netboot.xyz-arm64.efi'"
/ip dhcp-server option sets add name=pxe-uefi-arm64 options=pxe-uefi-arm64-netboot
/ip dhcp-server matcher add name=pxe-uefi-arm64-matcher server=dhcp1 address-pool=dhcp_pool option-set=pxe-uefi-arm64 code=93 value="0x000B"

# === BIOS (Legacy PXE) ===
/tool fetch mode=https http-method=get url="https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe"
/ip tftp add real-filename=netboot.xyz.kpxe req-filename=netboot.xyz.kpxe allow=yes read-only=yes
/ip dhcp-server option add code=67 name=pxe-bios-netboot value=0x6e6574626f6f742e78797a2e6b70786500
# /ip dhcp-server option add name=pxe-bios-netboot code=67 value="'netboot.xyz.kpxe'"
/ip dhcp-server option sets add name=pxe-bios options=pxe-bios-netboot
/ip dhcp-server network set 0 boot-file-name=netboot.xyz.kpxe

# Enable PXE boot
/ip dhcp-server set 0 dhcp-option-set=pxe-bios
