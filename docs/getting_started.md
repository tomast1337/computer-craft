# Getting Started with Computer Craft Programming

## Introduction

Computer Craft is a Minecraft mod that adds programmable computers and turtles using the Lua programming language. This guide will help you get started with creating your own programs.

## Basic Concepts

### Computers

- **Computer**: Basic programmable computer block
- **Advanced Computer**: Computer with color support
- **Command Computer**: Computer with access to command blocks (creative/ops only)

### Turtles

- **Turtle**: Mobile robot that can move, dig, and interact with the world
- **Advanced Turtle**: Turtle with color support
- **Mining Turtle**: Turtle with built-in mining capabilities

### Peripherals

- **Monitor**: External display for computers
- **Disk Drive**: For using floppy disks
- **Modem**: For networking between computers
- **Printer**: For printing documents

## Basic Lua Syntax

### Variables

```lua
local myVariable = "Hello"
local number = 42
local boolean = true
```

### Functions

```lua
local function myFunction(parameter)
    return parameter * 2
end
```

### Loops

```lua
-- For loop
for i = 1, 10 do
    print(i)
end

-- While loop
while condition do
    -- do something
end
```

### Conditionals

```lua
if condition then
    -- do something
elseif otherCondition then
    -- do something else
else
    -- default action
end
```

## Computer Craft APIs

### Basic I/O

```lua
print("Hello World")           -- Print to screen
local input = read()           -- Read user input
write("Text without newline")  -- Print without newline
```

### Terminal Control

```lua
term.clear()                   -- Clear screen
term.setCursorPos(x, y)       -- Set cursor position
term.getSize()                -- Get terminal size
```

### File System

```lua
fs.list("/")                  -- List files in directory
fs.exists("filename")         -- Check if file exists
fs.delete("filename")         -- Delete file
fs.copy("source", "dest")     -- Copy file
```

### Turtle Movement

```lua
turtle.forward()              -- Move forward
turtle.back()                 -- Move backward
turtle.up()                   -- Move up
turtle.down()                 -- Move down
turtle.turnLeft()             -- Turn left
turtle.turnRight()            -- Turn right
```

### Turtle Interaction

```lua
turtle.dig()                  -- Dig block in front
turtle.digUp()                -- Dig block above
turtle.digDown()              -- Dig block below
turtle.place()                -- Place block from selected slot
turtle.drop()                 -- Drop items from selected slot
```

### Turtle Inventory

```lua
turtle.select(slot)           -- Select inventory slot (1-16)
turtle.getItemCount(slot)     -- Get item count in slot
turtle.transferTo(slot)       -- Transfer items to another slot
```

## Your First Programs

### 1. Hello World Computer Program

Create a file called `hello.lua`:

```lua
print("Hello, Computer Craft!")
print("Welcome to programming!")
```

### 2. Simple Turtle Movement

Create a file called `move.lua`:

```lua
-- Move in a square
for i = 1, 4 do
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.turnRight()
end
```

### 3. Basic Mining Turtle

Create a file called `mine.lua`:

```lua
-- Mine a 3x3 hole
for row = 1, 3 do
    for col = 1, 3 do
        turtle.dig()
        if col < 3 then
            turtle.forward()
        end
    end
    if row < 3 then
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
    end
end
```

## Best Practices

### 1. Use Local Variables

```lua
local variable = "value"  -- Good
variable = "value"        -- Avoid global variables
```

### 2. Add Comments

```lua
-- This function calculates distance
local function distance(x1, y1, x2, y2)
    return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end
```

### 3. Handle Errors

```lua
if not turtle.forward() then
    print("Cannot move forward - obstacle detected")
end
```

### 4. Use Functions

```lua
local function digAndMove()
    turtle.dig()
    turtle.forward()
end
```

### 5. Check Fuel

```lua
if turtle.getFuelLevel() < 10 then
    print("Low fuel!")
    return
end
```

## Common Patterns

### Command Line Arguments

```lua
local args = {...}
local width = tonumber(args[1]) or 5
local length = tonumber(args[2]) or 5
```

### User Input Validation

```lua
local function getNumber(prompt)
    while true do
        print(prompt)
        local input = tonumber(read())
        if input then
            return input
        else
            print("Please enter a valid number")
        end
    end
end
```

### Safe Movement

```lua
local function safeForward()
    while not turtle.forward() do
        if turtle.detect() then
            turtle.dig()
        else
            print("Cannot move - unknown obstacle")
            return false
        end
    end
    return true
end
```

## Next Steps

1. Experiment with the example programs in this repository
2. Read the [Computer Craft Wiki](http://computercraft.info/wiki/)
3. Join the [Computer Craft Forums](https://forums.computercraft.cc/)
4. Try creating your own programs
5. Learn about advanced topics like networking and peripherals

## Troubleshooting

### Common Issues

- **"No such program"**: Make sure the file has a `.lua` extension
- **Turtle won't move**: Check fuel level and obstacles
- **Syntax errors**: Check for missing `end` statements or typos
- **Permission denied**: Make sure HTTP is enabled in the mod config

### Debugging Tips

- Use `print()` statements to debug your code
- Test small parts of your program separately
- Use the Lua interpreter (`lua`) to test expressions
- Check the Computer Craft logs for error messages
