# Colorspec

Colorspec is a small utility script to keep your color configurations
in a more readable format. See [manual](docs/colorspec.adoc) for more
information.

## Syntax

```
# This is a comment
directory: bright yellow
executable: bold underlined red on green
pipes: bright green on default
*.txt: #FFFFCC underline
```

## Dependencies

Colorspec requires at least Lua 5.1 or LuaJit.
To build documentation, you will need Asciidoctor
(but you can simply read the source: [colorspec.adoc](docs/colorspec.adoc))
