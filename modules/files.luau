local liblua = {}

function findit(name)
  return getgenv()[name] or (syn and syn[name])
end

liblua._fixpath = function(filepath)
  return filepath:gsub("\\","/")
end

liblua.listfiles = function(path)
  if not path:match("/$") then
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

return liblua
