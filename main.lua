-- main.lua

function love.load()
  LJ = love.joystick
  local width, height = love.window.getDesktopDimensions( displayindex )
  love.window.setMode(650, height - 48)
end

function love.draw()
  
  local yy = 0
  local ss
  
  function strout(str)
    -- выводим строку
    love.graphics.print(str, 10, yy)
    yy = yy + 14
  end

  if LJ ~= nil then
    
    local joysticks = LJ.getJoysticks() -- get all joysticks
    
    if(#joysticks == 0) then
      strout("No joystick / gamepad connected")
    else
      
      strout("Found ".. #joysticks .. " joystick(s) / gamepad(s)")
      
      for __, jj in pairs(joysticks) do
        
        -- jj is current joystick
        strout("-----------------------------------------------------------")
        strout("Name = " .. jj:getName())
        strout("GUID = " .. jj:getGUID())
        strout("Is connected = " .. tostring(jj:isConnected()))
        
        local id, instance_id = jj:getID()
        strout("ID = " .. tostring(id) .. ", instance ID = " .. tostring(instance_id))
        
        local connected_index = jj:getConnectedIndex()
        strout("Connected index = " .. tostring(connected_index))
        
        local vendorID, productID, productVersion = jj:getDeviceInfo()      
        strout(string.format("VID:DID = %04x:%04x, version = %i", vendorID , productID , productVersion))
        
        local is_gamepad = jj:isGamepad()
        strout("Is gamepad = "  .. tostring(is_gamepad))
        
        
        local axis_count = jj:getAxisCount()
        strout("Axis count = " .. axis_count)
        for i = 1, axis_count do
          strout("\taxis " .. i .. " = " .. jj:getAxis(i))
        end
        
        local buttons_count = jj:getButtonCount()
        strout("Buttons count = " .. buttons_count)
        for i = 1, buttons_count do
          ss = jj:isDown(i) and "_#_" or "___"
          strout("\tbutton " .. i .. " " .. ss)
        end
        
        local hat_count = jj:getHatCount()
        strout("Hat count = " .. hat_count)
        for i = 1, hat_count do
          
          strout("\that " .. i .. " dir = " .. jj:getHat(i))
        end
        
        local vibr_supp = jj:isVibrationSupported()
        if vibr_supp then
          local l, r = ll:getVibration()
          strout("Vibration curren: L = " .. l, " R = " .. r)
        else
          strout("Vibration not supported")
        end
      end
    end
  else
    love.graphics.print("love.joystick is nil", 10, 50)
  end
end


