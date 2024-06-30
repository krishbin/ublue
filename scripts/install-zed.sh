#!/bin/bash
# get zed editor

cd /usr/lib
tag="`jq -r 'map(select(.prerelease)) | first | .tag_name' <<< $(curl --silent https://api.github.com/repos/zed-industries/zed/releases)`"
wget -O- "https://github.com/zed-industries/zed/releases/download/${tag}/zed-linux-x86_64.tar.gz" | tar -zxv
mv zed-preview.app zed

ln -s /usr/lib/zed/bin/zed /usr/bin/zed

cp /usr/lib/zed/share/applications/zed-preview.desktop /usr/share/applications/zed-preview.desktop
sed -i 's/Icon=zed/Icon=\/usr\/lib\/zed\/share\/icons\/hicolor\/1024x1024\/apps\/zed.png/' /usr/share/applications/zed-preview.desktop
echo "StartupWMClass=dev.zed.Zed-Preview" >> /usr/share/applications/zed-preview.desktop