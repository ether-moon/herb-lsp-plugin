# AGENTS.md

herb-lsp-plugin — Claude Code plugin for herb-language-server LSP support.

## Plugin Structure

- `plugins/herb-lsp-plugin/.claude-plugin/plugin.json` — Plugin metadata and `lspServers` reference
- `plugins/herb-lsp-plugin/.lsp.json` — LSP server configuration (command, args, extension-to-language mapping)

## LSP Configuration

The `.lsp.json` file defines the LSP server entry. Each key is a server name with:

| Field | Description |
|---|---|
| `command` | Executable to launch (`herb-language-server`) |
| `args` | CLI arguments (`["--stdio"]`) |
| `extensionToLanguage` | Maps file extensions to language IDs |

## Testing

```bash
bash tests/all.sh
```
