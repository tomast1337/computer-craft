--[[
  Inventory Utilities Library
  
  This library provides common inventory management functions
  for Computer Craft turtles and computers.
  
  Usage: 
    local inv = require("utilities.inventory")
    inv.countItems()
--]]

local inventory = {}

-- Count total items in turtle inventory
function inventory.countItems()
    local total = 0
    for slot = 1, 16 do
        local count = turtle.getItemCount(slot)
        total = total + count
    end
    return total
end

-- Find empty slots in turtle inventory
function inventory.getEmptySlots()
    local empty = {}
    for slot = 1, 16 do
        if turtle.getItemCount(slot) == 0 then
            table.insert(empty, slot)
        end
    end
    return empty
end

-- Find slots containing a specific item
function inventory.findItem(itemName)
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item and item.name == itemName then
            return slot
        end
    end
    return nil
end

-- Drop all items from inventory
function inventory.dropAll()
    for slot = 1, 16 do
        turtle.select(slot)
        turtle.drop()
    end
    turtle.select(1)
end

-- Organize inventory by moving items to consolidate stacks
function inventory.organize()
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

-- Check if inventory is full
function inventory.isFull()
    for slot = 1, 16 do
        if turtle.getItemCount(slot) == 0 then
            return false
        end
    end
    return true
end

-- Get inventory summary
function inventory.getSummary()
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

return inventory 