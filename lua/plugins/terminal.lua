return {
    "akinsho/toggleterm.nvim",
    version = "*",
    ops = {
        shade_terminals = false,
        persist_size = false,
    },
    config = function()
        local Terminal = require("toggleterm.terminal").Terminal
        vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

        local function new_float_term(cmd)
            return Terminal:new({
                cmd = cmd,
                hidden = true,
                direction = "float",
                float_opts = {
                    border = "rounded",
                    width = function()
                        return math.floor(vim.o.columns * 0.9)
                    end,
                    height = function()
                        return math.floor(vim.o.lines * 0.9)
                    end,
                    title_pos = "center",
                },
                highlights = {
                    NormalFloat = { guifg = "#DDD8BB" },
                },
                shade_terminals = false,
                shading_factor = 0,
                shading_ratio = 0,
                persist_size = false,
                close_on_exit = true,
            })
        end

        -- --------------------------------------------------
        -- Lazygit
        -- --------------------------------------------------
        local lazygit = new_float_term("lazygit")
        function Lazygit_toggle()
            lazygit:toggle()
        end
        vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua Lazygit_toggle()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>1", "<cmd>lua Lazygit_toggle()<CR>", { noremap = true, silent = true })

        -- --------------------------------------------------
        -- Lazydocker
        -- --------------------------------------------------
        local lazydocker = new_float_term("lazydocker")
        function Lazydocker_toggle()
            lazydocker:toggle()
        end
        vim.api.nvim_set_keymap("n", "<leader>2", "<cmd>lua Lazydocker_toggle()<CR>", { noremap = true, silent = true })

        -- --------------------------------------------------
        -- k9s
        -- --------------------------------------------------
        local k9s = new_float_term("k9s")
        function K9s_toggle()
            k9s:toggle()
        end
        vim.api.nvim_set_keymap("n", "<leader>3", "<cmd>lua K9s_toggle()<CR>", { noremap = true, silent = true })
    end,
}
