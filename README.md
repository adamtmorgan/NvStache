# 〰️ NvStache - My personal Neovim configuration.

![screenshot](screenshot.jpg)

# 👉 Say When...

NvStache is a my personal Neovim configuration, tailored for speed and workflow with a carefully-curated plugin selection. This acts as my daily
driver for pretty much everything except for debugging and JVM langauges ([Kotlin LSP](https://github.com/Kotlin/kotlin-lsp) is in preview). I tweak this config as new circumstances arise.

## Language Integrations

### Fully supported

- Lua (obviously)
- HTML
- CSS
- JavaScript/TypeScript
- Vue
- Rust
- Python (ty)
- SQL
- GraphQL
- Markdown
- TOML
- YAML
- Protobuf
- Dockerfile/Docker-compose
- GLSL/WGSL
- Bash
- JSON

### Somewhat supported (don't use often)

- C/C++
- PHP
- Nix

## AI Integrations

I did some experimenting with [Avante](https://github.com/yetone/avante.nvim), but ultimately found it cumbersome. Looking into [OpenCode](https://opencode.ai/) in the future but work pays for Cursor, so I've been using that alongside Neovim for the time being.

# 👨‍💻 Setup

### 📦 Dependencies

I use [mise](https://github.com/jdx/mise) for cli dependencies whenever possible.

#### Nodejs

Nodejs must be globally installed for this config to work. This is because Node is required to run some LSPs, linters, formatters, etc. [Mason](https://github.com/mason-org/mason.nvim) manages these automatically, but they still won't run unless Node is available.

#### ripgrep and fd

Do yourself a favor and install [ripgrep](https://github.com/BurntSushi/ripgrep) (for live-grep) and [fd](https://github.com/sharkdp/fd) (for file searching).
They are cli search utilities that will DRASTICALLY increase performance inside of [picker](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md).
[picker](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md) automatically uses `fd` and `rg` if they are installed and available.

#### Git ([Lazygit](https://github.com/jesseduffield/lazygit))

This config utilizes Lazygit as the Git client TUI of choice. [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) (plugin) simply opens a terminal inside of Neovim and opens Lazygit inside of it. For this to work, naturally, you'll need Lazygit installed separately. I highly recommend checking it out if you haven't already.

### 🚚 Cloning and Moving Config

The contents of this repo will eventually live in your `~/.config/nvim` directory (or wherever you store your config). I recomend cloning this repo to a desired location and then symlinking it to your `~/.config/nvim` folder. This way you can easily get updates with a simple `git pull`:

```bash
$ cd [your_desired_directory]
$ git clone https://github.com/adamtmorgan/NvStache.git
$ ln -s [your_desired_directory]/NvStache [full_path_to_home]/.config/nvim
```

Alternatively, you can move the repo contents to your `~/.config/nvim` directory, if you don't like linking.

## LSP, Linting, and Formatting Servers

You shouldn't have to manually install LSP, linting, and formatting, as the `lsp-config.lua` file checks for a list of Mason registers on Neovim startup and installs them automatically. If you wish omit a language server,
modify the `ensure_installed` table in `lsp-config.lua`.

## ⌨️ Notable Custom Bindings and Features

Keybindings in this config are typically assigned
alongside their plugin counterparts. Other generic bindings
are found in `vim.options.lua`.

Also note that ctag bindings are overwritten in this config.
This is because this config relies on LSPs instead.

- `<leader>` = `space`

- ESC key alternative is `<C-;>` for homerow escaping

- New Tab - `<C-t>n` (normal mode)

- Delete Tab - `<C-t>d` (normal mode)

- Next tab - `<C-t>l` (normal mode)

- Previous tab - `<C-t>h` (normal mode)

- Next buffer - `<leader>l` (normal mode)

- Previous buffer - `<leader>h` (normal mode)

- Delete buffer - `<leader>D` (normal mode)

- Delete buffer and switch to last (preserves window/pane layout) - `<leader>C` (normal mode)

- Delete all buffers except current - `:Clean` or `<leader>!`

- Clear search - `<C-/>` aka `:noh<CR>` (normal mode)

- Open [Snacks Picker/Explorer](https://github.com/folke/snacks.nvim/blob/main/docs/explorer.md) - `<leader>o`

- Open most recent buffer directory in [Oil](https://github.com/stevearc/oil.nvim) - `<leader>O`

- Open CWD in [Oil](https://github.com/stevearc/oil.nvim) - `<leader>e`

- Discard changes in [Oil](https://github.com/stevearc/oil.nvim) - `<C-x>`

- Find Files - `<leader>f` (normal mode)

- Live Grep - `<leader>/` (normal mode)

- Live Grep Word - `<leader>w` (normal mode)

- Live Grep Directory - `<leader>?` (normal mode)

- Find Buffer - `<leader>b` (normal mode)

- Delete(remove) hovered buffer - `<C>x` (in Find Buffer results)

- Generate signature docs for hovered function - `<leader>g`

- [Lazygit](https://github.com/jesseduffield/lazygit) (Git client) - `<leader>1`

- [Lazydocker](https://github.com/jesseduffield/lazydocker) (Docker client) - `<leader>2`

- [jk9s](https://github.com/derailed/k9s) (Kubernetes client) - `<leader>3`

- Preview `.md` files in browser - `:MarkdownPreview`

- Stop Previewing `.md` files in browser - `:MarkdownPreviewStop`

- Comment line toggle - `gcc` in normal mode. `gc` in visual mode.

- Uses default [flash.nvim](https://github.com/folke/flash.nvim) bindings for quick navigation in view.

- Open marked files using [Arrow](https://github.com/otavioschwanck/arrow.nvim) - `;` - close with `q`

- Open marks in current buffer using [Arrow](https://github.com/otavioschwanck/arrow.nvim) - `m` - close with `q`

- Sessions
  - Sessions are automatically saved and restored based on opened CWD and active git branch. They are automatically deleted if older than 30 days.
  - Saved sessions are tied to CWD. If a directory is opened and has a saved session, that session will load in automatically.
  - Save session - `<C-s>s`
  - Find session - `<C-s>f`
  - Restore session - `<C-s>r`
  - Delete session - `<C-x>` (when hovering in session picker)

## ⚡Neovide Support

If you like speed and flashy animations, check out [Neovide](https://neovide.dev/).
I recommend adding a function to your `.zshrc` file to get the best look without having to type `--frame transparent` every time you want to open.

```bash[.zshrc]
nvide() {
  if [ -z "$1" ]
  then
    neovide --frame transparent
  else
    neovide "$1" --frame transparent
  fi
}
```

With this, you should now be able to run `nvide` or `nvide my/file.lua` and you will have the window formatting that best suits MacOS.

## A Note on Workflow

This Neovim config (for better or worse) has been optimized to work with a set of specific tools, and complimentary configs for
said tools. For example, nvim has no background color unless in Neovide, yielding said background to your terminal's so transparency effects can work.
To see details on how I've configured other pieces of my workflow, visit my [dotfiles](https://github.com/adamtmorgan/dotfiles) repository where you
can see terminal enhancement configs, recommended MacOS apps to boost productivity, among other things.
