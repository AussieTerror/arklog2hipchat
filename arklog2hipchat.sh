#!/bin/bash

#Set log path - enter your Ark Servers Logs path here, with no trailing '/' as per example below
logpath=/home/steam/servers/ark/ShooterGame/Saved/Logs

#Hipchat API URL , replace [ROOM_ID] with your room id is an integer and [AUTH_TOKEN] with your rooms Notification Authentication Token 
api_url='https://api.hipchat.com/v2/room/[ROOM_ID]/notification?auth_token=[AUTH_TOKEN]'

#Tail the latest log file from the specified log path and set the latest line as the $line variable, then post $line to the api_url with Hipchat formatting
tail -f `/bin/ls -1tr $logpath/* | /bin/sed -ne '$p'`|while read line;do
        msg=`echo "$line" -`
        echo 'Got' $msg
        curl $api_url -vv -d "from=ServerGameLog&notify=1&color=green&message_format=text" --data-urlencode "message=$msg"
done

