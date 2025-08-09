--[[
  Simple Miner - Basic Turtle Mining Program
  
  This program makes a turtle dig a simple rectangular mine.
  
  Usage: simple_miner <width> <length> <depth>
  Example: simple_miner 5 10 3
  
  Requirements:
  - Turtle with fuel
  - Pickaxe equipped
--]]

-- Get command line arguments
local args = {...}
local width = tonumber(args[1]) or 3
local length = tonumber(args[2]) or 3
local depth = tonumber(args[3]) or 1

print("Simple Miner Starting...")
print("Mining area: " .. width .. "x" .. length .. "x" .. depth)

-- Check if turtle has fuel
if turtle.getFuelLevel() == 0 then
    print("Error: Turtle needs fuel!")
    return
end

-- Function to dig forward and move
local function digMove()
    while turtle.detect() do
        turtle.dig()
        sleep(0.5)
    end
    turtle.forward()
end

-- Function to turn around at end of row
local function turnAround(right)
    if right then
        turtle.turnRight()
        digMove()
        turtle.turnRight()
    else
        turtle.turnLeft()
        digMove()
        turtle.turnLeft()
    end
end

-- Main mining function
local function mineLayer()
    local right = true
    
    for row = 1, length do
        -- Mine the current row
        for col = 1, width - 1 do
            digMove()
        end
        
        -- Turn around if not on last row
        if row < length then
            turnAround(right)
            right = not right
        end
    end
end

-- Mine each layer
for layer = 1, depth do
    print("Mining layer " .. layer .. "/" .. depth)
    mineLayer()
    
    -- Go down to next layer (except on last layer)
    if layer < depth then
        turtle.digDown()
        turtle.down()
    end
end

print("Mining complete!")
print("Returning to start position...")

-- Return to starting position
for i = 1, depth - 1 do
    turtle.up()
end

print("Done!") 