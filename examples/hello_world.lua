--[[
  Hello World - Basic Computer Craft Program
  
  This is a simple example program that demonstrates:
  - Basic output with print()
  - User input with read()
  - Terminal manipulation
  
  Usage: hello_world
--]]

-- Clear the screen
term.clear()
term.setCursorPos(1, 1)

-- Print a greeting
print("Hello, Computer Craft World!")
print("Welcome to Lua programming!")
print("")

-- Get user input
print("What's your name?")
local name = read()

-- Respond to the user
print("")
print("Hello, " .. name .. "!")
print("Nice to meet you!")

-- Wait for user to press a key
print("")
print("Press any key to continue...")
os.pullEvent("key") 