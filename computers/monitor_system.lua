--[[
  System Monitor - Computer Craft System Information Display
  
  This program displays various system information and updates
  it in real-time. Useful for monitoring computer status.
  
  Usage: monitor_system
  
  Features:
  - Computer ID and label
  - Fuel level (for turtles)
  - Current time and day
  - Available programs
  - Disk space information
--]]

-- Function to clear and reset cursor
local function clearScreen()
    term.clear()
    term.setCursorPos(1, 1)
end

-- Function to center text on screen
local function centerText(text, y)
    local w, h = term.getSize()
    local x = math.floor((w - #text) / 2) + 1
    term.setCursorPos(x, y)
    term.write(text)
end

-- Function to draw a line across the screen
local function drawLine(y, char)
    local w, h = term.getSize()
    term.setCursorPos(1, y)
    term.write(string.rep(char or "-", w))
end

-- Function to get system information
local function getSystemInfo()
    local info = {}
    
    -- Basic computer info
    info.id = os.getComputerID()
    info.label = os.getComputerLabel() or "Unlabeled"
    info.time = textutils.formatTime(os.time(), false)
    info.day = os.day()
    
    -- Check if this is a turtle
    if turtle then
        info.isTurtle = true
        info.fuel = turtle.getFuelLevel()
        info.maxFuel = turtle.getFuelLimit()
    else
        info.isTurtle = false
    end
    
    -- Disk space
    info.freeSpace = fs.getFreeSpace("/")
    
    return info
end

-- Function to format bytes
local function formatBytes(bytes)
    if bytes > 1024 * 1024 then
        return string.format("%.1f MB", bytes / (1024 * 1024))
    elseif bytes > 1024 then
        return string.format("%.1f KB", bytes / 1024)
    else
        return bytes .. " B"
    end
end

-- Main display function
local function displayInfo()
    clearScreen()
    
    local info = getSystemInfo()
    local w, h = term.getSize()
    local line = 1
    
    -- Title
    centerText("=== SYSTEM MONITOR ===", line)
    line = line + 2
    
    -- Computer information
    term.setCursorPos(1, line)
    print("Computer ID: " .. info.id)
    line = line + 1
    
    term.setCursorPos(1, line)
    print("Label: " .. info.label)
    line = line + 1
    
    -- Turtle-specific information
    if info.isTurtle then
        term.setCursorPos(1, line)
        if info.fuel == "unlimited" then
            print("Fuel: Unlimited")
        else
            local fuelPercent = math.floor((info.fuel / info.maxFuel) * 100)
            print("Fuel: " .. info.fuel .. "/" .. info.maxFuel .. " (" .. fuelPercent .. "%)")
        end
        line = line + 1
    end
    
    line = line + 1
    drawLine(line, "=")
    line = line + 2
    
    -- Time information
    term.setCursorPos(1, line)
    print("Time: " .. info.time)
    line = line + 1
    
    term.setCursorPos(1, line)
    print("Day: " .. info.day)
    line = line + 2
    
    drawLine(line, "=")
    line = line + 2
    
    -- Disk space
    term.setCursorPos(1, line)
    print("Free Space: " .. formatBytes(info.freeSpace))
    line = line + 2
    
    -- Instructions
    drawLine(h - 1, "=")
    term.setCursorPos(1, h)
    term.write("Press Q to quit, R to refresh")
end

-- Main program loop
print("Starting System Monitor...")
print("Press any key to begin...")
os.pullEvent("key")

while true do
    displayInfo()
    
    -- Wait for user input
    local event, key = os.pullEvent("key")
    
    if key == keys.q then
        break
    elseif key == keys.r then
        -- Refresh (just continue the loop)
    end
end

clearScreen()
print("System Monitor stopped.") 