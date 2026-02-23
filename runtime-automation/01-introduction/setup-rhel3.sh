#!/bin/sh

curl -k -O /root/katello-server-ca.crt https://satellite.lab/pub/katello-server-ca.crt
podman run --publish 8080:8080 --volume /root/katello-server-ca.crt:/app/ca.pem:ro,Z   registry.redhat.io/satellite/foreman-mcp-server-rhel9:6.18 --foreman-url https://satellite.lab --no-verify-ssl &
