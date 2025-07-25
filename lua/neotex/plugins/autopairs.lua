return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    -- import nvim-autopairs
    local autopairs = require("nvim-autopairs")

    -- configure autopairs
    autopairs.setup({
      check_ts = true,                      -- enable treesitter
      ts_config = {
        lua = { "string" },                 -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
        -- javascript = { "string", "template_string" },
        java = false,                       -- don't check treesitter on java
        lean = false,                        -- enable treesitter for lean
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      disable_in_macro = true,
      disable_in_replace_mode = true,
      enable_moveright = true,
      ignored_next_char = "",
      enable_check_bracket_line = true, --- check bracket in same line
    })

    local Rule = require 'nvim-autopairs.rule'

    local cond = require 'nvim-autopairs.conds'

    -- local function not_in_mathzone()
    --   return vim.fn["vimtex#syntax#in_mathzone"]() ~= 1
    -- end


    autopairs.remove_rule("[", "tex")

    autopairs.add_rules({
      Rule("`", "'", "tex"),
      Rule("$", "$", "tex"),
      Rule("[", "]", "tex")
          :with_pair(function(opts)
            local prev_char = opts.line:sub(opts.col - 1, opts.col - 1)
            return not prev_char:match("[a-zA-Z0-9%)%]%}]")
          end),
      -- Rule("[", "]", "tex")
      --   :with_pair(function()
      --     return vim.fn["vimtex#syntax#in_mathzone"]() ~= 1
      --   end),
      -- Rule("[", "]", "tex"):with_pair(not_in_mathzone),
      Rule(' ', ' ')
          :with_pair(function(opts)
            local pair = opts.line:sub(opts.col, opts.col + 1)
            return vim.tbl_contains({ '$$', '()', '{}', '[]', '<>' }, pair)
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({ '$  $', '(  )', '{  }', '[  ]', '<  >' }, context)
          end),
      Rule("$ ", " ", "tex")
          :with_pair(cond.not_after_regex(" "))
          :with_del(cond.none()),
      Rule("[ ", " ", "tex")
          :with_pair(cond.not_after_regex(" "))
          :with_del(cond.none()),
      Rule("{ ", " ", "tex")
          :with_pair(cond.not_after_regex(" "))
          :with_del(cond.none()),
      Rule("( ", " ", "tex")
          :with_pair(cond.not_after_regex(" "))
          :with_del(cond.none()),
      Rule("< ", " ", "tex")
          :with_pair(cond.not_after_regex(" "))
          :with_del(cond.none()),
    })

    autopairs.get_rule('$'):with_move(function(opts)
      return opts.char == opts.next_char:sub(1, 1)
    end)

    -- import nvim-cmp plugin (completions plugin)
    local cmp = require("cmp")

    -- import nvim-autopairs completion functionality
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- make autopairs and completion work together
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done({
        filetypes = {
          tex = false, -- Disable for tex
          lean = true  -- Enable for lean
        }
      })
    )
  end,
}
