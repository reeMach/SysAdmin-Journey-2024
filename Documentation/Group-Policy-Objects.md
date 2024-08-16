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

**Applying Password Group Policy Object**
  1. Open Server Manager > Tools > Group Policy Management 
  2. Group Policy Objects > Right click > New > Create GPO named Password Policy
  3. Right Click Password Policy > Edit > Navigate to Computer Configuration > Policies > Windows Settings > Account Policies > Password Policy. We'll be enforcing semi-strict policies as this is mostly for learning. See below for config:
    - Enforce password history: 1
      - This determines how many passwords are remembered and can't be reused.
    - Maximum password age: 365
      - This determines that max password age before a password reset is required.
    - Minimum password age: 0
      - This specifies the the number of days that password must be used before the user can change it.
    - Minimum password length: 14
      - Self-explantory. Minimum character amount required is 14. If we want to go beyond 14 characters, we will need to define and enable "Relax minimum password length limits".
    - Password must meet complexity requirements: Enabled
      - See explanation tab. There was a lot to read.
    - Store passwords using reversible encryption: Not Defined
      - May be non-compliant with some entities and can be easily decrypted due use of reversible encryption. If the encryption key is compromised, the decryption key is as well.
  4. On Group Policy Management > Right click an OU > Link an Existing GPO > Password Policy.
     - You ran into a hiccup here. The next steps were to change another user's password and select "User must change password at next logon" but it wasn't selectable. The solution was to open the account properties and unselect "Password never expires". When you attempted to change the password again, the option was available.
  5. Change a test user's password and try to logon and test your password policy.
     - Another hiccup. Since we're using RDP to login to our accounts, RDP will allow us to enter our temporary password, but won't allow us in because "You must change your password before logging on the first time..." We can't lock the administrator account as well and just switch users due to RDP session limitation. Before we hack a solution for this, we'll login locally and reset our pass as to not detract from this learning topic.
     - Next hiccup, we entered and reset our password, now we have receive a notification preventing us from logging in "The sign-in method you're trying to used isn't allowed..." When visiting local security policy to allow local log on (Run > secpol.msc > Local Policies > User Rights Assignment), the button to add group or users to the policy is greyed out. Instead we'll visit Server Manager > Tools > Group Policy Management > Edit an applicable GPO policy > Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > User Rights Assignment > Define and add groups. Link the GPO if it's not linked.
      -  Next next hiccup. Still doesn't work and it may be because there's an existing GPO named "Default Domain Policy" that does not define "Allow local log on". After defining and adding the appropriate groups, nothing.
      - Alright after hours of searching and following what other users have tried online, this doesn't seem like something we can we can fix. Even Microsoft moderators don't seem to know a resolution for this and keep repeating "Add the user to Allow Local Log on". The issue seems to be only on Windows Server 2022 and the work around is the add the user to "Domain Admins" which we don't want to do, but will do to get back on track.
  6. Password was eligible and I was able to login.



