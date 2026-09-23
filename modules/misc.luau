local libmisc = {}

function findit(name)
  return getgenv()[name] or (syn and syn[name])
end

libmisc.gethui = function()
  local hui = findit("gethui")
  if not hui then
    return game:GetService("CoreGui"):FindFirstChild("RobloxGui")
  else
    return hui()
  end
end
libmisc.base64decode = function(data)
    data = data:gsub("[^" .. BASE64_CHARS .. "=]", "")

    return (data:gsub(".", function(x)
        if x == "=" then
            return ""
        end

        local f = BASE64_CHARS:find(x, 1, true) - 1
        local bits = ""

        for i = 6, 1, -1 do
            bits = bits .. ((f % 2^i - f % 2^(i-1) > 0) and "1" or "0")
        end

        return bits
    end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(bits)
        if #bits ~= 8 then
            return ""
        end

        local c = 0
        for i = 1, 8 do
            if bits:sub(i, i) == "1" then
                c = c + 2^(8 - i)
            end
        end

        return string.char(c)
    end))
end
libmisc.base64encode = function(data)
    return ((data:gsub(".", function(x)
        local byte = x:byte()
        local bits = ""

        for i = 8, 1, -1 do
            bits = bits .. ((byte % 2^i - byte % 2^(i - 1) > 0) and "1" or "0")
        end

        return bits
    end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(bits)
        if #bits < 6 then
            return ""
        end

        local value = 0

        for i = 1, 6 do
            if bits:sub(i, i) == "1" then
                value = value + 2^(6 - i)
            end
        end

        return BASE64_CHARS:sub(value + 1, value + 1)
    end) .. ({
        "",
        "==",
        "=",
    })[#data % 3 + 1])
end
libmisc.lz4compress = function(...)
    assert(type(findit("lz4compress")) == "function","not exixts lz4compress")
    return findit("lz4compress")(...)
end
libmisc.lz4decompress = function(...)
    assert(type(findit("lz4decompress")) == "function","not exixts lz4decompress")
    return findit("lz4decompress")(...)
end
libmisc.getgc = function(...)
    assert(type(findit("getgc")) == "function","not exixts getgc")
    return findit("getgc")(...)
end
libmisc.getgenv = function(...)
    assert(type(findit("getgenv")) == "function","not exixts getgenv")
    return findit("getgenv")(...)
end
libmisc.getreg = function(...)
    assert(type(findit("getreg")) == "function","not exixts getreg")
    return findit("getreg")(...)
end
libmisc.getrenv = function(...)
    assert(type(findit("getrenv")) == "function","not exixts getrenv")
    return findit("getrenv")(...)
end
libmisc.getgenv = function(...)
    assert(type(findit("getgenv")) == "function","not exixts getgenv")
    return findit("getgenv")(...)
end
libmisc.filtergc = function(...)
    assert(type(findit("filtergc")) == "function","not exixts filtergc")
    return findit("filtergc")(...)
end

libmisc.getcallbackvalue = function(...)
    assert(type(findit("getcallbackvalue")) == "function","not exixts getcallbackvalue")
    return findit("getcallbackvalue")(...)
end
libmisc.getinstances = function(...)
    assert(type(findit("getinstances")) == "function","not exixts getinstances")
    return findit("getinstances")(...)
end
libmisc.getnilinstances = function(...)
    assert(type(findit("getnilinstances")) == "function","not exixts getnilinstances")
    return findit("getnilinstances")(...)
end
libmisc.getnamecallmethod = function(...)
    assert(type(findit("getnamecallmethod")) == "function","not exixts getnamecallmethod")
    return findit("getnamecallmethod")(...)
end

libmisc.getrawmetatable = function(...)
    assert(type(findit("getrawmetatable")) == "function","not exixts getrawmetatable")
    return findit("getrawmetatable")(...)
end
libmisc.isreadonly = function(...)
    assert(type(findit("isreadonly")) == "function","not exixts isreadonly")
    return findit("isreadonly")(...)
end
libmisc.setrawmetatable = function(...)
    assert(type(findit("setrawmetatable")) == "function","not exixts setrawmetatable")
    return findit("setrawmetatable")(...)
end
libmisc.setreadonly = function(...)
    assert(type(findit("setreadonly")) == "function","not exixts setreadonly")
    return findit("setreadonly")(...)
end
libmisc.identifyexecutor = function(...)
    assert(type(findit("identifyexecutor")) == "function","not exixts identifyexecutor")
    return findit("identifyexecutor")(...)
end
libmisc.request = function(...)
    assert(type(findit("request")) == "function","not exixts request")
    return findit("request")(...)
end

libmisc.gethiddenproperty = function(...)
    assert(type(findit("gethiddenproperty")) == "function","not exixts gethiddenproperty")
    return findit("gethiddenproperty")(...)
end
libmisc.getthreadidentity = function(...)
    assert(type(findit("getthreadidentity")) == "function","not exixts getthreadidentity")
    return findit("getthreadidentity")(...)
end
libmisc.isscriptable = function(...)
    assert(type(findit("isscriptable")) == "function","not exixts isscriptable")
    return findit("isscriptable")(...)
end
libmisc.sethiddenproperty = function(...)
    assert(type(findit("sethiddenproperty")) == "function","not exixts sethiddenproperty")
    return findit("sethiddenproperty")(...)
end
libmisc.setscriptable = function(...)
    assert(type(findit("setscriptable")) == "function","not exixts setscriptable")
    return findit("setscriptable")(...)
end
libmisc.setthreadidentity = function(...)
    assert(type(findit("setthreadidentity")) == "function","not exixts setthreadidentity")
    return findit("setthreadidentity")(...)
end

libmisc.getcallingscript = function(...)
    assert(type(findit("getcallingscript")) == "function","not exixts getcallingscript")
    return findit("getcallingscript")(...)
end
libmisc.getloadedmodules = function(...)
    assert(type(findit("getloadedmodules")) == "function","not exixts getloadedmodules")
    return findit("getloadedmodules")(...)
end
libmisc.getscriptbytecode = function(...)
    assert(type(findit("getscriptbytecode")) == "function","not exixts getscriptbytecode")
    return findit("getscriptbytecode")(...)
end
libmisc.getscriptclosure = function(...)
    assert(type(findit("getscriptclosure")) == "function","not exixts getscriptclosure")
    return findit("getscriptclosure")(...)
end
libmisc.getscriptfromthread = function(...)
    assert(type(findit("getscriptfromthread")) == "function","not exixts getscriptfromthread")
    return findit("getscriptfromthread")(...)
end
libmisc.getscripthash = function(...)
    assert(type(findit("getscripthash")) == "function","not exixts getscripthash")
    return findit("getscripthash")(...)
end

libmisc.getscripts = function(...)
    assert(type(findit("getscripts")) == "function","not exixts getscripts")
    return findit("getscripts")(...)
end
libmisc.firesignal = function(...)
    assert(type(findit("firesignal")) == "function","not exixts firesignal")
    return findit("firesignal")(...)
end
libmisc.getconnections = function(...)
    assert(type(findit("getconnections")) == "function","not exixts getconnections")
    return findit("getconnections")(...)
end
libmisc.getscriptclosure = function(...)
    assert(type(findit("getscriptclosure")) == "function","not exixts getscriptclosure")
    return findit("getscriptclosure")(...)
end
libmisc.replicatesignal = function(...)
    assert(type(findit("replicatesignal")) == "function","not exixts replicatesignal")
    return findit("replicatesignal")(...)
end
libmisc.WebSocket = {}
libmisc.WebSocket.connect = function(...)
    assert(type(findit("WebSocket")) == "table","not exixts WebSocket")
    assert(type(findit("WebSocket").connect) == "function","not exixts WebSocket")
    return findit("WebSocket").connect(...)
end
libmisc.getidentity = function(...)
    local exec = libmisc.identifyexecutor()
    if exec:lower():find("solara") do
      return 3
    end
    assert(type(findit("getidentity")) == "function","not exixts getidentity")
    return findit("getidentity")(...)
end
libmisc.printidentity = function(...)
    local exec = libmisc.identifyexecutor()
    if exec:lower():find("solara") do
      return print("Current identity is 3")
    end
    assert(type(findit("printidentity")) == "function","not exixts printidentity")
    return findit("printidentity")(...)
end
return libmisc
