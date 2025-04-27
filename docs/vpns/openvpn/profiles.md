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
