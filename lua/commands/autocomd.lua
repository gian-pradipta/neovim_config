local get_curr_listed_buff = require("utils.buffer").get_curr_listed_buff
local get_buffs = require("utils.buffer").get_buffs
local index_of = require("utils.table").indexOf

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
        local currbuf = get_curr_listed_buff()
        local listed_buffs = get_buffs()
        if (index_of(listed_buffs, currbuf) == -1) then
            return
        end

        local currbuf_i = index_of(_G.BUFFER_ARRAY, currbuf)
        if (currbuf_i == -1) then
            table.insert(_G.BUFFER_ARRAY, 1, currbuf)
        else
            _G.BUFFER_ARRAY[1], _G.BUFFER_ARRAY[currbuf_i] =  _G.BUFFER_ARRAY[currbuf_i], _G.BUFFER_ARRAY[1]
        end

  end,
})

