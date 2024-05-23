# NvAdam - My personal Neovim configuration.

## Setup

First, make sure that the contents of this repo are stored in your home directory. On MacOS, this is in `~/.config/nvim`.

LSP, linting, and formatting must be installed separately via Mason. Do this by opening the Mason interface inside of Neovim by running `:Mason`. Follow the steps to install the following dependencies to support this config:

- LSP
  - bash-language-server (bash)
  - css-lsp (css)
  - docker-compose-language-service (docker-compose)
  - dockerfile-language-server (dockerfile)
  - html-lsp (html)
  - json-lsp (json)
  - lua-language-server (lua)
  - pyright (python)
  - sqlls (sql)
  - tailwindcss-language-server (tailwind.css)
  - taplo (toml)
  - typescript-language-server (typescript)
  - vetur-vls (vue.js)
- Linting
  - eslint_d (javascript)
  - htmlhint (html)
  - sqlfluff (sql)
  - stylelint (css)
  - tflint (terraform)
- Formatting
  - ktlint (kotlin formatting)
  - prettierd
  - stylua
- Hybrid (lsp/lint/format)
  - rust-analyzer (rust)
  - ktlint (kotlin linting)

If you don't want to use some of these LSPs, you can disable
them by visiting the LSP section of the config found in
`lua/plugins/lsp-config.lua`. Keep in mind that you will need to
disable parts in the Mason, nvim-lspconfig, linting, and formatting
sections of that file.

## Notable Custom Bindings and Features

Keybindings in this config are typically assigned
alongside their plugin counterparts. Other generic bindings
are found in `vim.options.lua`.

- Clear search - `<leader>/` aka `:noh<CR>`

- Toggle neo-tree - `<C>b`

- Find Files (telescope) - `<leader>ff`

- Find Grep (telescope) - `<leader>fg`

- Find Buffer (telescope) - `<leader>fb`

- Delete(remove) hovered buffer (in telescope Find Buffer results) - `<C>r`

- Telescope Next Result - `<C>j`

- Telescope Previous Result - `<C>k`

- Preview `.md` files in browser - `:MarkdownPreview`

- Stop Previewing `.md` files in browser - `:MarkdownPreviewStop`

## Terminal Recommendations

I personally use Alacritty on Mac with the following config:

````toml
[font]
# I use JetBrainsMono Nerd Font. Alacritty renders things quite
# thin without font smoothing, so I prefer to beef things up by
# using the bold version with font smoothing disabled.
# After experimenting, I've found this is the best balance.
normal = { family = "JetBrainsMono Nerd Font", style = "Bold" }
bold = { family = "JetBrainsMono Nerd Font", style = "ExtraBold" }
italic = { family = "JetBrainsMono Nerd Font", style = "Bold Italic" }
bold_italic = { family = "JetBrainsMono Nerd Font", style = "ExtraBold Italic" }
size = 12
offset = { x = 0, y = 0 }

# If font looks blurry in MacOS, font smoothing can be disabled by
# running the following:
# ```
# defaults write org.alacritty AppleFontSmoothing -int 0
# ```
#
# To re-enable, run the following:
# ```
# defaults delete org.alacritty AppleFontSmoothing
# ```

[mouse]
hide_when_typing = true

[terminal]
osc52 = "CopyPaste"

[[keyboard.bindings]]
chars = "\f"
key = "K"
mode = "~Vi|~Search"
mods = "Command"

[[keyboard.bindings]]
action = "ClearHistory"
key = "K"
mode = "~Vi|~Search"
mods = "Command"

[[keyboard.bindings]]
action = "ResetFontSize"
key = "Key0"
mods = "Command"

[[keyboard.bindings]]
action = "IncreaseFontSize"
key = "Equals"
mods = "Command"

[[keyboard.bindings]]
action = "IncreaseFontSize"
key = "Plus"
mods = "Command"

[[keyboard.bindings]]
action = "IncreaseFontSize"
key = "NumpadAdd"
mods = "Command"

[[keyboard.bindings]]
action = "DecreaseFontSize"
key = "Minus"
mods = "Command"

[[keyboard.bindings]]
action = "DecreaseFontSize"
key = "NumpadSubtract"
mods = "Command"

[[keyboard.bindings]]
action = "Paste"
key = "V"
mods = "Command"

[[keyboard.bindings]]
action = "Copy"
key = "C"
mods = "Command"

[[keyboard.bindings]]
action = "ClearSelection"
key = "C"
mode = "Vi|~Search"
mods = "Command"

[[keyboard.bindings]]
action = "Hide"
key = "H"
mods = "Command"

[[keyboard.bindings]]
action = "HideOtherApplications"
key = "H"
mods = "Command|Alt"

[[keyboard.bindings]]
action = "Minimize"
key = "M"
mods = "Command"

[[keyboard.bindings]]
action = "Quit"
key = "Q"
mods = "Command"

[[keyboard.bindings]]
action = "Quit"
key = "W"
mods = "Command"

[[keyboard.bindings]]
action = "CreateNewWindow"
key = "N"
mods = "Command"

[[keyboard.bindings]]
action = "CreateNewTab"
key = "T"
mods = "Command"

[[keyboard.bindings]]
action = "ToggleFullscreen"
key = "F"
mods = "Command|Control"

[[keyboard.bindings]]
action = "SearchForward"
key = "F"
mode = "~Search"
mods = "Command"

[[keyboard.bindings]]
action = "SearchBackward"
key = "B"
mode = "~Search"
mods = "Command"

[window]
decorations = "Buttonless"
opacity = 0.94
blur = true
dimensions = { columns = 230, lines = 64 }
dynamic_padding = true

[colors.primary]
background = "#1c2129"

[window.padding]
x = 11
y = 11
````
