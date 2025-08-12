--[[
  Tunnel Maker - Advanced Turtle Tunneling Program
  
  This program makes a turtle dig tunnels with configurable dimensions.
  
  Usage: tunnel_maker <width> <height> <depth>
  Example: tunnel_maker 3 2 20
  
  This will create a tunnel that is:
  - 3 blocks wide
  - 2 blocks high 
  - 20 blocks deep
  
  Requirements:
  - Turtle with fuel
  - Pickaxe equipped
  - Enough inventory space for blocks
--]]

-- Load inventory utilities
local inv = dofile("../utilities/inventory.lua")

-- Get command line arguments
local args = {...}
local width = tonumber(args[1]) or 2
local height = tonumber(args[2]) or 2
local depth = tonumber(args[3]) or 10

print("Tunnel Maker Starting...")
print("Tunnel dimensions: " .. width .. "w x " .. height .. "h x " .. depth .. "d")

-- Validate arguments
if width < 1 or height < 1 or depth < 1 then
    print("Error: All dimensions must be at least 1!")
    return
end

if width > 10 or height > 10 or depth > 100 then
    print("Error: Dimensions too large! Max: 10x10x100")
    return
end

-- Check if turtle has fuel
local fuelNeeded = (width * height * depth) + (depth * 2) -- Extra fuel for movement
if turtle.getFuelLevel() < fuelNeeded then
    print("Warning: May not have enough fuel!")
    print("Estimated fuel needed: " .. fuelNeeded)
    print("Current fuel: " .. turtle.getFuelLevel())
    print("Continue anyway? (y/n)")
    local input = read()
    if input:lower() ~= "y" then
        return
    end
end

-- Position tracking
local currentX = 0
local currentY = 0
local currentZ = 0

-- Function to dig forward and move
local function digMove()
    while turtle.detect() do
        turtle.dig()
        sleep(0.1)
    end
    if turtle.forward() then
        currentZ = currentZ + 1
        return true
    end
    return false
end

-- Function to dig up and move up
local function digMoveUp()
    while turtle.detectUp() do
        turtle.digUp()
        sleep(0.1)
    end
    if turtle.up() then
        currentY = currentY + 1
        return true
    end
    return false
end

-- Function to dig down and move down
local function digMoveDown()
    while turtle.detectDown() do
        turtle.digDown()
        sleep(0.1)
    end
    if turtle.down() then
        currentY = currentY - 1
        return true
    end
    return false
end

-- Function to turn around at end of row
local function turnAround(turnRight)
    if turnRight then
        turtle.turnRight()
        digMove()
        turtle.turnRight()
        currentX = currentX + 1
    else
        turtle.turnLeft()
        digMove()
        turtle.turnLeft()
        currentX = currentX - 1
    end
end

-- Function to mine a single horizontal layer at current height
local function mineLayer(layerDepth)
    local turnRight = true
    
    for row = 1, width do
        -- Mine the current row
        for col = 1, layerDepth do
            -- Dig current position
            if turtle.detect() then
                turtle.dig()
            end
            
            -- Move forward if not at end
            if col < layerDepth then
                digMove()
            end
        end
        
        -- Turn around if not on last row
        if row < width then
            turnAround(turnRight)
            turnRight = not turnRight
        end
    end
end

-- Function to return to start of current layer
local function returnToLayerStart()
    -- Face correct direction based on current position
    local targetDirection = 0 -- 0 = original direction
    
    -- Move to x=0
    if currentX > 0 then
        turtle.turnLeft()
        for i = 1, currentX do
            turtle.forward()
        end
        turtle.turnRight()
        currentX = 0
    elseif currentX < 0 then
        turtle.turnRight()
        for i = 1, math.abs(currentX) do
            turtle.forward()
        end
        turtle.turnLeft()
        currentX = 0
    end
    
    -- Move back to z=0
    turtle.turnRight()
    turtle.turnRight()
    for i = 1, currentZ do
        turtle.forward()
    end
    turtle.turnRight()
    turtle.turnRight()
    currentZ = 0
end

-- Main tunneling function
local function createTunnel()
    for layer = 1, height do
        print("Mining layer " .. layer .. "/" .. height .. " (height " .. (layer-1) .. ")")
        
        -- Mine current layer
        mineLayer(depth)
        
        -- Return to start position for this layer
        returnToLayerStart()
        
        -- Move up to next layer (except on last layer)
        if layer < height then
            digMoveUp()
        end
        
        -- Check inventory and organize if getting full
        if inv.countItems() > 200 then
            print("Organizing inventory...")
            inv.organize()
        end
        
        -- Drop items if inventory is getting too full
        if inv.isFull() then
            print("Inventory full! Dropping excess items...")
            for slot = 9, 16 do
                turtle.select(slot)
                turtle.dropDown()
            end
            turtle.select(1)
        end
    end
end

-- Execute tunneling
print("Starting tunnel creation...")
createTunnel()

print("Tunnel creation complete!")
print("Returning to start position...")

-- Return to starting position
-- Move down to ground level
for i = 1, currentY do
    turtle.down()
end

-- Move back to start
returnToLayerStart()

-- Display final inventory summary
local summary = inv.getSummary()
print("Final inventory summary:")
print("Total items collected: " .. summary.totalItems)
print("Empty slots: " .. summary.emptySlots)

print("Tunnel complete! Dimensions: " .. width .. "x" .. height .. "x" .. depth) 