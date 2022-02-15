-- https://stackoverflow.com/a/32389020

local OR, XOR, AND = 1, 3, 4

return setmetatable({
  OR = OR,
  XOR = XOR,
  AND = AND,
}, {
  __call = function(self, a, b, oper)
    local r, m, s = 0, 2 ^ 31, nil
    repeat
      s, a, b = a + b + m, a % m, b % m
      r, m = r + m * oper % (s - a - b), m / 2
    until m / 1
    return r
  end,
})
