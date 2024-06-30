#!/bin/bash
# get Jlink

cd /usr/lib
JLINK_VERSION="796q"
curl -X POST \
-F "accept_license_agreement=accepted" \
-F "submit=Download software" \
-o JLink_Linux_V"${JLINK_VERSION}"_x86_64.tgz \
https://www.segger.com/downloads/jlink/JLink_Linux_V"${JLINK_VERSION}"_x86_64.tgz

tar xpvzf "JLink_Linux_V${JLINK_VERSION}_x86_64.tgz"

mv JLink_Linux_V${JLINK_VERSION}_x86_64 /usr/lib/JLink