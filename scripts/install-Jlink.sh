#!/bin/bash
# get Jlink

cd /usr/lib

curl -X POST \
-F "accept_license_agreement=accepted" \
-F "submit=Download software" \
-o /tmp/JLink_Linux_V"${JLINK_VERSION}"_x86_64.tgz \
https://www.segger.com/downloads/jlink/JLink_Linux_V"${JLINK_VERSION}"_x86_64.tgz

tar xpvzf "/tmp/JLink_Linux_V${JLINK_VERSION}_x86_64.tgz"

mv /tmp/JLink_Linux_V${JLINK_VERSION}_x86_64 /usr/lib/Jlink