local libfiles = {}

function findit(name)
  return getgenv()[name] or (syn and syn[name])
end

libfiles._fixpath = function(filepath)
  return filepath:gsub("\\","/")
end

libfiles.readfile = function(...)
    assert(type(findit("readfile")) == "function","not exixts readfile")
    return findit("readfile")(...)
end
libfiles.delfile = function(...)
    assert(type(findit("delfile")) == "function","not exixts delfile")
    return findit("delfile")(...)
end
libfiles.delfolder = function(...)
    assert(type(findit("delfolder")) == "function","not exixts delfolder")
    return findit("delfolder")(...)
end
libfiles.isfile = function(...)
    assert(type(findit("isfile")) == "function","not exixts isfile")
    return findit("isfile")(...)
end
libfiles.isfolder = function(...)
    assert(type(findit("isfolder")) == "function","not exixts isfolder")
    return findit("isfolder")(...)
end
libfiles.loadfile = function(...)
    assert(type(findit("loadfile")) == "function","not exixts loadfile")
    return findit("loadfile")(...)
end
libfiles.makefolder = function(...)
    assert(type(findit("makefolder")) == "function","not exixts makefolder")
    return findit("makefolder")(...)
end
libfiles.writefile = function(...)
    assert(type(findit("writefile")) == "function","not exixts writefile")
    return findit("writefile")(...)
end

libfiles.listfiles = function(path)
  if not path:match("/$") and path ~= "" then
    path = path .. "/"
  end
  local files = findit("listfiles")(path)
  local output = {}
  for i,v in ipairs(files) do
    local fixedpath = libfiles._fixpath(v)
    if fixedpath:match("^"..path.."[^/]+$") then
      table.insert(output,fixedpath)
    end
  end
  return output
end
libfiles.appendfile = function(filepath,content)
    local findthefunc = findit("appendfile")
    if not findthefunc then
        local data = libfiles.readfile(filepath)
        libfiles.writefile(filepath,data..content)
        return
    end
    return findthefunc(filepath,content)
end
libfiles.getcustomasset = function(filepath,nocache)
    local typefile = filepath:match("%.([^%.]+)$")
    if typefile then
        typefile = "."..typefile
    else
        typefile = ""
    end
    local outputpath = filepath
    if nocache then
        local guid = game:GetService("HttpService"):GenerateGUID(false)
        libfiles.makefolder("Temp")
        local data = libfiles.readfile(filepath)
        local path = "Temp/"..guid..typefile
        libfiles.writefile(path,data)
        outputpath = path
    end
    return findit("getcustomasset")(outputpath)
end
-- some custom func why not
libfiles.typefile = function(filepath)
    if libfiles.isfile(filepath) then
        return "file"
    end
    if libfiles.isfolder(filepath) then
        return "folder"
    end
    return "unknown"
end
libfiles.typeendfile = function(filepath)
    return libfiles._fixpath(filepath):match("%.([^%.]+)$") or ""
end
libfiles.filepathtofilename = function(filepath)
    return libfiles._fixpath(filepath):match("([^/]+)$")
end
libfiles.vaildnamefile = function(filename)
    local whitelistletter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_.!@#$%^&()[]{}',;+=~`"
    for i = 1,#filename do
        if not whitelistletter:find(filename:sub(i, i), 1, true) then
            return false
        end
    end
    return true
end


return libfiles
