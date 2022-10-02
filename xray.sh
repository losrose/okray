#!/bin/sh

# Global variables
ID=8f1f7140-1e88-413a-ab34-f2cc94e9e049
PORT=80

# config xray
cat << EOF > /etc/config.json
{
  "inbounds":[
    {
      "port": $PORT,
      "protocol": "vless",
      "settings": {
        "decryption": "none",
        "clients": [
          {
            "id": "$ID"
          }
        ]
      },
      "streamSettings": {
        "network": "ws"
      }
    },
    {
      "port": $PORT,
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "$ID"
          }
        ]
      },
      "streamSettings": {
        "network": "ws"
      }
    }	
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}	
EOF

# run xray
/usr/bin/xray run -config /etc/config.json
