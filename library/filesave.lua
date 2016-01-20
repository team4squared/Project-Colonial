--[[
  File saving library
    written by Cody Peterson
  
  Examples
    --creates new Filesave object
    --creates a new file if it doesn't exist
    file = Filesave("file.txt")
    
    --Writing to the file
    --write to like an object
    file.key = "value"
    --or
    file["key"] = "value"
    
    --or useing the write method
    file.write("key", "value")
    
    --Reading from the file
    --read like an object
    value = file.key
    --or
    value = file["key"]
    
    --Using the read method
    value = file.read
    
    --Other methods
    file.clear() --clears the file
    
    file.getAll() --returns an object with all the keys and values
    file.getAll(number) --only gets a number of keys and values
    
    file() --returns an object with all keys and values
    file("a', "b", "c") --returns an object with the list of keys passed
    file(number) --only gets a number of keys and values
]]

--[[
  Filesave
    *file - filepath to your file
      creates a new file if it doesn't exist
    *return - returns a new filesave object
]]
local function PackTable(t)
  local strs = {}
  local index = 1
  for i, v in pairs(t) do
    local str = ""
    if type(v) == "table" then
      str = PackTable(v)
    elseif type(v) == "string" then
      str = '"'..v..'"'
    else
      str = tostring(v)
    end
    strs[index] = i.."="..str
    index = index + 1
  end
  
  table.sort(strs)
  
  local finalStr = "{"
  for i, v in pairs(strs) do
    local comma = ""
    if i ~= #strs then
      comma = ","
    end
    
    finalStr = finalStr..v..comma
  end
  
  return finalStr.."}"
end

local function UnpackTable(str)
  local t = {}
  
  local indexStart = 2
  local indexEnd = 2
  while true do
    local key = ""
    for i = indexStart, str:len() do
      local char = str:sub(i, i)
      indexEnd = indexEnd + 1
      
      if char == "=" then
        break
      end
      key = key..char
    end
    
    indexStart = indexEnd
    local value = ""
    local ignore = false
    local braceLevel = 0
    for i = indexStart, str:len() do
      local char = str:sub(i, i)
      indexEnd = indexEnd + 1
      
      if i == indexStart then
        if char == '"' or char == "'" then
          ignore = char
        elseif char == "{" then
          ignore = char
          value = value..char
        else
          value = value..char
        end
      elseif char == "{" and ignore == "{" then
        value = value..char
        braceLevel = braceLevel + 1
      elseif not ignore then
        if char == "," or char == "}" then
          break
        else
          value = value..char
        end
      else
        if char == ignore then
          ignore = false
        elseif char == "}" and ignore == "{" and braceLevel == 0 then
          ignore = false
          value = value..char
        elseif char == "}" and braceLevel ~= 0 then
          value = value..char
          braceLevel = braceLevel - 1
        else
          value = value..char
        end
      end
    end
    
    if tonumber(key) then
      t[tonumber(key)] = value
    else
      t[key] = value
    end
    indexStart = indexEnd
    if indexEnd >= str:len() then
      break
    end
  end
  
  for i, v in pairs(t) do
    if tonumber(v) then
      v = tonumber(v)
    elseif v == "true" then
      v = true
    elseif v == "false" then
      v = false
    elseif v == "nil" then
      v = nil
    elseif v:sub(1, 1) == "{" then
      v = UnpackTable(v)
    else
      v = tostring(v)
    end
    
    t[i] = v
  end
  
  return t
end

function Filesave(file, sort)
  local self = {}
  
  self.file = file
  self.lines = 0
  self.type = "filesave"
  self.sort = sort or true
  self.tabs = 0
  
  local f = io.open(self.file, "r")
  if f == nil then
    io.close(io.open(self.file, "w"))
  else
    io.close(f)
  end
  
  self.__lines = function()
    self.lines = 0
    for line, i in io.lines(self.file) do
      self.lines = self.lines + 1
    end
    
    return self.lines
  end
  
  self.read = function(t, key)
    return t[key]
  end
  
  self.write = function(t, key, value)
    t[key] = value
  end
  
  self.getAll = function(t, count)
    return t(count)
  end
  
  self.clear = function(t, count)
    io.close(io.open(self.file, "w"))
  end
  
  self.__lines()
  
  return setmetatable(self, {
      __index = function(t, key)
        for line, i in io.lines(rawget(t, "file")) do
          local k, e = line:find(key..": ")
          
          if k == 1 then
            local str = line:sub(e + 1)
            
            if tonumber(str) then
              return tonumber(str)
            elseif str == "true" then
              return true
            elseif str == "false" then
              return false
            elseif str == "nil" then
              return nil
            elseif str:sub(1, 1) == "{" then
              return UnpackTable(str)
            else
              return str
            end
          end
        end
        
        return nil
      end,
      __newindex = function(t, key, value)
        local lines = {}
        do
          local tabbed = ""          
          tabbed = tabbed.rep("\t", self.tabs)
          
          local index = 1
          local exists = false
          for line, i in io.lines(t.file) do
            local k = line:find(key..": ")
            
            if k == 1 and value ~= nil then
              exists = true
              if type(value) == "table" then
                lines[index] = key..": "..PackTable(value)
              else
                lines[index] = key..": "..tostring(value)
              end
              index = index + 1
            elseif k == 1 and value == nil then
              exists = true
            elseif line ~= "" then
              lines[index] = line
              index = index + 1
            end
            
          end
          
          if not exists and value ~= nil then
            if type(value) == "table" then
              lines[index] = key..": "..PackTable(value)
            else
              lines[index] = tabbed..key..": "..tostring(value)
            end
          end
        end
        
        if self.sort then
          table.sort(lines)
        end
        
        do
          local f = io.open(t.file, "w")
          io.output(f)
          
          for i, line in pairs(lines) do
            local nl = "\n"
            if i == #lines then
              nl = ""
            end
            
            if line ~= "" then
              io.write(line..nl)
            end
          end
          io.flush()
          io.close(f)
        end
        
        t.__lines()
      end,
      __call = function(...)
        local args = {...}
        local t = args[1]
        local tbl = {}
        
        if type(args[2]) ~= "number" and args[2] ~= nil then
          for i, arg in pairs(args) do
            if arg ~= t then
              tbl[arg] = t[arg]
            end
          end
        else
          local index = args[2] or t.__lines()
          for line, i in io.lines(t.file) do
            if index > 0 then
              local s = line:find(": ")
              local key = line:sub(1, s - 1)
              
              tbl[key] = t[key]
              index = index - 1
            else
              break
            end
          end
          
          return tbl
        end
      end
    })
end