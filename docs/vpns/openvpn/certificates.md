---
description: This section covers how to configure certificates for OpenVPN.
icon: fingerprint
layout:
  title:
    visible: true
  description:
    visible: false
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
---

# Certificates

{% hint style="warning" %}
Recommended **key size** is **4096** bit or higher!
{% endhint %}

In WinBox you can create certificates in **System -> Certificates**, there you can click to <kbd>**+**</kbd> to create new certificate or you can use terminal with command `/certificate`

You will need following certificates:

* Authority certificate
* Server certificate
* Client certificate

The authority certificates is needed for signing the server and client certificate.

***

## Authority certificate

We will use LMTCA _(Local MikroTik Certificate Authority)_ in this example, but you can create your own name for you authority certificate.

### Creating

Click on **`+`** to add certificate

You will need fill out:

* **Name** - Your internal name for you certificate
* **Common Name (CN)** - You authority name
* **Key Size** - At least 2048 bit, recommended is 4096 bit
* **Days Valid** - You can use for example 3650 for 10 years

> Other parameters are optional in this example we will fill also location and company name.

Then click to the **Key Usage tab**, and check:

* CRL Sign
* Key Cert. Sign

Click **apply** to save the certificate.

{% code overflow="wrap" fullWidth="false" %}
```bash
/certificate add name=LMTCA common-name="LMTCA" key-size=4096 days-valid=3650 key-usage=crl-sign,key-cert-sign
```
{% endcode %}

### Signing

Now you can **sign the certificate** by clicking in right side to **sign button**, in certificate select your LMTCA certificate and into **CA CRL Host** enter you **public IP** and click sign.

You can enter your public **IP or your DDNS** name into **ca-crl-host** or you can sign the certificate without it but this prevents **man-in-middle attacks** by making sure your are connected to the right OpenVPN server.

{% code overflow="wrap" %}
```bash
/certificate sign LMTCA ca-crl-host=<your public ip / ddns name>
```
{% endcode %}

***

## Server certificate

Now you need to create server certificate.

### Creating

Click on **`+`** to add certificate

You will need fill out:

* **Name** - "SERVER" or any your name
* **Common Name (CN)** - In this case "SERVER"
* **Key Size** - Use same or higher then in authority certificate
* **Days Valid** - You can use same as in authority cert. 3650

Then click to the **Key Usage tab**, and check:

* Digital Signature
* Key Encipherment
* TLS Server

Click **apply** to save the certificate.

{% code overflow="wrap" %}
```bash
/certificate add name=SERVER common-name="SERVER" key-size=4096 days-valid=3650 key-usage=digital-signature,key-encipherment,tls-server
```
{% endcode %}

### Signing

Now sign the certificate by LMTCA authority, by clicking sign in right side and select your server certificate and **CA** set to your **authority certificate**.

{% code overflow="wrap" %}
```bash
/certificate sign SERVER ca="LMTCA"
```
{% endcode %}

Now set the certificate to **trusted** by clicking to the "trusted" checkbox at the bottom of certificate settings.

{% code overflow="wrap" %}
```bash
/certificate set SERVER trusted=yes
```
{% endcode %}

***

## Client certificate

Now you need to create client certificate or you can create client template certificate without signing and then create copies from the template for example for multiple clients and sign each.

### Creating

Click on **`+`** to add certificate

You will need fill out:

* **Name** - "CLIENT" or any your name
* **Common Name (CN)** - Client's certificate name, used to revoke certificate
* **Key Size** - Use same or higher then in authority certificate
* **Days Valid** - You can use same as in authority cert. 3650

Then click to the **Key Usage tab**, and check:

* TLS Client

Click **apply** to save the certificate.

{% code overflow="wrap" %}
```bash
/certificate add name=CLIENT01 common-name="CLIENT01" key-size=4096 days-valid=3650 key-usage=tls-client
```
{% endcode %}

### Signing

Now sign the certificate by LMTCA authority, by clicking sign in right side and select your client certificate and **CA** set to your **authority certificate**.

{% code overflow="wrap" %}
```bash
/certificate sign CLIENT01 ca="LMTCA"
```
{% endcode %}

Now set the certificate to **trusted** by clicking to the "trusted" checkbox at the bottom of certificate settings.

{% code overflow="wrap" %}
```bash
/certificate set CLIENT01 trusted=yes
```
{% endcode %}

***

<details>

<summary>Show all steps</summary>

{% code overflow="wrap" %}
```bash
# CA certificate
/certificate add name=LMTCA common-name="LMTCA" key-size=4096 days-valid=3650 key-usage=crl-sign,key-cert-sign

/certificate sign LMTCA ca-crl-host=<your public ip / ddns name>

# Server certificate
/certificate add name=SERVER common-name="SERVER" key-size=4096 days-valid=3650 key-usage=digital-signature,key-encipherment,tls-server

/certificate sign SERVER ca="LMTCA"
/certificate set SERVER trusted=yes

# Client certificate (optional)
/certificate add name=CLIENT common-name="CLIENT" key-size=4096 days-valid=3650 key-usage=tls-client

/certificate sign CLIENT ca="LMTCA"
/certificate set CLIENT trusted=yes
```
{% endcode %}

</details>

## Exporting certificates

To export your certificates go to **Files** and right click to each certificate and click on export.

There you can enter password for the certificate, also select type of exported file, you can use "PEM"
