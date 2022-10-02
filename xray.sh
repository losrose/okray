#!/bin/sh

# Global variables
ID=80a64f2b-7c9e-4f89-9f5a-6893aa719a29
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
        "decryption": "none",
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
