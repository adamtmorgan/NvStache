# NvAdam - My personal NeoVim configuration.

## Setup

First, make sure that the contents of this repo are stored in your home directory. On MacOS, this is in `~/.config/nvim`.

LSP, linting, and formatting must be installed separately via Mason. Do this by opening the Mason interface inside of NeoVim by running `:Mason`. Follow the steps to install the following dependencies to support this config:

- LSP
  - bash-language-server
  - css-lsp
  - docker-compose-language-service
  - dockerfile-language-server
  - html-lsp
  - json-lsp
  - lua-language-server
  - rust-analyzer
  - sqlls
  - tailwindcss-language-server
  - taplo
  - flint
  - typescript-language-server
  - vetur-vls
- Linting
  - eslint_d
  - htmlhint
  - ktlint
  - sqlfluff
  - stylelint
  - tflint
- Formatting
  - ktlint
  - prettierd
  - stylua

## Usage Recommendations

I personally use iTerm on Mac with the following settings:

- Appearance > Panes
  - Side Margins: 14
  - Top & Bottom Margins: 12
- Profiles > Window
  - Transparency: 4
  - Blur: 64
  - Use Transparency: true
- Profiles > Text
  - Cursor: Box
  - Font Family: JetBrainsMono Nerd Font Medium
  - Font Size: 11
  - Vertical Spacing: 100
  - Horizontal Spacing: 105
  - Use ligatures: true
- Profiles > Colors
  - Background: #1c2129
  - Foreground: #dddddd
  - Selection: #c1ddff
  - Cursor: #c7c7c7
  - Cursor Text: #fffeff
