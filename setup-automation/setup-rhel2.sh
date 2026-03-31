#!/bin/bash

echo "starting setup-rhel2.sh" >> /tmp/setup-scripts/setup-rhel2.log

# Log that LITELLM_API_KEY was present (value included—sensitive) for setup debugging.
# Persist the API key to a tmp file for downstream use on this host.
echo "LITELLM_API_KEY: $LITELLM_API_KEY" >> /tmp/setup-scripts/setup-rhel2.log
echo $LITELLM_API_KEY >> /tmp/LITELLM_API_KEY

# Persist OpenCode LiteLLM configuration: write config.json with the Litellm provider configuration (heredoc unquoted so the variable is substituted).
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

# Persist OpenCode LiteLLM API credentials: write auth.json with the LITELLM_API_KEY from the environment (heredoc unquoted so the variable is substituted).
mkdir -p /root/.local/share/opencode/
cat > /root/.local/share/opencode/auth.json << EOF
{
  "litellm": {
    "type": "api",
    "key": "$LITELLM_API_KEY"
  }
}
EOF

# SSH to Satellite, create admin Hammer access token for MCP, write token to /root/SATELLITE_PERSONAL_ACCESS_TOKEN.
ssh satellite.lab 'hammer user access-token create --user=admin --name="mcp server"' > /root/SATELLITE_PERSONAL_ACCESS_TOKEN

