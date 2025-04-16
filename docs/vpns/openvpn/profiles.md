---
description: >-
  A profile controls IP address assignment, timeouts, DNS, encryption, and other
  parameters applied to each session.
icon: gear
---

# Profiles

{% hint style="info" %}
It is recommended to create your own profile instead of using defaults.
{% endhint %}

In WinBox you can create VPN profile in **PPP -> Profiles,** click on <kbd>**+**</kbd> and create your profile or via Terminal in `/ppp profile`, for this configuration

There will several default profiles:

1. **default** - Basic profile with minimal config
2. **default-encryption** - Enables encryption

***

## Creating IP pool for clients

You need to create IP pool or range from which will be IP addresses assigned to users.

Let's say we have second network for VPN users (e.g. `10.10.10.0/24`), where 10.10.10.1 is the gateway, so we need to create IP pool in range from `10.10.10.2` to `10.10.10.254`

{% code overflow="wrap" %}
```bash
/ip pool add name="vpn-pool" ranges=10.10.10.2-10.10.10.254
```
{% endcode %}

## Creating custom profile

Click on <kbd>**+**</kbd>  to add new profile, and you will need define:

* **Name** - Your profile name, (e.g. vpn-users)
* **Local Address** - Router IP, end of tunnel (e.g. 10.10.10.1)
* **Remote Address** - IP pool or range for clients, (e.g. )
* **DNS Servers** - (Optional) Which DNSs should clients use, (e.g. `1.1.1.1`, `8.8.8.8`)

{% code overflow="wrap" %}
```bash
/ppp profile add name="vpn-users" local-address="10.10.10.1" remote-address=vpn-pool dns-servers=10.10.10.1,1.1.1.1,8.8.8.8
```
{% endcode %}

***

## All parameters

Here's list of all parameters:

<table data-full-width="true"><thead><tr><th>Parameter</th><th>Description</th></tr></thead><tbody><tr><td><mark style="color:green;"><code>address-list</code></mark> (string; Default: )</td><td>Address list name to which ppp assigned (on server) or received (on client) address will be added.</td></tr><tr><td><mark style="color:green;"><code>bridge</code></mark> (string; Default: )</td><td>Name of the bridge interface to which ppp interface will be added as a slave port. Both tunnel endpoints (server and client) must be in the bridge to make this work, see more details in the BCP bridging manual.</td></tr><tr><td>bridge-horizon (integer 0..429496729; Default: )</td><td><p></p><p>Changes MAC learning behavior on the dynamically created bridge port:</p><pre><code>yes - enables MAC learning
no - disables MAC learning
default - derive this value from the interface default profile; same as yes if this is the interface default profile
</code></pre></td></tr><tr><td>bridge-learning (default | no | yes; Default: default)</td><td><p></p><p>Changes MAC learning behavior on the dynamically created bridge port:</p><pre><code>yes - enables MAC learning
no - disables MAC learning
default - derive this value from the interface default profile; same as yes if this is the interface default profile
</code></pre></td></tr><tr><td>bridge-path-cost (integer 1..200000000; Default: )</td><td>Used path cost for the dynamically created bridge port, used by STP/RSTP to determine the best path, used by MSTP to determine the best path between regions. This property has no effect when a bridge protocol-mode is set to none.</td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr><tr><td></td><td></td></tr></tbody></table>

### Name

Unique name for the profile (e.g. vpn-users)

* **Parameter:** <mark style="color:green;">`name`</mark>&#x20;
* **Values:** <mark style="color:blue;">String</mark>

### Local Address

Tunnel address from which is the address assigned to interface (e.g. 10.10.10.1 \[gateway]), or address pool for dynamic assignment

* **Parameter:** <mark style="color:green;">`local-address`</mark>
* **Values:** <mark style="color:blue;">IP address</mark> / <mark style="color:blue;">IP pool</mark>

### Remote Address

IP address or pool from which clients get automatically assigned IP addresses (e.g. vpn-pool)

* **Parameter:** <mark style="color:green;">`remote-address`</mark>&#x20;
* **Values:** <mark style="color:blue;">IP address</mark> / <mark style="color:blue;">IP pool</mark>

### Remote IPv6 Prefix Pool

Assign prefix from IPv6 pool to client and install IPv6 route

* **Parameter:** <mark style="color:green;">`remote-ipv6-prefix-pool`</mark>&#x20;
* **Values:** <mark style="color:blue;">IPv6 pool</mark>

### DHCPv6 PD Pool

IPv6 address pool which will be used to assign IPv6 addresses to clients by dynamically created DHCPv6 server

* **Parameter:** <mark style="color:green;">`dhcpv2-pd-pool`</mark>&#x20;
* **Values:** <mark style="color:blue;">String</mark>

### Bridge

Every client gets a virtual interface (e.g. ovpn-user1) that is automatically assigned into the selected bridge

* **Parameter:** <mark style="color:green;">`bridge`</mark>
* **Values:** <mark style="color:blue;">Bridge list</mark>

{% hint style="info" %}
Bridge works only in **Layer-2** (Ethernet mode)
{% endhint %}

### Bridge Port Priority

Priority for dynamically created bridge port, used to determine the root port by STR/RSTP and MSTP between regions

{% hint style="info" %}
Bridge Port Priority works only when **bridge protocol-mode** is not **none**
{% endhint %}

* **Parameter:** <mark style="color:green;">`bridge-port-priority`</mark>
* **Values:** <mark style="color:blue;">Integer</mark>\[0-240]

### Bridge Path Cost

Priority for dynamically created bridge port, used to determine the best path by STR/RSTP and MSTP between regions

