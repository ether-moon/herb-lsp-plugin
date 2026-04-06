# herb-lsp-plugin

[herb-language-server](https://github.com/marcoroth/herb) support for Claude Code. Provides LSP features (diagnostics, completions, hover, go-to-definition, etc.) for `.erb`, `.herb`, and `.html.erb` files.

## Prerequisites

Install `herb-language-server`:

```bash
npm install -g @herb-tools/language-server
```

## Installation

Add to your `~/.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "herb-lsp-plugin": {
      "source": {
        "source": "github",
        "repo": "ether-moon/herb-lsp-plugin"
      }
    }
  },
  "enabledPlugins": {
    "herb-lsp-plugin@herb-lsp-plugin": true
  }
}
```

## Supported File Types

| Extension | Language ID |
|---|---|
| `.erb` | `erb` |
| `.herb` | `herb` |
| `.html.erb` | `erb` |

## How It Works

This plugin registers `herb-language-server` as an LSP server via Claude Code's plugin system. Once installed, Claude Code automatically starts the server when you open a project containing `.erb` or `.herb` files.

### Plugin Structure

```
plugins/herb-lsp-plugin/
├── .claude-plugin/
│   └── plugin.json       # Plugin metadata with lspServers reference
└── .lsp.json             # LSP server configuration
```

### LSP Configuration

```json
{
  "herb": {
    "command": "herb-language-server",
    "args": ["--stdio"],
    "extensionToLanguage": {
      ".erb": "erb",
      ".herb": "herb",
      ".html.erb": "erb"
    }
  }
}
```

## License

MIT
