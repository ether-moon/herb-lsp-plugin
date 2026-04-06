# herb-lsp-plugin

Claude Code plugin that provides herb-language-server LSP support for `.erb`, `.herb`, and `.html.erb` files.

## Key Files

- `plugins/herb-lsp-plugin/.claude-plugin/plugin.json` — Plugin manifest. `lspServers` field points to `.lsp.json`.
- `plugins/herb-lsp-plugin/.lsp.json` — LSP server configuration (command, args, file extension mapping).

## Development

- Prerequisite: `npm install -g @herb-tools/language-server`
- Run `bash tests/all.sh` to validate plugin structure.
