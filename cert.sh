#!/usr/bin/env bash

BASE_DOMAIN="olaindex.com"
DAYS=3650
PASSPHRASE=""
CONFIG_FILE="config.txt"

cat > $CONFIG_FILE <<-EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn

[dn]
C = US
ST = NY
L = NY
O = OLAINDEX Corp
OU = Dev
emailAddress = webmaster@$BASE_DOMAIN
CN = $BASE_DOMAIN
EOF

FILE_NAME="$BASE_DOMAIN"
echo "Generating certs for $BASE_DOMAIN"
openssl req -new -x509 -newkey rsa:2048 -sha256 -nodes -keyout "$FILE_NAME.key" -days $DAYS -out "$FILE_NAME.crt" -passin pass:$PASSPHRASE -config "$CONFIG_FILE"
chmod 400 "$FILE_NAME.key"