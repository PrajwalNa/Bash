#!bin/bash
Linux=('Debian', 'Redhat', 'Ubuntu', 'Android', 'Fedora', 'Suse')
x=3

Linux=( "${Linux[@]:0:$x}" "${Linux[@]:$(($x + 1))}" )
echo "${Linux[@]}"

fname=john
john=thomas
echo "${!fname}"

if [ -f new_script.sh ]
then
    echo "File exists"
else
    echo "File does not exist"
fi
