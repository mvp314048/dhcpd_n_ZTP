# This is the DHCP config and ZTP script files.
Simply use 'isc-dhcp-server' and 'Python3' to enable DHCP and HTTP services on the server. 

To run this config with providing DHCP option to Cumulus Linux devices, please don't forget to put in the following string "option cumulus-provision-url code 239 = text;" in the DHCP config, as the following:

<img width="441" alt="image" src="https://github.com/user-attachments/assets/050eed5a-69b9-441a-b308-f437186444fc" />



1. Avoid configuring both static and dynamic leases simultaneously, otherwise you get the below error in your DHCP log:
<img width="765" alt="image" src="https://github.com/user-attachments/assets/a31c707d-0645-45e5-9b42-687dd09752fc" />

2. Remember to correct the Incorrect file encoding (Windows line endings) issue by using command "**dos2unix**" or "**sed -i 's/\r$//' _scriptName.sh'**"

3. Make sure the script is exectuble or read-able. You can use command '**chmod +x**' or '**chmod +r**' to change the permission.

4. You can use command '**journalctl -xeu isc-dhcp-server.service**' to check detailed DHCP log on the Linux server. Using '**systemctl status ztp**' to check the log on Cumulus Linux device.

5. The command '**sudo python3 -m http.server --bind 0.0.0.0 80 &**' should be ordered in the folder where you store the ZTP script, so the client can load the script from the HTTP path.

6. Using '**ps aux | grep xxx**' and '**kill pid xxx** to check or kill the PID, or check with 'netstat -an' to see if HTTP service is correctly running.
