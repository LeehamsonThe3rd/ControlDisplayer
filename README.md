# ControlDisplayer v1.0

## Description

A simple module to allow the user to show specified controls in the bottom left of the screen (Compatible with both Keyboard and Controller!)

### [GET IT HERE](https://www.roblox.com/library/9793031993/Control-Displayer)

![image](https://user-images.githubusercontent.com/62216231/171504313-92d2482d-3af0-4f95-b2ce-e9b48afdb861.png)

## Documentation

### ControlDisplayer.new(Enum.KeyCode, string) 
```lua
-- REMEMBER to reference the ControlDisplayer service 
local ControlDisplayer = require(script.Parent)

-- Create a control using the ControlDisplayer.new() method
local NewControl = ControlDisplayer.new(Enum.KeyCode.E, "Switch")
```
This method will create an object that stores the inputted `KeyCode` and `Action` aswell as a reference to the newely created GUI object (named `Control`) which will be parented to the `ControlList` 

### ControlDisplayer.Destroy()
```lua
-- Have a prexisting control
local Reload = ControlDisplayer.new(Enum.KeyCode.R, "Reload")

-- Call the :Destroy() method
Reload:Destroy()
```
This method will destroy the `Control` GUI and removes itself from the metatable

### ControlDisplayer.UpdateKey(Enum.KeyCode)
```lua
  -- Have a prexisting control
  local Roll = ControlDisplayer.new(Enum.KeyCode.LeftAlt, "Dash")
  
  -- Call the :UpdateKey() method
  Roll:UpdateKey(Enum.KeyCode.ButtonL2)
```
This method will update the `KeyCode` property aswell as the corresponding GUI object

### ControlDisplayer.UpdateAction(string)
```lua
  -- Have a prexisting control
  local Eat = ControlDisplayer.new(Enum.KeyCode.E, "Eat Banana")
  
  -- Call the :UpdateAction() method
  Eat:UpdateAction("Eat Orange")
```
This method will update the `Action` property aswell as the corresponding GUI object

### It is recommended you do not copy the source code and rather just use the roblox model provided, however if you would still rather use the source code it here is some import information to note:

Be sure you have a `ControlList` in `StarterGui` (your hierarchy will need to look like this)

```
StarterGui
 |-ControlList (ScreenGui / MUST INCLUDE)
   |-ControlFrame (Frame / MUST INCLUDE)
     |-UIListLayout (UIListLayout / OPTIONAL)
```

Also be sure to create a `ControlTemplate` within the module (your hierarchy will need to look like this)

```
ControlDisplayer
 |-ControlTemplate (Frame / MUST INCLUDE)
   |-Button (ImageLabel / MUST INCLUDE)
     |-UIAspectRatioConstraint (UIAspectRatioConstraint / OPTIONAL)
     |-ButtonIcon (ImageLabel / MUST INCLUDE)
     |-Key (TextLabel / MUST INCLUDE)
   |-Action (TextLabel / MUST INCLUDE)
```
