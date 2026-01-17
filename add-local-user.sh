#!/bin/bash
# ==============================================================================
# Hey Future Me! 
# This script handles the manual heavy lifting of creating a new user.
# It handles the account creation, home directory, and forces a password reset.
# ==============================================================================

# First things first: We need root power to touch user files.
# Bash stores the User ID in ${UID}. Root is always 0.
# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then 
 echo 'you need to run this with sudo or as root.'
 exit 1
fi
 
# The -p flag just lets us put a prompt message right in the command.
# Get the username (login).
read -p 'provide the username: ' USER_NAME

# Get the real name (contents for the description field).
read -p 'provide the user account full name: ' COMMENT

# Get the password.
read -p 'provide the account password: ' PASSWORD


# Now we actually create the account.
# -c adds their name as a comment.
# -m makes sure they actually get a /home folder (important!!!!).
# Create the user with the password.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Double-check that the password was taken.
# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
 echo 'The account could not be created.'
 exit 1
fi



# Set the password we got earlier.
# We're piping the password string directly into the passwd command.
# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
 echo 'password could not be set.'
 exit 1
fi


# This is a security "best practice":
# Expire the password immediately so they have to pick a secret one the moment they log in for the first time.
# Force password change on first login.
passwd -e ${USER_NAME}

# Give us a nice clean summary of what just happened.
# Display the username, password, and the host where the user was created.
echo 
echo 'username:'
echo "${USER_NAME}"
echo
echo 'comment:'
echo "${COMMENT}"
echo 
echo 'password:'
echo "${PASSWORD}"
echo
echo 'hostname:'
echo "${HOSTNAME}"
# All done!
exit 0



