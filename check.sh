#! /bin/bash 

USER=${User}

cat permission.txt | grep -i $USER

if 
[[ $? -eq 0 ]]
then 
echo "You have permission to run this job"
else 
echo "You DON'T have permission to run this job"
exit 1
fi 
