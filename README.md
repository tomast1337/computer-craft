# Computer Craft Programs

This repository contains Lua programs for Computer Craft, a Minecraft mod that adds programmable computers and turtles.

## About Computer Craft

Computer Craft is a mod for Minecraft that adds computers, turtles, and other programmable blocks that can be controlled using the Lua programming language. This repository contains various programs and utilities for Computer Craft devices.

## Repository Structure

```
/
├── computers/          # Programs for Computer Craft computers
├── turtles/           # Programs for Computer Craft turtles
├── pocket/            # Programs for Pocket Computers
├── utilities/         # Utility libraries and helper functions
├── examples/          # Example programs and tutorials
└── docs/             # Documentation and guides
```

## Getting Started

### Installation in Computer Craft

1. **In-game method**: Use the `pastebin` program to download files directly:

   ```lua
   pastebin get <pastebin_id> <filename>
   ```

2. **File transfer**: Copy files to your Computer Craft save directory:

   ```
   .minecraft/saves/<world>/computercraft/computer/<computer_id>/
   ```

3. **HTTP API**: If HTTP is enabled, you can download files directly from GitHub:
   ```lua
   shell.run("wget", "https://raw.githubusercontent.com/user/repo/main/program.lua", "program.lua")
   ```

### Running Programs

1. Place the program file in the computer's directory
2. Run the program using: `<program_name>`
3. For programs with arguments: `<program_name> <arg1> <arg2>`

## Program Categories

### Computers

- **Monitoring Systems**: Programs for displaying information and system status
- **Automation**: Scripts for automating various tasks
- **Networking**: Programs for computer-to-computer communication

### Turtles

- **Mining**: Automated mining and excavation programs
- **Building**: Construction and building automation
- **Farming**: Automated crop and tree farming
- **Utility**: Movement, inventory management, and general purpose scripts

### Pocket Computers

- **Remote Control**: Programs for controlling other devices remotely
- **Portable Tools**: Handy utilities for on-the-go use

## Contributing

1. Follow Lua coding conventions
2. Comment your code clearly
3. Include usage instructions in program headers
4. Test programs thoroughly before committing

## Useful Resources

- [Computer Craft Wiki](http://computercraft.info/wiki/)
- [Computer Craft Forums](https://forums.computercraft.cc/)
- [Lua 5.1 Reference](https://www.lua.org/manual/5.1/)
- [CC: Tweaked Documentation](https://tweaked.cc/)

## License

This project is open source. Feel free to use, modify, and distribute these programs.
