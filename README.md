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
  - prettierd (formatting js, css, ts, and many others)
  - stylua (lua formatting)
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

Also note that ctag bindings are overwritten in this config.
This is because this config relies on LSPs instead.

- New Tab - `<C-t>n` (normal mode)

- Delete Tab - `<C-t>d` (normal mode)

- Next tab - `<C-]>` (normal mode)

- Previous tab - `<C-[>` (normal mode)

- Clear search - `<leader>/` aka `:noh<CR>` (normal mode)

- Toggle neo-tree - `<C-b>` (normal mode)

- Find Files (telescope) - `<leader>ff` (normal mode)

- Find Grep (telescope) - `<leader>fg` (normal mode)

- Find Buffer (telescope) - `<leader>fb` (normal mode)

- Delete(remove) hovered buffer - `<C>r` (in telescope Find Buffer results)

- Telescope Next Result - `<C-j>` (in telescope window)

- Telescope Previous Result - `<C-k>` (in telescope window)

- Git Blake Toggle - `:BlameToggle`

- Preview `.md` files in browser - `:MarkdownPreview`

- Stop Previewing `.md` files in browser - `:MarkdownPreviewStop`

## A Note on Workflow

This Neovim config (for better or worse) has been optimized to work with a set of specific tools (notably Tmux and Alacritty, but others as well). To see details on how I've configured other pieces of my workflow, visit my [dotfiles](https://github.com/adamtmorgan/dotfiles) repository where you can see terminal enhancement configs, recommended MacOS apps to boost productivity, among other things.
