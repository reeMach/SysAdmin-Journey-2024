# Environment Setup

## Installation of Windows Server 2022

**Overview**  
This guide details the installation process of Windows Server 2022 on a spare desktop computer, specifically using a Dell OptiPlex 7070. The server was installed to save energy and utilized for learning purposes.

### Steps for Installation:

1. **Download the ISO**  
   - Get Windows Server 2022 Evaluation Version from the [Microsoft website](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2022). This provides a 180-day trial period. After the trial period expires, the server will shut down.
2. **Enter Information**  
   - Fill in your details to proceed with the download.
3. **Download the 64-bit Edition**  
   - Ensure you select the 64-bit edition for compatibility.
4. **Create a Bootable USB**  
   - Download Rufus from [Rufus](https://rufus.ie/en/).
   - Use Rufus to create a bootable USB flash drive with the Windows Server 2022 ISO.
5. **Boot from USB**  
   - Plug in the USB flash drive to your spare desktop and select the USB boot option in BIOS.
   - Follow the on-screen instructions to load the installer.
6. **Install Windows Server 2022**  
   - Choose “Windows Server 2022 Standard Evaluation (Desktop Experience)” and proceed with the installation.
7. **Update the System**  
   - Once the installation is complete, update the server through Windows Update. It’s recommended to update the BIOS as well.

## Configuration Settings

### Steps for Configuration:

1. **Assign a Static IP**
   - Access your router’s interface.
   - Navigate to the DHCP Server section.
   - Assign an IP address, e.g., `10.xx.xx.7`, and create a static ARP entry for the MAC and IP address pair.

2. **Update the Computer Name**
   - Open Server Manager.
   - In the left table of contents, click `Local Server`.
   - Click on the computer name and update it as needed.
   - Restart the server.

3. **Set Up Static IP on the Server**
   - In Server Manager, click `Local Server`.
   - Click on `Ethernet`, right-click it, and select `Properties`.
   - Configure IPv4 with the static IP address assigned from your router.

4. **Install Active Directory Domain Services (AD DS)**
   - Open Server Manager and click `Manage` in the top-right corner.
   - Select `Add Roles and Features`.
   - Click `Next` until you reach `Server Roles`, then select `Active Directory Domain Services`.
   - Complete the installation.

5. **Promote Server to a Domain Controller**
   - Open Server Manager and click the notification flag in the top-right corner.
   - Select `Promote this server to a domain controller`.
   - Choose `Add a new forest` and enter a domain name (e.g., Burgers.local).
   - Set Forest Functional Level and Domain Functional Level to the highest level (e.g., Windows Server 2019).
   - Set up the Directory Services Restore Mode password.
   - Verify the settings and proceed with the installation.
   - The server will restart upon completion.

## Remote Desktop Setup

**Overview**  
This section outlines the process of setting up Remote Desktop Protocol (RDP) access to the server from another computer.

### Steps for Configuration:

1. **Enable Remote Desktop**
   - Open Server Manager and click `Local Server`.
   - Click `Disabled` next to `Remote Desktop`.

2. **Configure Remote Desktop Settings**
   - In the `Remote` tab, select `Allow remote connections to this computer`.
   - Enable the option `Allow connections only from computers running Remote Desktop with Network Level Authentication`.
   - Apply the changes and click `OK`.

3. **Test RDP Access**
   - By default, the local Administrator account has RDP access. Attempt to connect via RDP using the Administrator credentials.

