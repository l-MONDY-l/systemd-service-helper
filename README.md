# systemd-service-helper

> Bash tool to inspect, manage, and troubleshoot systemd services on Linux.

![Linux](https://img.shields.io/badge/Platform-Linux-blue?style=for-the-badge)
![systemd](https://img.shields.io/badge/Service%20Manager-systemd-6C757D?style=for-the-badge)
![Automation](https://img.shields.io/badge/Focus-Service%20Operations-orange?style=for-the-badge)

---

## Overview

`systemd-service-helper` is a Bash utility for Linux administrators to manage and troubleshoot services running under `systemd`.

It provides a simple command-line wrapper for common service tasks such as checking status, restarting services, enabling services at boot, and reviewing recent service logs.

---

## Features

- Check service status
- Start and stop services
- Restart services
- Enable and disable services
- View recent service logs
- List failed services
- List running services
- Useful for daily Linux operations and troubleshooting

---

## Use Cases

- Service troubleshooting
- Incident response
- Linux operations support
- Post-deployment validation
- System administration portfolio project

---

## Requirements

- Linux server using `systemd`
- Bash shell
- `systemctl`
- `journalctl`

---

## Installation

Clone the repository:

```bash
git clone https://github.com/I-MONDY-I/systemd-service-helper.git
cd systemd-service-helper
```
## Make the script executable:

```bash
chmod +x systemd_service_helper.sh
```

## Usage
Check service status:

```bash
./systemd_service_helper.sh status nginx
```

Supported Actions

 - status <service>
 - restart <service>
 - start <service>
 - stop <service>
 - enable <service>
 - disable <service>
 - logs <service> [lines]
 - failed
 - list-running

Example Output
```
======================================================================
SERVICE STATUS: nginx
======================================================================
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2026-03-08 17:42:00 +0530
```
