#!/bin/sh
set -eu

mkdir -p /tmp/sshd
chmod 700 /tmp/sshd

if [ ! -f /tmp/sshd/ssh_host_ed25519_key ]; then
    ssh-keygen -q -t ed25519 \
        -N "" \
        -f /tmp/sshd/ssh_host_ed25519_key
fi

if [ ! -f /tmp/sshd/ssh_host_rsa_key ]; then
    ssh-keygen -q -t rsa \
        -b 3072 \
        -N "" \
        -f /tmp/sshd/ssh_host_rsa_key
fi

chmod 600 /tmp/sshd/ssh_host_*_key
chmod 644 /tmp/sshd/ssh_host_*.pub

exec /usr/sbin/sshd \
    -D \
    -e \
    -f /opt/sshd/sshd_config
