-- config: number of seconds to hold Command-Q to quit application
local obj = {}
obj.__index = obj
obj.name = "cmdQ"
obj.version = "0.1"
obj.author = "chz"
obj.homepage = "null"
obj.license = "null"


obj.cmdQDelay = 0.5
obj.cmdQTimer = nil
obj.cmdQAlert = nil

function obj:init()
  cmdQ = hs.hotkey.bind({ "cmd" }, "q", function() obj:startCmdQ() end, function() obj:stopCmdQ() end)
  -- hs.alert.defaultStyle.atScreenOffset=100
end

function obj:cmdQCleanup()
  hs.alert.closeSpecific(obj.cmdQAlert)
  obj.cmdQTimer = nil
  obj.cmdQAlert = nil
end

function obj:stopCmdQ()
  if obj.cmdQTimer then
    obj.cmdQTimer:stop()
    obj:cmdQCleanup()
    hs.alert("quit canceled", 0.5)
  end
end

function obj:startCmdQ()
  local app = hs.application.frontmostApplication()
  obj.cmdQTimer = hs.timer.doAfter(obj.cmdQDelay, function() app:kill(); obj:cmdQCleanup() end)
  obj.cmdQAlert = hs.alert("hold to quit " .. app:name(), true)
end

return obj
