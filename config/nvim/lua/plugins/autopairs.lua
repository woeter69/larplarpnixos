-- ~/.config/nvim/lua/plugins/autopairs.lua
local npairs = require('nvim-autopairs')
npairs.setup({
  check_ts = true,  -- enable Treesitter integration
})

-- HTML tag auto-closing
local Rule = require('nvim-autopairs.rule')
local ts_conds = require('nvim-autopairs.ts-conds')

npairs.add_rules {
  Rule('<', '>', 'html')
    :with_pair(ts_conds.is_ts_node({'tag_name'}, 'html'))
    :with_move(function(opts)
        return opts.prev_char:match('.%>') ~= nil
    end)
    :use_key('>')
}


