#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
SRC_DIR="$PROJECT_DIR/src"

echo "=== Local Test — Financial Audit Agent ==="
echo ""

# Test calculation logic (no AWS required)
if [[ -f "$SRC_DIR/lambdas/calculation-tools/handler.py" ]]; then
  echo "[1] Running calculation-tools unit checks..."
  python -c "
import sys
sys.path.insert(0, '$SRC_DIR/lambdas/calculation-tools')
# Import after path setup — implement tests in Phase 3
print('  calculation-tools: handler.py found (implement unit tests in Phase 3)')
" 2>/dev/null || echo "  calculation-tools: handler.py not yet implemented"
else
  echo "[1] calculation-tools/handler.py — not yet implemented (Phase 3)"
fi

echo ""
echo "[2] Validating tool JSON schemas..."
TOOLS_DIR="$SRC_DIR/agent/tools"
if [[ -d "$TOOLS_DIR" ]]; then
  for f in "$TOOLS_DIR"/*.json; do
    [[ -f "$f" ]] && python -m json.tool "$f" > /dev/null && echo "  OK: $(basename "$f")"
  done
else
  echo "  Tools directory not found"
fi

echo ""
echo "[3] Checking system prompt..."
PROMPT="$SRC_DIR/agent/prompts/system.md"
if [[ -f "$PROMPT" ]]; then
  echo "  OK: system.md ($(wc -l < "$PROMPT") lines)"
else
  echo "  system.md not found"
fi

echo ""
echo "Local checks complete. For AWS integration tests, see docs/RUNBOOK.md"
