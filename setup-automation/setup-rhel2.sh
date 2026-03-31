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
