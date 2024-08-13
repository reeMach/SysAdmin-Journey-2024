## Table of Contents

  - [Environment Setup](#environment-setup)
  - [Organizational Units (OUs) and Active Directory Users and Computers (ADUC)](#organizational-units-and-active-directory-users-and-computers)
  - [Group Policy](#group-policy)
  - [Networking](#networking)
  - [Security](#security)




## Introduction
A public repo to share my journey on learning how to become a system administrator. I'm not taking any specific route nor am I following any specific guide. I'm loading up Windows Server 2022 on a spare computer and going at it.




## Environment Setup

**Installation of Windows Server 2022**
  - Get Windows Server 2022 Evaluation Version from the following website: https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2022. This provides a 180-day trial period. After the trial period expires, the server will shut down. We will be installing this on a spare micro desktop to save energy! A Dell OptiPlex 7070 was purchased for $150 on eBay.

#### Steps for Installation:

  1. Click Download ISO
  2. Enter your information
  3. Download 64-bit edition
  4. Download Rufus from: https://rufus.ie/en/ and create your Windows Server 2022 USB - This will be used to format and create a bootable USB flash drive
  5. Plug in your USB onto the spare desktop, select USB boot option, and load up the installer
  6. We are going to select Windows Server 2022 Standard Evaluation (Desktop Experience) and install
  7. Once in, update everything! (I updated my BIOS as well)
<br/>
<br/>




**Configuration Settings**
  - We're going to assign a static IP address, update the computer name, install AD DS, setup a domain, and promote the server to a domain controller.

#### Steps for Configuration:

  1. Assign a static IP - Visit your router interface.
  2. Go to DHCP Server.
  3. Assign 10.xx.xx.7 and create an ARP table static entry for the MAC and IP address pair.
  4. Go to your server and open Server Manager.
  5. On the left table of contents, click Local Server, and update your computer name. Restart the computer.
  6. On the left table of contents, click Local Server, and click Ethernet. Right-click Ethernet, then properties.
  7. Set up IPv4 to the IP address we assigned this server to on our router. - Static IP setup.
  8. Install Active Directory Domain Services - Open Server Manager.
  9. Click on "Manage" on the top right > click "Add Roles and Features."
  10. Click Next until you reach "Server Roles." Select "Active Directory Domain Services" and complete the install - AD DS setup.
  11. Promote server to a domain controller - Open Server Manager > click the notification flag on the top right > click "Promote this server to a domain controller."
  12. Select "Add a new forest" and enter a domain name, e.g., Burgers.local.
  13. Set Forest Functional Level and Domain Functional Level to the highest level, e.g., Windows Server 2019.
  14. Set up the Directory Services Restore Mode password.
  15. Verify all other options and install to proceed and restart.
<br/>
<br/>




**Remote Desktop Setup**
  - Of course we're going to want to use RDP to access our server from our other computer.

#### Steps for Configuration:
  1. Open Server Manager and click Local Server
  2. Click "Disabled" where it says Remote Desktop
  3. Under "Remote" tab, select "Allow remote connections to this computer" and "Allow connections only from..."
  4. Hit Apply and ok
  5. By default, the local Administrator account has access. Try to RDP in with Administrator.
<br/>
<br/>



## Organizational Units and Active Directory Users and Computers
  - Create a desktop shortcut by right clicking your desktop > New > shortcut > enter C:\Windows\System32\dsa.msc. You can also open ADUC by Server Manager Tools.

- **Organizational Units (OUs)**
  - OUs allow for logical groups of objects such as users, computers, groups, etc.
  - We'll first start off by clearing some default OUs. Right click and delete, goodbye. Next, right click our domain > new > Organizational Unit > name is Accounts > hit ok. If you want to delete the OU you've just created, right click > properties > Object > uncheck "Protect object from accidental deletion" > go back and right click your OU > delete.
  -  
**Creating Users and Groups**
  - Creating users was self explanatory ish. You would right click on an OU > New > Users and enter their information. To keep things uniform, I would enter the information normally, but the full name would be Mach, Riley and UPN and SAM would be something easy for me to remember since this is for practice.
  - Creating Security and Distribution Groups

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
