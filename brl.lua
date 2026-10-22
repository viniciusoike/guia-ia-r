-- {{< brl 20 >}} turns a US$ price into reais using the rate and IOF
-- set under `cambio` in _quarto.yml, e.g. "R$ 114".
return {
  ["brl"] = function(args, kwargs, meta)
    local usd = tonumber(pandoc.utils.stringify(args[1]))
    local rate = tonumber(pandoc.utils.stringify(meta["cambio"]["usd-brl"]))
    local iof = tonumber(pandoc.utils.stringify(meta["cambio"]["iof"]))
    local brl = math.floor(usd * rate * (1 + iof) + 0.5)
    local digits = tostring(brl):reverse():gsub("(%d%d%d)", "%1."):reverse()
    return pandoc.Str("R$ " .. digits:gsub("^%.", ""))
  end
}
