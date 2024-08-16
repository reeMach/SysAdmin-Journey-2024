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

