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

return libmisc
