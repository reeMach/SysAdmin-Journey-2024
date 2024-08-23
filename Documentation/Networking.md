## Networking
- We're going to be configuring pfSense to keep my sanity in check. Why? Customization, flexibility, advanced features, security, and of course for educational reasons. We'll also be touching on firewalls, vlans, ports, piHole etc. Out of the box, pfSense is safe as for home use as far as I know and its community supported. We're not going to be going into the nitty gritty detail on how to setup pfSense or updating our spare computer as there are a billion videos on Youtube on how to do this. This is more so on utilizing pfSense.
- Hardware Requirements:
    - Spare computer. Went with a computer with N100 chip. Low power and strong.
    - Needs at least two ethernet ports (Wan and Lan ports)
    - Managed switch. Anything works as this is for educational purposes.
    - Access point. Ubiquiti U7 Pro was cheap for what they offer. Wasn't the friendliest experience working with Ubiquiti, but it taught me tons.
    - Some good ethernet cable, preferably Cat6A, to avoid rewiring the house again in the near future.
    - Raspberry Pi


## Configuring pfSense to preference
- Because I'm typing this after configuring pfSense, some steps may be missed. Web interface > console. The console is actually not that bad, but the web interface is pretty well done.

**Initial Setup**
1. Connect to your router (pfSense - 192.168.1.1) and login with the default credentials. Should be admin/pfsense.
2. Of course, change the default credentials!
    - System > User Manager > Edit admin (pencil icon) > Enter new password > Save
3. DNS Server can be 1.1.1.1 or 8.8.8.8 - We'll setup piHole later though.
4. Setup DHCP, but setup a different Lan IP address instead of using the 192.168.0.1 schema
    - Useable ranges:
        - 10.0.0.0 to 10.255.255.255 (Class A range)
        - 172.16.0.0 to 172.31.255.255 (Class B range)
        - 192.168.0.0 to 192.168.255.255 (Class C range)
    - Subnet Mask: 255.255.255.0
    - CIDR Notation: /16 (65,536 addresses) or /24 (256 addresses)
    - Restart devices or release the IP address on Windows devices via command prompt > ipconfig /release > ipconfig /renew
5. Open a browser > Visit IP address for pfSense > Login > Interface > Assignments
    - Hope you know the physical MAC address of each ethernet port. If not, check your physical device to see if your ethernet ports are labeled.
    - Assign WAN and LAN interface to the appropriate ethernet port and plug in the respective cable. Save.

**DHCP Server**
1. Services > DHCP Server > Enable DHCP server on LAN interface
    - DHCP Backend: Kea DHCP (ISC DHCP EOL)
    - Range: Leave like 10-20 addresses for static mapping later
2. Save.

**Port Forward**
- Want to spin up that MC server?
1. Firewall > NAT > Add
    - Protocol: TCP (Defaulted to Any. For some reason when you switched this part to TCP, the option "Destination port range" didn't appear. Refresh and try again.)
    - Destination Port Range - Custom: #####
    - Redirect target IP: Address or Alias - Private IP of the device hosting the server
    - Redirect target port: Other - ##### (Same as above)
