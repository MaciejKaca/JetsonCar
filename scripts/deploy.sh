# Try to read credentials from the file scripts/credentials.txt with a format: ip:username:password

# Read credentials from the file
credentials=$(cat scripts/credentials.txt)
ip = $(echo $credentials | cut -d ':' -f 1)
username = $(echo $credentials | cut -d ':' -f 2)
password = $(echo $credentials | cut -d ':' -f 3)

# If the file is not found, ask for credentials
if [ -z "$credentials" ]
then
    echo "Enter the IP address of the JetsonNano:"
    read ip
    echo "Enter the username:"
    read username
    echo "Enter the password:"
    read password
fi

# Save credentials to the file
echo "$ip:$username:$password" > scripts/credentials.txt

# Copy the repository jetson-car to the deovice
sshpass -p $password scp -r ../../jetson-car $username@$ip:~/jetson-car

# Run cmake and make
sshpass -p $password ssh $username@$ip "cd ~/jetson-car && mkdir build && cd build && cmake .. && make"