local liblua = {}

function findit(name)
  return getgenv()[name] or (syn and syn[name])
end

liblua._fixpath = function(filepath)
  return filepath:gsub("\\","/")
end

liblua.readfile = function(...)
    assert(type(findit("readfile")) == "function","not exixts readfile")
    return findit("readfile")(...)
end
liblua.delfile = function(...)
    assert(type(findit("delfile")) == "function","not exixts delfile")
    return findit("delfile")(...)
end
liblua.delfolder = function(...)
    assert(type(findit("delfolder")) == "function","not exixts delfolder")
    return findit("delfolder")(...)
end
liblua.isfile = function(...)
    assert(type(findit("isfile")) == "function","not exixts isfile")
    return findit("isfile")(...)
end
liblua.isfolder = function(...)
    assert(type(findit("isfolder")) == "function","not exixts isfolder")
    return findit("isfolder")(...)
end
liblua.loadfile = function(...)
    assert(type(findit("loadfile")) == "function","not exixts loadfile")
    return findit("loadfile")(...)
end
liblua.makefolder = function(...)
    assert(type(findit("makefolder")) == "function","not exixts makefolder")
    return findit("makefolder")(...)
end
liblua.writefile = function(...)
    assert(type(findit("writefile")) == "function","not exixts writefile")
    return findit("writefile")(...)
end

liblua.listfiles = function(path)
  if not path:match("/$") and path ~= "" then
    path = path .. "/"
  end
  local files = findit("listfiles")(path)
  local output = {}
  for i,v in ipairs(files) do
    local fixedpath = liblua._fixpath(v)
    if fixedpath:match("^"..path.."[^/]+$") then
      table.insert(output,fixedpath)
    end
  end
  return output
end
liblua.appendfile = function(filepath,content)
    local findthefunc = findit("appendfile")
    if not findthefunc then
        local data = liblua.readfile(filepath)
        liblua.writefile(filepath,data..content)
        return
    end
    return findthefunc(filepath,content)
end
liblua.getcustomasset = function(filepath,nocache)
    local typefile = filepath:match("%.([^%.]+)$")
    if typefile then
        typefile = "."..typefile
    else
        typefile = ""
    end
    local outputpath = filepath
    if nocache then
        local guid = game:GetService("HttpService"):GenerateGUID(false)
        liblua.makefolder("Temp")
        local data = liblua.readfile(filepath)
        local path = "Temp/"..guid..typefile
        liblua.writefile(path,data)
        outputpath = path
    end
    return findit("getcustomasset")(outputpath)
end

return liblua
