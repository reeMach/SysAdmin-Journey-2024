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
