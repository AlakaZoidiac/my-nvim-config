return {
  "L3MON4D3/LuaSnip",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("luasnip.loaders.from_snipmate").load({ paths = "~/AppData/Local/nvim/snippets/snipmate/" })
    require("luasnip.loaders.from_lua").load({ paths = "~/AppData/Local/nvim/snippets/lua/" })
    require("luasnip").config.set_config({ -- Setting LuaSnip config
    -- Enable autotriggered snippets
    enable_autosnippets = true,
    -- Use Tab (or some other key if you prefer) to trigger visual selection
    store_selection_keys = "<Tab>",
    update_events = 'TextChanged,TextChangedI',
    })
  end
}
