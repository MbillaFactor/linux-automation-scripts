# Automated Linux User Script (Updated Version)

This script automates the creation of local Linux users, improving upon the previous version by adding better output handling, minor bug fixes, and clearer developer notes. Like the original, it uses command-line arguments and generates secure passwords, but it now also ensures cleaner redirection of errors and maintains readability for maintainers.

## Features

Root Privilege Enforcement: Validates that the script is executed with superuser (root) permissions to ensure system-level changes are authorized.

Automated Password Generation: Dynamically generates a secure, random 8-character password for each new account.

CLI Argument Support: Processes the first argument as the username and all subsequent arguments as the account comment (e.g., Full Name or Department).

Automatic Password Expiration: Forces the user to change their password upon initial login to maintain credential confidentiality.

Success Verification: Checks the exit status of commands like useradd and passwd to ensure the account is created correctly.

Improved Output Handling: Uses proper stdout and stderr redirection (1>&2, &>, |&) to prevent error messages from cluttering the terminal.

Cleaner Developer Notes: Provides explanations for redirects, /dev/null, and other implementation details for future maintainers.

## How to Run

The script requires administrative privileges and command-line arguments.

Syntax:

sudo ./add-newer-local-user.sh USER_NAME [COMMENT]...


Example:

sudo ./add-newer-local-user.sh Mawa Mbil Chij "IT Department"

## Technical Specifications

Environment: Optimized for RHEL/CentOS distributions.

Logic: Uses shift and $@ for flexible argument handling; passwd --stdin (CentOS style) for non-interactive password assignment.

Exit Status: Returns 0 on success and 1 on failure (e.g., missing arguments, insufficient privileges, or if a command fails).

Notes for Developers: Proper stdout/stderr handling, use of /dev/null, and clear separation of personal and technical comments for readability.

## Why This README Was Updated

Reflects the improved version of the script (add-newer-local-user.sh) with enhanced output/error handling.

Documents technical improvements such as proper stdout/stderr redirection.

Highlights developer-friendly notes for maintainability.

Keeps the same structure as the original README for consistency, making it easy for anyone familiar with the first version to follow.
