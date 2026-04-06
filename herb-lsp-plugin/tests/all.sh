#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0
FAIL=0

pass() { PASS=$((PASS + 1)); echo "  PASS: $1"; }
fail() { FAIL=$((FAIL + 1)); echo "  FAIL: $1" >&2; }

echo "=== Plugin Structure Tests ==="

# ── marketplace.json ─────────────────────────────────────────────────
if [ -f "$ROOT/.claude-plugin/marketplace.json" ]; then
  if python3 -c "import json; json.load(open('$ROOT/.claude-plugin/marketplace.json'))" 2>/dev/null; then
    pass "marketplace.json is valid JSON"
  else
    fail "marketplace.json is invalid JSON"
  fi
else
  fail "marketplace.json not found"
fi

# ── plugin.json ──────────────────────────────────────────────────────
PLUGIN_JSON=$(find "$ROOT/plugins" -name "plugin.json" -path "*/.claude-plugin/*" 2>/dev/null | head -1)
if [ -n "$PLUGIN_JSON" ]; then
  if python3 -c "import json; d=json.load(open('$PLUGIN_JSON')); assert 'name' in d; assert 'version' in d" 2>/dev/null; then
    pass "plugin.json has name and version"
  else
    fail "plugin.json missing required fields"
  fi

  if python3 -c "import json; d=json.load(open('$PLUGIN_JSON')); assert 'lspServers' in d" 2>/dev/null; then
    pass "plugin.json has lspServers field"
  else
    fail "plugin.json missing lspServers field"
  fi
else
  fail "plugin.json not found under plugins/"
fi

# ── .lsp.json ────────────────────────────────────────────────────────
LSP_JSON=$(find "$ROOT/plugins" -name ".lsp.json" 2>/dev/null | head -1)
if [ -n "$LSP_JSON" ]; then
  if python3 -c "import json; json.load(open('$LSP_JSON'))" 2>/dev/null; then
    pass ".lsp.json is valid JSON"
  else
    fail ".lsp.json is invalid JSON"
  fi

  if python3 -c "
import json
d = json.load(open('$LSP_JSON'))
for name, cfg in d.items():
    assert 'command' in cfg, f'{name}: missing command'
    assert 'args' in cfg, f'{name}: missing args'
    assert 'extensionToLanguage' in cfg, f'{name}: missing extensionToLanguage'
" 2>/dev/null; then
    pass ".lsp.json has required fields (command, args, extensionToLanguage)"
  else
    fail ".lsp.json missing required fields"
  fi
else
  fail ".lsp.json not found"
fi

# ── Summary ──────────────────────────────────────────────────────────
echo ""
echo "Results: ${PASS} passed, ${FAIL} failed"
[ "$FAIL" -eq 0 ] || exit 1
