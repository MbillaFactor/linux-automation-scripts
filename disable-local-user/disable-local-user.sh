#!/bin/bash 

ARCHIVE_DIR=/archive
Usage() {
   # Display the usage and exit.
   echo "Usage: ${0} [-dra] USER [USERN]..." >&2  
   echo 'Disable a local Linux account.' >&2
   echo '  -d Delete user instead of disabling them' >&2
   echo '  -r Remove home directory of account.' >&2
   echo '  -a Create an archive of the home directory associated  with the account' >&2
}

#  ${0} is the name of the script, [-dra] optional options.USER, this is mandatory         
#  [USERN]... additional users


# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then 
  echo "Please run as root or sudo"
  exit 1
fi 

# Parse the options.
while getopts dra OPTION       
do
   case ${OPTION} in           # Opening the case statement
     d) DELETE_USER='true' ;;
     r) REMOVE_OPTIONS='-r' ;; # '-r' is used later like this -r ${USERNAME}        
     a) ARCHIVE='true' ;; 
     ?) Usage ;;               # This ensure the person running the script gets help from the function if the type in wrongly.
   esac                        # Closing the case statement
done                           # Closing the while loop

# Remove the options while leaving the remaining arguments.
shift "$(( OPTIND - 1))"
 
# If the user doesn't supply at least one argument, give them help.
if [[ "${#}" -lt 1 ]]
then 
  Usage
fi


# Loop through all the usernames supplied as arguments.
for USERNAME in "${@}"
do 
  echo "Processing user: ${USERNAME}"   # looping through all the username that is USER [USER]...

  # Make sure the UID of the account is at least 1000.
   USERID=$(id -u ${USERNAME})
   if [[ "${USERID}" -lt 1000 ]]
   then 
      echo "Refusing to remove the ${USERNAME} account with UID ${USERID}." >&2
      exit 1
    fi

  # Create an archive if requested to do so.
  if [[ "${ARCHIVE}" = 'true' ]]
  then 
     # Make sure the ARCHIVE_DIR directory exists.
     if [[ ! -d "${ARCHIVE_DIR}" ]]
      then 
        echo "Creating ${ARCHIVE_DIR} directory."
        mkdir -p ${ARCHIVE_DIR}
        if [[ "${?}" -ne 0 ]]
        then 
          echo "The archive directoty ${ARCHIVE_DIR} could not be created" >&2
          exit 1
         fi
       fi

   # Archive the user's home directory and move it into the ARCHIVE_DIR
   HOME_DIR="/home/${USERNAME}"
   ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
   if [[ -d "${HOME_DIR}" ]] 
   then 
     echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
     tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
     if [[ "${?}" -ne 0 ]]
     then 
       echo "Could not create ${ARCHIVE_FILE}." >&2
       exit 1
      fi
    else
      echo "${HOME_DIR} does not exist or is not a directory." >&2
      exit 1
    fi
  fi

  if [[ "${DELETE_USER}" = 'true' ]]
  then 
   # Delete the user.
   userdel ${REMOVE_OPTION} ${USERNAME}

   # Check to see if the userdel command succeeded.
   # We don't want to tell the user that an account was deleted whenit hasn't been.
   if [[ "${?}" -ne 0 ]] 
   then 
     echo "The account ${USERNAME} was NOT deleted. " >&2
     exit 1
   fi 
   echo "The account ${USERNAME} was deleted."
  else 
   chage -E 0 ${USERNAME}
     
    # Check to see if the chage command succeeded.
    # We don't want to tell the user that an account was disabled when it has not been.
    if [[ "${?}" -ne 0 ]]
    then
      echo "The account ${USERNAME} was NOT disabled. " >&2
      exit 1
    fi
    echo "The account ${USERNAME} was disabled."
  fi
done 

exit 0 

