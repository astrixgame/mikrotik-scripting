---
description: >-
  This section covers how to connect to your MikroTik router using WinBox and
  SSH.
icon: plug
---

# Connecting to MT

### Default credentials

You can find default credentials, including the MAC address, on the MikroTik device label typically located at the bottom. Here's an example:

<div align="center"><figure><img src="../.gitbook/assets/mikrotik.png" alt="Device Label" width="250"><figcaption><p>Device Label</p></figcaption></figure></div>

***

### Using WinBox

{% stepper %}
{% step %}
### Download & Install WinBox

{% tabs %}
{% tab title="Windows" %}
You can download [latest version](https://mikrotik.com/download) of WinBox from official website.

{% embed url="https://mikrotik.com/download" %}
MikroTik Downloads
{% endembed %}
{% endtab %}

{% tab title="Linux" %}
First things first you will need **snap package manager**, you can install it using:

```bash
sudo apt update
sudo apt install snapd
```

Then you can simply install WinBox using snap:

```bash
sudo snap install winbox
```

And you are ready to go
{% endtab %}

{% tab title="Mac" %}
First things first you will need **Wine** which you can download and install from GitHub:

{% @github-files/github-code-block url="https://github.com/Gcenx/macOS_Wine_builds/releases" %}

Then download [latest version](https://mikrotik.com/download) of WinBox from official website:

{% embed url="https://mikrotik.com/download" %}
MikroTik Downloads
{% endembed %}

And launch W**inBox64.exe** using W**ine64.app**
{% endtab %}

{% tab title="Android" %}
Simply go to **Google Play Store** and search for **Mikrotik Pro**.

{% embed url="https://play.google.com/store/apps/details?id=com.mikrotik.android.tikapp" %}
Google Play Store - MikroTik Pro
{% endembed %}
{% endtab %}
{% endtabs %}


{% endstep %}

{% step %}
### Connect WinBox to MT

You can enter either your **IP** or **MAC address** with user and password manually or you can click on **Neighbors Tab** and find your MT and just enter user and password.

<figure><img src="../.gitbook/assets/winbox.png" alt="" width="563"><figcaption><p>WinBox Login</p></figcaption></figure>
{% endstep %}

{% step %}
### Start configuring

When you connect for the first time you will be prompt to change the password.

<figure><img src="../.gitbook/assets/winbox_config.png" alt=""><figcaption><p>WinBox Config</p></figcaption></figure>
{% endstep %}
{% endstepper %}



***

## Using SSH/telnet
