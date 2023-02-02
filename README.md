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
    git clone https://github.com/jskinner9999/bash_demo.git
    chmod u+x *.sh

Login to the PubNub portal:
    Set message persistence to 1 day.
    Copy the subscribe key and paste it into the SUBKEY variable in env.sh
    Copy the pubscribe key and paste it into the PUBKEY variable in env.sh
    define the UUID variable  in env.sh
        Define the channel (CHAN) variable in env.sh
In the directory that contains the bash scripts: 
    Enter; . ./env.sh

Procedure:
	To Publish a message to PubNub:
		./post.sh <message>
	To print the current PubNub time
		./time.sh
	To subscribe and listen to a channel
		./subs1.sh
	To Display message on a channel upto 100 messages
		./history.sh
	To display ALL messages on a channel then sort messages
		./all_hist.sh
	To Delete all message in a channel
		./delete_hist.sh
		








 

