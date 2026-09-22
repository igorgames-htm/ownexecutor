local fixed = {}

local function findit(name)
    return getgenv()[name] or (syn and syn[name])
end

local loadfn = findit("loadstring") or findit("load")

assert(loadfn, "No loadstring/load available")

local modules = {
    "files.luau",
    "misc.luau"
}

for _, name in modules do
    local url = "https://raw.githubusercontent.com/igorgames-htm/ownexecutor/main/modules/" .. name

    local source = game:HttpGet(url)
    assert(type(source) == "string", "HttpGet did not return source for " .. name)

    local chunk = loadfn(source)
    assert(chunk, "Failed to compile " .. name)

    local result = chunk()
    assert(type(result) == "table", name .. " did not return a table")

    for k, v in result do
        fixed[k] = v
    end
end

return fixed
