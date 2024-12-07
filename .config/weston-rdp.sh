#!/bin/bash

# Generate two pem file with below:
#openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout key.pem -out cert.pem -days 3650

#weston --no-config --backend=rdp-backend.so --width=1920 --height=1080 --address=0.0.0.0 --port=3389 --rdp-tls-cert=/home/master/.config/tls/cert.pem --rdp-tls-key=/home/master/.config/tls/key.pem
weston --backend=rdp-backend.so --width=1920 --height=1080 --address=0.0.0.0 --port=3389 --rdp-tls-cert=/home/master/.config/tls/cert.pem --rdp-tls-key=/home/master/.config/tls/key.pem

