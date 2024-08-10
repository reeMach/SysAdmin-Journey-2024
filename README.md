## Table of Contents

- [Environment Setup](#environment-setup)
- [Topics Covered](#topics-covered)
  - [Active Directory](#active-directory)
  - [Group Policy](#group-policy)
  - [Networking](#networking)
  - [Security](#security)

## Introduction
A public repo to share my journey on learning how to become a system administrator. I'm not taking any specific route nor am I following any specific guide. I'm loading up Windows Server 2022 on a spare computer and going at it.

## Environment Setup

- **Installation of Windows Server 2022**
  - Initial Setup
    - Get Windows Server 2022 Evaluation Version from the following website: https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2022. This provides a 180 day trial period. After the trial period expires, the server will shutdown. We will be installing this on a spare micro desktop to save energy! A Dell OptiPlex 7070 was purchased for $150 on eBay.
      1. Click Download ISO
      2. Enter your information
      3. Download 64-bit edition
      4. Download Rufus from: https://rufus.ie/en/ and create your Windows Server 2022 USB - This will be used to format and create a bootable USB flash drive
      5. Plug in your USB onto the spare desktop, select USB boot option, and load up the installer
      6. We are going to select Windows Server 2022 Standard Evaluation (Desktop Experience) and install
      7. Once in, update everything! (I updated my bios as well)
  - Configuration Settings
- **Domain Controller Setup**
  - Installing Active Directory Domain Services (AD DS)
  - Configuring the Domain
- **Remote Desktop Setup**
  - Configuring Remote Desktop Access
  - Security Considerations

## Topics Covered

### Active Directory
- **Creating Users and Groups**
  - Adding Users
  - Creating Security and Distribution Groups
- **Organizational Units (OUs)**
  - Creating and Managing OUs
  - Delegating Permissions
- **Domain Controllers**
  - Adding Additional Domain Controllers
  - Replication and Redundancy

### Group Policy
- **Creating and Applying GPOs**
  - Basic GPO Creation
  - Linking and Filtering GPOs
- **Testing and Troubleshooting GPOs**
  - Using `gpupdate /force` and `gpresult`
  - Common Issues and Solutions
- **Policy Settings**
  - User Configuration Settings
  - Computer Configuration Settings

### Networking
- **Basic Networking Concepts**
  - IP Addressing and Subnetting
  - DNS and DHCP Configuration
- **VLANs and Network Segmentation**
  - Creating and Configuring VLANs
  - Inter-VLAN Routing
- **Firewall and Security**
  - Configuring Windows Firewall
  - Implementing Network Security Policies

### Security
- **User Permissions and Rights**
  - Managing User Accounts and Permissions
  - Security Groups and Roles
- **Audit and Monitoring**
  - Setting Up Auditing
  - Monitoring Logs and Events
- **Backup and Recovery**
  - Configuring Backup Solutions
  - Disaster Recovery Planning
