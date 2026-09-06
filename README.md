# PolyUI
---
## Loading the library
```lua
local PolyUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/BROTHAISHACKIER/PolyUI/refs/heads/main/Main.lua"))()
```
#### Methods

| Method | Description |
| --- | --- |
| `PolyUI:Notify(dict{Title:String,Duration:Number,Image:ImageAsset})` | Notifies the user. |
---
## Making the UI
### Theme
```lua
local Theme = { -- Default Theme
	Background = Color.FromRGB(18, 20, 27), 
	Accent = Color.FromRGB(88, 101, 242), 
	Light = Color.FromRGB(35, 38, 48), 
	Dark = Color.FromRGB(24, 26, 34), 
	Text = Color.FromRGB(235, 238, 245), 
	DragBar = Color.FromRGB(8, 12, 19),
	PlaceholderText = Color.FromRGB(175, 178, 185),
	ObjectBorder = Color.FromRGB(18, 20, 27),
	Font = Enums.FontPreset.Montserrat,
}
```
#### Options

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Background | Color | Color.FromRGB(18, 20, 27) | Main Background color. |
| Accent | Color | Color.FromRGB(88, 101, 242) | A Color that pops out more. |
| Light | Color | Color.FromRGB(35, 38, 48) | Main Lighter color. |
| Dark | Color | Color.FromRGB(24, 26, 34) | Main Darker color. |
| Text | Color | Color.FromRGB(235, 238, 245) | Color of All Text. |
| DragBar | Color | Color.FromRGB(8, 12, 19) | Color of the DragBar.  |
| PlaceholderText | Color | Color.FromRGB(175, 178, 185) | Color of All PlaceholderText.  |
| ObjectBorder | Color | Color.FromRGB(18, 20, 27) | Color of Borders around Inputs, Buttons, etc. |
| Font | Enums.FontPreset | Enums.FontPreset.Montserrat | Font for all Text in the UI. |
---
### Window
```lua
local Window = PolyUI:MakeWindow({
  Title = "PolyUI Example",
})
```
#### Options

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Title | String | "None" | The title displayed at the top of the Window. |
| Toggle | Enums.KeyCode | Enums.KeyCode.K | Button used to Toggle the UI. |
| Theme | Table | Theme | Main Color of everything. |
| SetGlobalTheme | Table | Theme | Sets the Main color of everything outside the Window. Like `:Notify()`. |

#### Methods

| Method | Description |
| --- | --- |
| `Window:Destroy()` | Destroys the Window. |
---
### Tab
```lua
local Tab = Window:MakeTab({
  Title = "Example Tab",
})
```
#### Options

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Title | String | "None" | The title of the button used to select the tab. |
#### Methods

| Method | Description |
| --- | --- |
| `Window:Destroy()` | Destroys the Tab. |
---
### TabBox
```lua
local TabBox = Tab:MakeLeftTabbox({
  Title = "Example Left TabBox"
})
local TabBox = Tab:MakeRightTabbox({
  Title = "Example Right TabBox"
})
```
#### Options

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Title | String | "None" | The title of TabBox. |
#### Methods

| Method | Description |
| --- | --- |
| `Window:Destroy()` | Destroys the TabBox. |
---
### Label
```lua
local Label = TabBox:MakeLabel({
  Content = "Example Label"
}) 
```
#### Options

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Content | String | "None" | The text of the label. |
| MultiLine | Boolean | false | Decides if the Content can split into Multiple Lines. |
#### Methods

| Method | Description |
| --- | --- |
| `Label:Destroy()` | Destroys the Label. |
---
### Button
```lua
local Button = TabBox:MakeButton({
  Title = "Example Button",
  Callback = function()
    print("Button Pressed")
  end
}) 
```
#### Options

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Title | String | "None" | The text of the Button. |
| Callback | Function | nil |  Function to run. |
| DoubleClick | Boolean | false |  Confirm press. |
#### Methods

| Method | Description |
| --- | --- |
| `Button:Destroy()` | Destroys the Button. |
---
### Input
```lua
local Input = TabBox:MakeInput({
  Title = "Example input",
  Callback = function(Value)
    print("Text inputed: "..Value)
  end,
  StartValue = "Example Start"
}) 
```
#### Options

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Title | String | "" | The text above the Input. |
| Placeholder | string | "" |  Placeholder text for the Input. |
| StartValue | string | "" |  Value it starts with. |
| Callback | Function | nil |  Function to run. |
| NumbersOnly | Boolean | false |  Function to run. |
| ClearOnFocus | Boolean | true |  Function to run. |

#### Methods

| Method | Description |
| --- | --- |
| `Input:Destroy()` | Destroys the Input. |
---
### Toggle
```lua
local Toggle = TabBox:MakeToggle({
  Title = "Example Toggle",
  Callback = function(Value)
    print("Toggled: "..Value)
  end,
}) 
```
#### Options

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| Title | String | "" | The text next to the Toggle. |
| StartValue | Boolean | false |  Value it starts with. |
| Callback | Function | nil |  Function to run. |

#### Methods

| Method | Description |
| --- | --- |
| `Toggle:Destroy()` | Destroys the Toggle. |
