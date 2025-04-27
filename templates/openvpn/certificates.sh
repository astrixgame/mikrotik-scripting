#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)
filename=$(basename "$0")
filename="${filename%.*}"

clear
echo "${bold}=================| OpenVPN Certificates |=================${normal}"

echo
echo "${bold}CA Certificate${normal}"

echo "Certificate name [OVPN_CA]:"
read -p "> " cacrt_name
cacrt_name=${cacrt_name:-"OVPN_CA"}

echo "Common name [OVPN_CA]:"
read -p "> " cacrt_cname
cacrt_cname=${cacrt_cname:-"OVPN_CA"}

echo "CRL host:"
read -p "> " cacrt_host
cacrt_host=${cacrt_host:-""}

echo "Key size [4096]:"
read -p "> " cacrt_size
cacrt_size=${cacrt_size:-"4096"}

echo "Days valid [3650]:"
read -p "> " cacrt_valid
cacrt_valid=${cacrt_valid:-"3650"}

echo
echo "${bold}Server Certificate${normal}"

echo "Certificate name [OVPN_Server]:"
read -p "> " srvcrt_name
srvcrt_name=${srvcrt_name:-"OVPN_Server"}

echo "Common name [OVPN_Server]:"
read -p "> " srvcrt_cname
srvcrt_cname=${srvcrt_cname:-"OVPN_Server"}

echo "Key size [4096]:"
read -p "> " srvcrt_size
srvcrt_size=${srvcrt_size:-"4096"}

echo "Days valid [3650]:"
read -p "> " srvcrt_valid
srvcrt_valid=${srvcrt_valid:-"3650"}

echo
echo "${bold}Client Certificate${normal}"

echo "Generate client certificate?: [Y/n]:"
read -p "> " clcrt_create

if [[ $clcrt_create =~ ^[Yy]$ ]]
then
    clcrt_create=true

    echo "Certificate name [OVPN_Client]:"
    read -p "> " clcrt_name
    clcrt_name=${clcrt_name:-"OVPN_Client"}

    echo "Common name [OVPN_Client]:"
    read -p "> " clcrt_cname
    clcrt_cname=${clcrt_cname:-"OVPN_Client"}

    echo "Key size [4096]:"
    read -p "> " clcrt_size
    clcrt_size=${clcrt_size:-"4096"}

    echo "Days valid [3650]:"
    read -p "> " clcrt_valid
    clcrt_valid=${clcrt_valid:-"3650"}
else
    clcrt_create=false
fi

echo
echo Building from $filename.j2 to "$filename.rsc"

jinja2 -o "$filename.rsc" "$filename.j2" \
    -D cacrt_name=$cacrt_name \
    -D cacrt_cname=$cacrt_cname \
    -D cacrt_host=$cacrt_host \
    -D cacrt_size=$cacrt_size \
    -D cacrt_valid=$cacrt_valid \
    -D srvcrt_name=$srvcrt_name \
    -D srvcrt_cname=$srvcrt_cname \
    -D srvcrt_size=$srvcrt_size \
    -D srvcrt_valid=$srvcrt_valid \
    -D clcrt_create=$clcrt_create \
    -D clcrt_name=$clcrt_name \
    -D clcrt_cname=$clcrt_cname \
    -D clcrt_size=$clcrt_size \
    -D clcrt_valid=$clcrt_valid