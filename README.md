# Ansible Windows Automation

Automated provisioning and configuration management for Windows workstations using Ansible and Semaphore.

## Repository Structure

- `playbook.yml`: Master playbook orchestrating workstation configuration.
- `inventory.ini`: Windows target hosts (`X1-YOGA`, `X1-CARBON`) configured for OpenSSH.
- `requirements.yml`: Ansible Galaxy collections (`ansible.windows`, `community.windows`).
- `bootstrap.ps1`: One-time setup script for fresh Windows machines to enable OpenSSH and lock firewall to Private networks.
- `roles/`
  - `system_tweaks/`: Time sync, date formats, .zip associations, custom region policy, desktop wallpaper, network shortcuts.
  - `debloat/`: Automated Win11Debloat execution with `CustomAppsList`.
  - `packages/`: Package management via Winget (`core` and `full` profiles) + Audacity FFmpeg.
  - `tools/`: NirCmd, WinXCorners, Android platform-tools, keyboard remappings, startup shortcuts.

## Quick Start on a New Windows PC

1. Open PowerShell as Administrator.
2. Run `bootstrap.ps1`:
   ```powershell
   irm https://raw.githubusercontent.com/kylehase/ansible-windows/main/bootstrap.ps1 | iex
   ```
3. Trigger the playbook from Ansible Semaphore on Proxmox.
