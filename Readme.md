# Nvim Setup

## Configs

### Local LSP

To enable local, project specific lsps, set the following in .neoconf.json

```json
localLsps: {
    a: {},
    b: {},
    ...
}

localLsps: {
    volar: {}
}

```

### Disable TSServer

For some projects tsserver has to be disabled (volar takeover mode). Use the folllowing in .neoconf.json

```json
"tsserver": { "disable": true },
```
