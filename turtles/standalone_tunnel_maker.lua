--[[
  Standalone Tunnel Maker - Complete Turtle Tunneling Program
  
  This is a self-contained program that creates tunnels with configurable dimensions.
  No external dependencies required.
  
  Usage: standalone_tunnel_maker <width> <height> <depth>
  Example: standalone_tunnel_maker 3 2 20
  
  This will create a tunnel that is:
  - 3 blocks wide
  - 2 blocks high 
  - 20 blocks deep
  
  Requirements:
  - Turtle with fuel
  - Pickaxe equipped
--]]

-- Get command line arguments
local args = {...}
local width = tonumber(args[1]) or 2
local height = tonumber(args[2]) or 2
local depth = tonumber(args[3]) or 10

print("Standalone Tunnel Maker Starting...")
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

-- =====================================
-- INVENTORY MANAGEMENT FUNCTIONS
-- =====================================

-- Count total items in turtle inventory
local function countItems()
    local total = 0
    for slot = 1, 16 do
        local count = turtle.getItemCount(slot)
        total = total + count
    end
    return total
end

-- Find empty slots in turtle inventory
local function getEmptySlots()
    local empty = {}
    for slot = 1, 16 do
        if turtle.getItemCount(slot) == 0 then
            table.insert(empty, slot)
        end
    end
    return empty
end

-- Check if inventory is full
local function isFull()
    for slot = 1, 16 do
        if turtle.getItemCount(slot) == 0 then
            return false
        end
    end
    return true
end

-- Organize inventory by moving items to consolidate stacks
local function organize()
    for slot = 1, 16 do
        turtle.select(slot)
        local item = turtle.getItemDetail(slot)
        if item then
            -- Find other slots with same item
            for otherSlot = slot + 1, 16 do
                local otherItem = turtle.getItemDetail(otherSlot)
                if otherItem and otherItem.name == item.name then
                    turtle.select(otherSlot)
                    turtle.transferTo(slot)
                end
            end
        end
    end
    turtle.select(1)
end

-- Drop all items from inventory
local function dropAll()
    for slot = 1, 16 do
        turtle.select(slot)
        turtle.drop()
    end
    turtle.select(1)
end

-- Get inventory summary
local function getSummary()
    local summary = {}
    local totalItems = 0
    local emptySlots = 0
    
    for slot = 1, 16 do
        local count = turtle.getItemCount(slot)
        if count > 0 then
            local item = turtle.getItemDetail(slot)
            if item then
                if summary[item.name] then
                    summary[item.name] = summary[item.name] + count
                else
                    summary[item.name] = count
                end
                totalItems = totalItems + count
            end
        else
            emptySlots = emptySlots + 1
        end
    end
    
    return {
        items = summary,
        totalItems = totalItems,
        emptySlots = emptySlots,
        usedSlots = 16 - emptySlots
    }
end

-- =====================================
-- MOVEMENT AND MINING FUNCTIONS
-- =====================================

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

-- =====================================
-- MAIN TUNNELING FUNCTION
-- =====================================

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
        if countItems() > 200 then
            print("Organizing inventory...")
            organize()
        end
        
        -- Drop items if inventory is getting too full
        if isFull() then
            print("Inventory full! Dropping excess items...")
            for slot = 9, 16 do
                turtle.select(slot)
                turtle.dropDown()
            end
            turtle.select(1)
        end
        
        -- Show progress
        local itemCount = countItems()
        local emptySlots = #getEmptySlots()
        print("Items collected: " .. itemCount .. ", Empty slots: " .. emptySlots)
    end
end

-- =====================================
-- MAIN EXECUTION
-- =====================================

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
local summary = getSummary()
print("Final inventory summary:")
print("Total items collected: " .. summary.totalItems)
print("Empty slots: " .. summary.emptySlots)

print("Tunnel complete! Dimensions: " .. width .. "x" .. height .. "x" .. depth)
print("Done!") 