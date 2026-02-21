#!/bin/bash
export HOME="${HOME:-$(eval echo ~)}"
export GOOGLE_OAUTH_CREDENTIALS="$HOME/.config/mcp/gcp-oauth.keys.json"
exec npx -y @cocal/google-calendar-mcp