* **Parameter:** <mark style="color:green;">`bridge-port-cost`</mark>
* **Values:** <mark style="color:blue;">Integer</mark>\[1-200,000,000]

{% hint style="info" %}
Bridge Path Cost works only when **bridge protocol-mode** is not **none**
{% endhint %}

### Bridge Horizon

Can be used to prevent bridging loops and isolate traffic, set the same value for group of ports, to prevent them from sending data to ports with the same horizon

* **Parameter:** <mark style="color:green;">`bridge-horizon`</mark>
* **Values:** <mark style="color:blue;">Integer</mark>\[0-429,496,729]

### Bridge Learning

Bridge learning is used to learn MAC addresses on dynamically created bridge

* **Parameter:** <mark style="color:green;">`bridge-learning`</mark>
* **Values:**
  * <mark style="color:blue;">**default**</mark> _(default)_ - Derive from interface
  * <mark style="color:blue;">**yes**</mark> - Enables MAC learning
  * <mark style="color:blue;">**no**</mark>**&#x20;-** Disables MAC learning

### Bridge Port VID

Set PVID parameter for dynamically created interface

* **Parameter:** <mark style="color:green;">`bridge-port-vid`</mark>
* **Values:** <mark style="color:blue;">Integer</mark>\[1-4094] _(default 1)_

{% hint style="info" %}
Bridge Port VID works when bridge **vlan-filtering** is set to **yes**
{% endhint %}

### Bridge Port Trusted

Set dynamically create interface as DHCP trusted

* **Parameter:** <mark style="color:green;">`bridge-port-trusted`</mark>
* **Values:** <mark style="color:blue;">yes</mark>, <mark style="color:blue;">no</mark> _(default)_

### Incoming Filter

The specified chain gets control of each incoming packet, chains are specified in Firewall Chains

* **Parameter:** <mark style="color:green;">`incoming-filter`</mark>
* **Values:** <mark style="color:blue;">Firewall chain</mark>

### Outgoing Filter

The specified chain gets control of each outgoing packet, chains are specified in Firewall Chains

* **Parameter:** <mark style="color:green;">`outgoing-filter`</mark>
* **Values:** <mark style="color:blue;">Firewall chain</mark>

### Address List

Address list where the server automatically assign IP addresses of clients when they connect

* **Parameter:** <mark style="color:green;">`address-list`</mark>
* **Values:** <mark style="color:blue;">Address list</mark>

### Interface List

Specifies to which interface list will be profile interfaces added

* **Parameter:** <mark style="color:green;">`interface-list`</mark>
* **Values:** <mark style="color:blue;">Interface list</mark>

### DNS Server

List of DNS servers that is supplied to clients

* **Parameter:** <mark style="color:green;">`dns-server`</mark>
* **Values:** <mark style="color:blue;">Comma separated IPs</mark>

### WINS Server

List of WINS servers that is supplied to clients

* **Parameter:** <mark style="color:green;">`wins-server`</mark>
* **Values:** <mark style="color:blue;">Values: Comma separated IPs</mark>

### Change TCP MSS

Adjusts connection MSS settings, only for IPv4

* **Parameter:** <mark style="color:green;">`change-tcp-mss`</mark>
* **Values**
  * <mark style="color:blue;">**default**</mark> _(default)_ - Derive from interface
  * <mark style="color:blue;">**yes**</mark> - Adjust connection MSS value
  * <mark style="color:blue;">**no**</mark> - Do not adjust connection MSS value

### Use UPnP

Allow Universal Plug and Play

* **Parameter:** <mark style="color:green;">`use-upnp`</mark>
* **Values**
  * <mark style="color:blue;">**default**</mark> _(default)_ - Derive from interface
  * <mark style="color:blue;">**yes**</mark> - Enables MAC learning
  * <mark style="color:blue;">**no**</mark> - Disables MAC learning

### Use IPv6

Specifies whether to allow IPv6

* **Parameter:** <mark style="color:green;">`use-ipv6`</mark>
* **Values**
  * <mark style="color:blue;">**default**</mark> - Derive from interface
  * <mark style="color:blue;">**require**</mark> - Requires IPv6
  * <mark style="color:blue;">**yes**</mark> _(default)_ - Enables IPv6 support
  * <mark style="color:blue;">**no**</mark> - Disables IPv6 support

### Use MPLS

Specifies whether to allow MPLS

* **Parameter:** <mark style="color:green;">`use-mpls`</mark>
* **Values**
  * <mark style="color:blue;">**default**</mark> _(default)_ - Derive from interface
  * <mark style="color:blue;">**require**</mark> - Requires MPLS
  * <mark style="color:blue;">**yes**</mark> - Enables MPLS support
  * <mark style="color:blue;">**no**</mark> - Disables MPLS support

### Use Compression

Specifies whether to allow data compression

* **Parameter:** <mark style="color:green;">`use-compression`</mark>
* **Values**
  * <mark style="color:blue;">**default**</mark> _(default)_ - Derive from interface
  * <mark style="color:blue;">**yes**</mark> - Enables data compression
  * <mark style="color:blue;">**no**</mark> - Disables data compression

{% hint style="info" %}
Does not affect OpenVPN tunnels
{% endhint %}

### Use Encryption

Specifies whether to allow data encryption

* **Parameter:** <mark style="color:green;">`use-encryption`</mark>
* **Values**
  * <mark style="color:blue;">**default**</mark> _(default)_ - Derive from interface
  * <mark style="color:blue;">**require**</mark> - Requires data encryption
  * <mark style="color:blue;">**yes**</mark> - Enables data encryption
  * <mark style="color:blue;">**no**</mark> - Disables data encryption

{% hint style="info" %}
Does not affect OpenVPN tunnels
{% endhint %}
