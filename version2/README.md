# Automated Linux User Script
This script automates the creation of local Linux users by utilizing command-line arguments and secure password generation. It is designed to enhance administrative efficiency and system security by removing interactive prompts and preventing the use of weak, manually chosen passwords.

## Features
Root Privilege Enforcement: Validates that the script is executed with superuser (root) permissions to ensure system-level changes are authorized.

Automated Password Generation: Dynamically generates a secure, random 8-character password for each new account.

CLI Argument Support: Processes the first argument as the username and all subsequent arguments as the account comment (e.g., Full Name or Department).

Automatic Password Expiration: Forces the user to establish a new password upon their initial login to maintain credential confidentiality.

Success Verification: Monitors the exit status of internal commands and provides a detailed summary of the account metadata upon successful completion.

## How to Run
The script requires administrative privileges and specific command-line arguments to function.

Syntax
Bash

sudo ./add-new-local-user.sh USER_NAME [COMMENT]...
Example
Bash

sudo ./add-new-local-user.sh Mawa Mbil Chij - IT Department
## Technical Specifications
Environment: Optimized for RHEL/CentOS distributions.

Logic: Utilizes shift and $@ for flexible argument handling and passwd --stdin for non-interactive password assignment.

Exit Status: Returns 0 on success and 1 on failure (e.g., missing arguments, existing username, or insufficient permissions).
