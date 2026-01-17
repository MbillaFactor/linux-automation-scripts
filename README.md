# Linux User Automation Script

A Bash script designed to make creating new Linux users fast and easy. 

## Features
* **Root Validation:** Checks if you are an admin before running.
* **Automation:** Sets up the username, full name, and home folder in one go.
* **Security:** Forces the new user to change their password the first time they log in.

## How to Run
1. Give the script permission to run: 
   `chmod 755 add-local-user.sh`
2. Run it as an admin: 
   `sudo ./add-local-user.sh`
