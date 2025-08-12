--[[
  Tunnel Maker Usage Examples
  
  This file shows examples of how to use the tunnel_maker.lua program
--]]

-- Example 1: Small tunnel for exploring
-- tunnel_maker 2 2 15
-- Creates a 2-wide, 2-high, 15-deep tunnel

-- Example 2: Mining tunnel  
-- tunnel_maker 3 3 25
-- Creates a 3x3 tunnel that's 25 blocks deep - good for mining expeditions

-- Example 3: Railway tunnel
-- tunnel_maker 3 4 50  
-- Creates a 3-wide, 4-high, 50-deep tunnel - perfect for minecart tracks

-- Example 4: Narrow utility tunnel
-- tunnel_maker 1 3 30
-- Creates a 1-wide, 3-high tunnel - minimal resource usage

-- To run these examples, place a turtle at your desired starting position
-- facing the direction you want the tunnel to go, then run:
-- 
-- tunnel_maker <width> <height> <depth>

print("Tunnel Maker Examples")
print("===================")
print("Usage: tunnel_maker <width> <height> <depth>")
print("")
print("Examples:")
print("  tunnel_maker 2 2 15  -- Small exploration tunnel")
print("  tunnel_maker 3 3 25  -- Standard mining tunnel") 
print("  tunnel_maker 3 4 50  -- Railway tunnel")
print("  tunnel_maker 1 3 30  -- Narrow utility tunnel")
print("")
print("Tips:")
print("- Make sure turtle has enough fuel")
print("- Equip a pickaxe or diamond pickaxe")
print("- Position turtle at desired starting point")
print("- Face the direction you want tunnel to go")
print("- Have some empty inventory slots for mined blocks") 