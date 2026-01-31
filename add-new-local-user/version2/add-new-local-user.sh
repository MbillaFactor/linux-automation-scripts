#!/bin/bash
#
# The script creates a new user on the local system.
# You must supply a username as an argument on the script.
# Optionally, you can provide a comment for the account. It could either be the account owner full name or department
# A password will be automatically generated for the account.
# Finally, we are going to display the information.


# First things first: we need root or sudo. 
# Without it, we can't touch /etc/passwd or create new home folders.
# Make sure the script is being executed with superuser privileges.5
if [[ "${UID}" -ne 0 ]]
then 
   echo "Please run as root or sudo"
   exit 1 
fi

# We need at least a username to get started.
# If the user doesn't supply at least one argument, then give them help.
if [[ "${#}" -lt 1 ]]
then
    echo "Usage: ${0} USER_NAME [COMMENT]"
    echo "Please provide a username USER_NAME and then provide comment for the COMMENT field"
    exit 1 
fi

# We'll take the first word as the username.
# The first parameter is the user name.
USER_NAME="${1}"


# The 'shift' command clears out the username from the argument list and makes it easier for others to come as comment
# The rest of the parameters are for the account comments.
shift
COMMENT="${@}"

# Generate a password.
# I used the system clock date and checksum to generate an eight character password
PASSWORD=$(date +%S%N | sha256sum | head -c8)
echo "Generate password:${PASSWORD}"

# Create the user with the password.
# -c adds the user's description, and -m builds their /home folder.
useradd -c "${COMMENT}" -m "${USER_NAME}"

# Check to see if the useradd command succeeded.
# If the user is already created by doing this it will fail.
if [[ "${?}" -ne 0 ]]
then 
 echo "Account could not be generated"
 exit 1
fi

# Set the password.
# NOTE: The line below is specifically for RHEL/CentOS systems.
# If running on Ubuntu/Debian, replace the next line with:
# echo "${USER_NAME}:${PASSWORD}" | chpasswd
echo "${PASSWORD}" | passwd --stdin "${USER_NAME}"     # Set Password CentOS style, because when I was writing this I used CentOS.

# Check to see if the passwd command succeeded.
# Note "${?}" this is actually helping me to check the status of the command
if [[ "${?}" -ne 0 ]]
then 
  echo "Password failed to be generated."
fi


# Force password change on first login.
passwd -e "${USER_NAME}" 


# Display the information
# This part will display username,comment, and hostname.
echo 
echo ‘username:’
echo "${USER_NAME}"
echo 
echo ‘comment:’
echo "${COMMENT}"
echo
echo ‘hostname:’
echo "${HOSTNAME}"
exit 0
