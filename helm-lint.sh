#!/bin/bash
helm lint CHARTS

if 
[[ $? -eq 0 ]]
then 
echo "Looks good"
else 
echo " There is an issue with the helm charts it can't be deploy please check the syntax"
exit 1
fi
