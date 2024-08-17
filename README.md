# 〰️ NvStache - My personal Neovim configuration.

![screenshot](screenshot.png)

# 📦 External Dependencies

### Node

LSP, linting, and formatting features in this config depend on Nodejs. I recommend installing Node via [NVM](https://github.com/nvm-sh/nvm).

I use MacOS and Homebrew. If you're on another system, you will need to follow an alternate method of installation.

```bash
$ brew install nvm
```

Then add the following to your shell profile (most likely `~/.zshrc`):

```bash
  export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
```

Then install the latest version of Node:

```bash
nvm install node
```

Confirm success by running:

```bash
$ node --version
$ npm --version
```

## Fast Search!

#### ripgrep and fd

This config relies on [ripgrep](https://github.com/BurntSushi/ripgrep) (for live-grep) and [fd](https://github.com/sharkdp/fd) (for file searching).
They are cli search utilities that will DRASTICALLY increase performance inside of [telescope](https://github.com/nvim-telescope/telescope.nvim).
Install them both separately:

```bash
brew install ripgrep \ fd
```

#### `make` and `gcc` or `clang`

This config also uses [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim) for enhanced, native-speed fuzzy finding search results.
ripgrep and fd (mentioned above) are great for actually retrieiving the search results, but fzf will greatly speed up the filtering down and ranking of those results so
we see the most relevant results first, and quickly! This plugin is written in C and compiled for best performance. Lazy will actually build this natively for your platform using `make`, hence the dependency.

# 👨‍💻 Setup

### Cloning and Moving Config

The contents of this repo will eventually live in your `~/.config/nvim` directory (or wherever you store your config). I recomend cloning this repo to a desired location and then symlinking it to your `~/.config/nvim` folder. This way you can easily get updates with a simple `git pull`:

```bash
$ cd [your_desired_directory]
$ git clone https://github.com/adamtmorgan/NvStache.git
$ ln -s [your_desired_directory]/NvStache [full_path_to_home]/.config/nvim
```

Alternatively, you can move the repo contents to your `~/.config/nvim` directory, if you don't like linking.

### One-Time Setups

This config uses [vim-doge](https://github.com/kkoomen/vim-doge) for documentation generation in comments. The first time you run Neovim, you'll have to run the following to install it (per the vim-doge README):

Open Neovim and run:
`:call doge#install()`

### LSP, Linting, and Formatting Servers

You shouldn't have to manually install LSP, linting, and formatting thanks to `ensure-installed` in Mason, but just in case, I have listed the Mason dependencies here. You can manually manage these by opening the Mason interface inside of Neovim by running `:Mason`. The following are all supported in this config:

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
  - sqlfluff (sql)
  - tflint (terraform)
- Formatting
  - prettierd (formatting js, css, ts, and many others)
  - stylua (lua formatting)
- Hybrid (lsp/lint/format)
  - rust-analyzer (rust)

If you don't want to use some of these LSPs, you can disable
them by visiting the LSP section of the config found in
`lua/plugins/lsp-config.lua`. Keep in mind that you will need to
disable parts in the Mason, nvim-lspconfig, linting, and formatting
sections of that file.

## ⌨️ Notable Custom Bindings and Features

Keybindings in this config are typically assigned
alongside their plugin counterparts. Other generic bindings
are found in `vim.options.lua`.

Also note that ctag bindings are overwritten in this config.
This is because this config relies on LSPs instead.

- `<leader>` = `space`

- New Tab - `<C-t>n` (normal mode)

- Delete Tab - `<C-t>d` (normal mode)

- Next tab - `<C-t>l` (normal mode)

- Previous tab - `<C-t>h` (normal mode)

- Next buffer - `<leader>l` (normal mode)

- Previous buffer - `<leader>h` (normal mode)

- Delete buffer - `<leader>x` (normal mode)

- Delete all buffers except current - `:Clean` or `<leader>!`

- Clear search - `<leader>/` aka `:noh<CR>` (normal mode)

- Open CWD in [Oil](https://github.com/stevearc/oil.nvim) - `<leader>o`

- Open most recent buffer directory in [Oil](https://github.com/stevearc/oil.nvim) - `<leader>e`

- Find Files (telescope) - `<leader>ff` (normal mode)

- Find Grep (telescope) - `<leader>fg` (normal mode)

- Find Buffer (telescope) - `<leader>fb` (normal mode)

- Delete(remove) hovered buffer - `<C>r` (in telescope Find Buffer results)

- Telescope Next Result - `<C-j>` (in telescope window)

- Telescope Previous Result - `<C-k>` (in telescope window)

- Default commands for Git via [Fugitive](https://github.com/tpope/vim-fugitive)

- Preview `.md` files in browser - `:MarkdownPreview`

- Stop Previewing `.md` files in browser - `:MarkdownPreviewStop`

- Comment line toggle - `gcc` in normal mode. `gc` in visual mode.

- Uses default [flash.nvim](https://github.com/folke/flash.nvim) bindings for quick navigation in view.

- Sessions
  - If a session is saved, it will automatically save current state on Neovim close.
  - Saved sessions are tied to CWD. If a directory is opened and has a saved session, that session will load in automatically.
  - Save session - `<C-s>s`
  - Find session - `<C-s>f`
  - Load session - `<C-s>r`
  - Delete session - `<C-s>d` (when hovering in Find Session window)

## A Note on Workflow

This Neovim config (for better or worse) has been optimized to work with a set of specific tools (notably Tmux and Alacritty, but others as well). To see details on how I've configured other pieces of my workflow, visit my [dotfiles](https://github.com/adamtmorgan/dotfiles) repository where you can see terminal enhancement configs, recommended MacOS apps to boost productivity, among other things.
