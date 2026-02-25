### Overview
This repository contains my first set of *Linux automation scripts*, built during my DevOps learning journey.  
Each script focuses on real system administration tasks and automation logic using Bash.

---

## 🔹 Scripts Included

### 1️⃣ Add User Script
- Automates user creation with default groups and home directory setup.
- Uses root privilege checks and error handling.
- Lays the foundation for Linux user management automation.

---

### 2️⃣ User Deletion & Archiving Script
Automates the process of *disabling or deleting local Linux user accounts*.  
It also provides optional support for *archiving user home directories* before deletion,  
ensuring that user data is safely stored and system accounts remain protected.

---

## ⚙️ Features
- Requires *root privileges* (runs only with sudo or as root)
- Supports multiple users at once
- Validates that system users (UID < 1000) are not deleted
- Optionally archives home directories before deletion
- Provides clear feedback and error messages
- Uses getopts for clean command-line options

---

## 🧠 Command Options
| Flag | Description |
|------|--------------|
| -d | Delete user instead of disabling |
| -r | Remove the user’s home directory |
| -a | Archive the user’s home directory before deletion |

---

## 🖥️ Usage
Run the script with the desired options and usernames.  
You must have *root or sudo privileges*.

```bash
sudo ./delete_user.sh [OPTIONS] USERNAME [USERNAME2...]
