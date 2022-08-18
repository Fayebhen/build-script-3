#!/bin/bash


# This is to verify that you are superuser.

if [ $UID != 0 ]; then echo "You must be superuser to run this script"

exit 1

fi

# Create user.

# Prompt user  for full name.
echo "Please enter your first name."
read FirstName

echo "Please enter your last name."
read LastName


# Create username (add firstname to first letter of last name) and user password.

firstname=$(echo "$FirstName")
firstchar=$(echo "$LastName" | cut -c1)
username=$(echo "$firstname$firstchar" | tr 'A-Z' 'a-z')
password="mel^%&ody"

echo "$username"

sudo useradd -p $password $username

# Create and place user in user group.
Shellgroup="GitAcc"

sudo groupadd $Shellgroup
sudo usermod -a -G $Shellgroup $username

passwd $username

# Check file for sensitive information (ex. SSN, phone #) before ADD, COMMIT, PUSH.
echo "which file would you like to check: " 
read file

  if ( head $file | grep -P '\d{3}\d{3}\d{4}' )
  then echo "file has sensitive information"
exit
fi 

  if ( head $file | grep -P '\d{3} \d{3} \d{4}' )
  then echo "file has sensitive information"
exit
fi
  
  if ( head $file | grep -P '\d{3}-\d{3}-\d{4}' )
  then echo "file has sensitive information"
exit
fi 

  if ( head $file | grep -P '\d{3}\d{2}\d{4}' )
  then echo "file has sensitive information" 
exit
fi

   if ( head $file | grep -P '\d{3} \d{2} \d{4}' )
   then echo "file has sensitive information"
exit
fi

if ( head $file | grep -P '\d{3}-\d{2}-\d{4}' )
  then echo "file has sensitive information"
exit
fi 


# ADD, COMMIT and PUSH.
# Get the arguement message
echo "Please enter your commit message, if none, press enter."
read message

#message="$1"

# If no commit message is passed, use current date time in the commit message.
if [[ -z "${message// }" ]]
   then
	message=$(date '+%Y-%m-%d %H:%M:%S')
fi

# Stage all changes
git add .
echo "<><><> staged all git fileS <><><>"

# Commit changes
git config --global user.email "$username@gmail.com"
git config --global user.name "$username"

git commit -m "$message"
echo "<><><> added commit on: '$message' <><><>"


# Get current branch and push
#current_branch=$( git branch | sed -n -e 's/^\* \(.*\)/\1/p' )
git push origin "firstB"
echo "<><><> pushed changes to '$current_branch' branch <><><>"





