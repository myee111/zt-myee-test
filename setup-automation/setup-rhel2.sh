#!/bin/bash

echo "starting setup-rhel2.sh" >> /tmp/setup-scripts/setup-rhel2.log

echo "LITELLM_API_KEY: $LITELLM_API_KEY" >> /tmp/setup-scripts/setup-rhel2.log
echo $LITELLM_API_KEY >> /tmp/LITELLM_API_KEY

#curl -fsSL https://opencode.ai/install | bash

mkdir -p /root/.config/opencode/
cat > /root/.config/opencode/config.json << 'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "litellm": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "LiteLLM",
      "options": {
        "baseURL": "https://litellm-prod.apps.maas.redhatworkshops.io/v1"
      },
      "models": {
        "minimax-m2": {
          "name": "minimax-m2"
        }
      }
    }
  }
}
EOF

mkdir -p /root/.local/share/opencode/
cat > /root/.local/share/opencode/auth.json << EOF
{
  "litellm": {
    "type": "api",
    "key": "$LITELLM_API_KEY"
  }
}
EOF

# cd /tmp
# git clone https://github.com/block/goose.git
# cd goose
# echo "Building Goose..." >> /tmp/runtime-scripts/setup-rhel3.log
# go build -o goose cmd/goose/main.go
# echo "Goose built successfully" >> /tmp/runtime-scripts/setup-rhel3.log

#./goose -api-key /tmp/LITELLM_API_KEY -model gpt-4o-mini -temperature 0.5 -max-tokens 1000 -messages "What is the weather in Tokyo?"


# systemctl stop dnf-automatic-install.timer
# systemctl disable dnf-automatic-install.timer
# systemctl mask dnf-automatic-install.timer