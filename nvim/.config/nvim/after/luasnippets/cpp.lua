local ls = require('luasnip')
local t = ls.text_node
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local f = ls.function_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt -- format

local get_test_case_method_node = function(position, node_references)
    return d(position, function(args)
        if args ~= nil and args[1][1] ~= nil and args[1][1] ~= '' then
            return sn(nil, fmt(
                [[


                void test_case() {{
                    {}
                }}

                ]], {
                    i(1)
                }))
        end

        return sn(nil, t(""))
    end, node_references)
end

return {
    s(
        "cpsnip",
        fmt([[
        #include <algorithm>
        #include <array>
        #include <bitset>
        #include <cassert>
        #include <chrono>
        #include <climits>
        #include <cmath>
        #include <complex>
        #include <cstring>
        #include <functional>
        #include <iomanip>
        #include <iostream>
        #include <map>
        #include <numeric>
        #include <queue>
        #include <random>
        #include <set>
        #include <vector>
        using namespace std;
        {f_node_test_case}
        int main() {{
            {c_node_test_cases}
        }}
        ]], {
            c_node_test_cases = c(1, {
                sn(nil, fmt(
                    [[
                        int {} = 0;
                            cin >> {};
                            while ({}--) {{
                                test_case();
                            }}
                        ]], {
                        i(1, "t"),
                        rep(1),
                        rep(1)
                    }
                )),
                t("")
            }),
            f_node_test_case = get_test_case_method_node(2, { 1 })
        })
    )
}
