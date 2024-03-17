#!/bin/sh

apt-get update && apt-get install -y --no-install-recommends \
    curl gpg ca-certificates

keyring_url='https://liquorix.net/liquorix-keyring.gpg'
keyring_path='/etc/apt/keyrings/liquorix-keyring.gpg'
curl "$keyring_url" | gpg --batch --yes --output "$keyring_path" --dearmor
chmod 0644 "$keyring_path"

apt-get install apt-transport-https -y

repo_file="/etc/apt/sources.list.d/liquorix.list"
repo_code="testing"
repo_line="[arch=amd64 signed-by=$keyring_path] https://liquorix.net/debian $repo_code main"
echo "deb $repo_line"      > $repo_file
echo "deb-src $repo_line" >> $repo_file

apt-get update -y

apt-get install -y linux-image-liquorix-amd64 linux-headers-liquorix-amd64
