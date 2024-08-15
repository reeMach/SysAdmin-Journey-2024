## Table of Contents

  - [Environment Setup](#environment-setup)
  - [Organizational Units (OUs) and Active Directory Users and Computers (ADUC)](#organizational-units-and-active-directory-users-and-computers)
  - [Group Policy Objects](#group-policy-objects)
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

**Organizational Units (OUs)**
  - OUs allow for logical groups of objects such as users, computers, groups, etc. Before creating OUs, plan the structure based on organizational needs. Consider factors like geography, departments, and functions. While nesting OUs is possible, excessive nesting can complicate management and Group Policy application. Keep the structure as simple as possible. Maintain documentation of the OU structure, including the purpose of each OU and any associated GPOs or delegated permissions.
  - We'll first start off by clearing some default OUs. Right click and delete, goodbye. Next, right click our domain > new > Organizational Unit > name is Accounts > hit ok. If you want to delete the OU you've just created, right click > properties > Object > uncheck "Protect object from accidental deletion" > go back and right click your OU > delete.
 
**Creating Users and Groups**
  - Creating users was self explanatory ish. You would right click on an OU > New > Users and enter their information. To keep things uniform, I would enter the information normally, but the full name would be Mach, Riley and UPN and SAM would be something easy for me to remember since this is for practice.
  - Same as creating users, you would right click on an OU > new > group. We want to be descriptive and as detailed as possible when naming these groups.

    - Domain Local:
      - Use Case: Ideal for assigning permissions to resources within a single domain.
      - Scope: Only valid within the domain where it is created. Can be a member of Universal and Global groups but can only be assigned permissions within the same domain.
    - Global:
      - Use Case: Best for organizing users that belong to the same domain but are used across multiple domains.
      - Scope: Valid throughout the forest. Can be a member of Universal groups and can be used to assign permissions across domains.
    - Universal:
      - Use Case: Suitable for resources that are accessed across multiple domains within the forest.
      - Scope: Available across the entire forest. Can contain users from any domain and can be used to grant permissions across domains.
    - Security Group Type:
      - Use Cases: Granting access to shared folders, printers, applying GPOs, and managing access.
      - Purpose: Security groups are used to assign permissions to resources within your network. This includes file shares, printers, and other network resources.
      - Function: When you assign permissions to a security group, those permissions are granted to all members of the group. Security groups can be used for both local and domain-wide security policies.

    - Distribution Group Type:
      - Use Cases: Creating an email distribution lists for departments or sending announcements to a specific group of users.
      - Purpose: Distribution groups are used primarily for email distribution lists. They are not used for security purposes and cannot be used to assign permissions to resources.
      - Function: Members of distribution groups receive emails sent to the group’s email address. They are typically used within email systems like Microsoft Exchange.
<br/>
<br/>




## Group Policy Objects
- GPO is a collection of settings that can be applied to computers, users, or both within an Active Directory domain. These settings control various aspects of the working environment, such as security settings, software installation, desktop configuration, and more.

**Creating and Applying ADUC Desktop Shortcut GPO Example**
 1. Open Server Manager > Tools > Group Policy Management
 2. We'll create GPOs in the Group Policy Objects directory. Forest: Domain > Domains > Local Domain > Group Policy Objects > Right click > New > Create a GPO and name it something descriptive about your new creation. We'll use Icon_ADUC_Policy
 3. Right click Icon_ADUC_Policy > Edit > Navigate to User Configuration > Preferences > Windows Settings > Shortcuts
 4. Right click on the right hand pane > New > Shortcut > Provide the following configurations:
    - Name: Active Directory Users and Computers
    - Target type: File System Object
    - Location: Desktop
    - Target path: %SystemRoot%\system32\dsa.msc
 5. Apply and hit ok
 6. Exit the editor and go back to Group Policy Management
 7. We're going to find an OU to apply/link this GPO. Right click Accounts or whichever OU we want to use this GPO on > Link an Existing GPO > Select Icon_ADUC_Policy
 8. Now whichever users are under this OU should have ADUC on their desktop

**Testing and Troubleshooting GPOs**
  - Using `gpupdate /force` and `gpresult` on the end users computer _should_ update the policy associated to them.
  - Once the GPOs are applied, the change should appear immediately. Log onto your test user and you'll see ADUC on your desktop.
  - You ran into an issue where you created a GPO and linked it to the _correct_ OU, but it wasn't. Always double check where we're applying these GPOs.
  - Instead of applying a GPO to an OU, we can apply it to a group instead. Those users who are apart of the group will have the policies be applied to them.
    1. Open Group Policy Management > Select your GPO > on the right pane under Security Filtering >  Remove Authenticated Users
    2. Select Add > Search for the security group > Click ok
    - If the OU has multiple GPOs linked, you may want to enforce this GPO so that it takes precedence over others. This can be done by right-clicking the GPO link and selecting Enforced.
    - In the Delegation tab of the GPO, you can fine-tune which groups have permissions to apply the policy. You can adjust the Read and Apply group policy permissions here.
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
