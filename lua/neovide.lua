if vim.g.neovide then
    -- Cursorline has bugs in Neovide
    vim.opt.cursorline = false

    -- Font
    vim.o.guifont = "JetBrainsMono Nerd Font:h12"
    vim.opt.linespace = 0

    -- Window styling
    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 5
    vim.g.neovide_padding_left = 5

    vim.g.neovide_show_border = true
    vim.g.neovide_hide_titlebar = true

    vim.g.neovide_floating_transparency = 1
    vim.g.neovide_window_floating_opacity = 1

    -- Helper function for transparency formatting
    local alpha = function()
        return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
    end
    vim.g.neovide_transparency = 1
    vim.g.transparency = 0.9
    vim.g.neovide_background_color = "#1c2129" .. alpha()
    vim.g.neovide_window_blurred = true

    vim.g.neovide_floating_shadow = false
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 5

    -- Behavior
    vim.g.neovide_hide_mouse_when_typing = 1

    -- Cursor and animation
    vim.g.neovide_cursor_animation_length = 0.08
    vim.g.neovide_cursor_trail_size = 0.6
    vim.g.neovide_scroll_animation_far_lines = 0
    vim.g.neovide_scroll_animation_length = 0.15

    -- Copy/paste in neovide:
    vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
    vim.keymap.set("v", "<D-c>", '"+y') -- Copy
    vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
    vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
    vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
    vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end
