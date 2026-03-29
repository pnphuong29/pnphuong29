#!/usr/bin/env bash

set -euo pipefail

if [ -n "${AP_MERMAID_VALIDATOR_SCRIPT:-}" ]; then
  exec "${AP_MERMAID_VALIDATOR_SCRIPT}" "$@"
fi

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [ -z "${repo_root}" ]; then
  repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi

shared_script="${repo_root%/*}/ap-scripto-core-sc108/scripts/ap_validate_mermaid_markdown.sh"

if [ ! -x "${shared_script}" ]; then
  echo "ERROR: shared Mermaid validator not found at [${shared_script}]" >&2
  echo "Set AP_MERMAID_VALIDATOR_SCRIPT to override this location." >&2
  exit 1
fi

exec "${shared_script}" "$@"
