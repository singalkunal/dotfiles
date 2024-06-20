local ls = require('luasnip')
local t = ls.text_node
local s = ls.snippet
local i = ls.insert_node

return {
    s("ternary", {
        -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
        i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
    })
}
