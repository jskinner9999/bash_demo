# bash_demo

Purpose:

Demo app to show the integration between PubNub and BASH. 

This demo is an example on how to use PubNub REST API to communicate with PunNub.  

These scripts could be used to help in the testing/troubleshooting of an application developed in any of PubNubs  70 SDKs.




The bash scripts in github will enable you to:
Display the current PubNub time.
Display all history in a channel
Post message to a channel
Post many messages to a channel
Subscribe to a channel and print in real time message being published to a channel
Delete all messages from a channel


Prerequisites:
Verify bash is installed.
bash --version
Verify jq is installed.
jq --version
Verify curl is installed
curl --version

Setup a FREE PubNub account.

acquire bash scripts from github
git clone xxxxxxxxxx
chmod u+x *.sh

Login to the PubNub portal:
Set message persistence to 1 day.
Copy the subscribe key and paste it into the SUBKEY variable in env.sh

 
