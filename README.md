# Information
  Quantum UI V1. 
  This UI will be finished soon.
  Press Z to toggle menu. (Default)
# How to use
  Import the library by entering
  ```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/exdssnuiag/Quantum-UI/refs/heads/main/Hub_Code.lua"))()
```
  To create the window, enter
```lua
Library.Create("Coolhub") -- Arg 1: String; Hubname
```
  Changing toggle keybind
  ```lua
Library:ChangeKeybind(Enum.Keycode.X) -- Arg 1: Keycode; Toggle keybind
```
  Notifying
  ```lua
Library:Notify({
  Title = "Kewl title";
  Text = "Message test";
  Duration = 3
})-- [[
  Arg 1: String; Notification Title
  Arg 2: String; Notification Text
  Arg 3: Number; Notification Duration
]]
```
# Upcoming
  for it to actually fucking work lol;
  themes;
  look bettah;
  code bettah
