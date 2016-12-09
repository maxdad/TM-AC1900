# TM-AC1900
Automatic CFE flashing tool for TM-AC1900 -> ASUS AC68U

As always, flash CFE is tricky, the script is free for anyone to use at your own risk, 
I will not be responsible if anything goes south.


Step 1:
Obtain any ASUS AC68U CFE binary such as 1.0.2.1 tested. You can download it here:
https://mega.nz/#!V14VXZja!Z_MkN4MjfKmFRh06uuZN9idoqt2yOoWQot_ClCmno_c
Rename it to new_cfe.bin
Get this mtd-write v2:
https://mega.nz/#!R4AWkJSQ!pGw1Vl0j6qS9kYhbOtpvsgbKf-VIRfWRw61HhmIqRDM

Get either telnet or SSH access to the TM-AC1900 router, and scp over (auto_cfe.sh script + the new_cfe.bin + mtd-write) to /tmp/
if you have SSH access, otherwise a USB key will do the job, you can find out where your USB is mounted using command "df -h".

Step 2:
cd to the directory where both new_cfe.bin and the auto_cfe.sh script sits in, run it and enjoy watching.

Now you have the ASUS CFE! You have passed the only step that can really brick your router.

Step 3:
Next it is recommended to expand root partition use this firmware:
http://dlcdnet.asus.com/pub/ASUS/wireless/RT-AC68U/FW_RT_AC68U_30043763626.zip
Flash it use CFE webpage is most reliable, you can directly boot into CFE after the above step 3.

** Perform a manual NVRAM clear use WPS button after every firmware flash **

From now on you can flash pretty much anything through the normal firmware update web page.

I am using the Shibby AIO tomato for your reference:
http://tomato.groov.pl/download/K26ARM/138-MultiWAN/tomato-RT-AC68U-ARM--138-AIO-64K.zip

A lighter version maybe good too if you do not need all the features in AIO and could use some extra JFFS space:
http://tomato.groov.pl/download/K26ARM/138-MultiWAN/tomato-RT-AC68U-ARM--138-VPN-64K.zip




