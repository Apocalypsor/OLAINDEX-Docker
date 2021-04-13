#!/bin/bash

url=$(curl -sSL http://localhost | grep href=\"http://localhost/d/ | sed "s/href=\"\(.*\)\"/\1/g")
urls=(${url// /})

for i in "${!urls[@]}";   
do   
    curl -sSL "${urls[$i]}"  
done  