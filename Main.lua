local PolUI = { 
	version = "Pre-Alpha", 
} 
 
local v2z = Vector2.New(0, 0) 
local cinvis = Color.FromRGB(0, 0, 0, 0) 
local Theme = { 
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
local gui = Instance.New("GUI", world.PlayerGUI) 
gui.Name = "POLUI"
function PolUI:MakeWindow(set) 
	local Window = { 
		self = self, 
		currenttab = nil, 
		settings = { 
			Title = (set and set.Title) or "None", 
			Toggle = (set and set.Toggle) or Enums.KeyCode.K,  
			Theme = (set and set.Theme and { 
				Background = set.Theme.Background or Color.FromRGB(18, 20, 27), 
				Accent = set.Theme.Accent or Color.FromRGB(88, 101, 242), 
				Light = set.Theme.Light or Color.FromRGB(35, 38, 48), 
				Dark = set.Theme.Dark or Color.FromRGB(24, 26, 34), 
				Text = set.Theme.Text or Color.FromRGB(235, 238, 245),
				DragBar = set.Theme.DragBar or Color.FromRGB(8, 12, 19),
				PlaceholderText = set.Theme.PlaceholderText or Color.FromRGB(175, 178, 185),
				ObjectBorder = set.Theme.ObjectBorder or Color.FromRGB(18, 20, 27),
				Font = (set and set.Theme.Font) or Enums.FontPreset.Montserrat,
			}) or { 
				Background = Color.FromRGB(18, 20, 27), 
				Accent = Color.FromRGB(88, 101, 242), 
				Light = Color.FromRGB(35, 38, 48), 
				Dark = Color.FromRGB(24, 26, 34), 
				Text = Color.FromRGB(235, 238, 245),
				DragBar = Color.FromRGB(8, 12, 19),
				PlaceholderText = Color.FromRGB(175, 178, 185),
				ObjectBorder = Color.FromRGB(18, 20, 27),
				Font = Enums.FontPreset.Montserrat,
			}, 
			SetGlobalTheme = not (set and set.SetGlobalTheme == false),
		}, 
	} 
 	local theme = Window.settings.Theme
	if Window.settings.SetGlobalTheme then
		Theme = Window.settings.Theme
	end
	print(Window.settings.SetGlobalTheme)
	local fontass = BuiltInFontAsset.New() 
	fontass.FontPreset = Window.settings.Theme.Font 
 
	local base = Instance.New("UIView", gui) 
	base.SizeOffset = v2z 
	base.SizeRelative = Vector2.New(0.3, 0.3) 
	base.Color = theme.Background 
 
	Input.KeyUp:Connect(function(keycode) 
		if keycode == Window.settings.Toggle then 
			base.Visible = not base.Visible 
		end 
	end) 
 
	local ratio = Instance.New("UIAspectRatioRestraint", base) 
	ratio.AspectRatio = 4 / 3 
 
	local dragger = Instance.New("UIView", base) 
	dragger.SizeOffset = v2z 
	dragger.SizeRelative = Vector2.New(1, 0.1) 
	dragger.PositionRelative = v2z 
	dragger.PivotPoint = v2z 
	dragger.Color = theme.DragBar
 
	local up = true 
 
	dragger.MouseDown:Connect(function() 
		up = false 
 
		local startb = base.PositionOffset 
		local startm = Input.MousePosition 
 
		repeat 
			local now = Input.MousePosition - startm 
			base.PositionOffset = startb + now 
			wait() 
		until up 
	end) 
 
	dragger.MouseUp:Connect(function() 
		up = true 
	end) 
 
	local title = Instance.New("UILabel", dragger) 
	title.Text = Window.settings.Title 
	title.IgnoreMouse = true 
	title.SizeOffset = v2z 
	title.SizeRelative = Vector2.New(0.35, 1) 
	title.PositionRelative = Vector2.New(0.01, 0) 
	title.PivotPoint = v2z 
	title.HorizontalAlignment = Enums.HorizontalAlignment.Left 
	title.FontAsset = fontass 
	title.FontSize = 18 
	title.Color = cinvis 
	title.TextColor = theme.Text 
 
	local tabsel = Instance.New("UIScrollView", base) 
	tabsel.SizeOffset = v2z 
	tabsel.SizeRelative = Vector2.New(1 / 3, 0.9) 
	tabsel.PositionRelative = Vector2.New(0, 0.1) 
	tabsel.PivotPoint = v2z 
 
	local tabseli = Instance.New("UIVLayout", tabsel) 
	tabseli.SizeOffset = v2z 
	tabseli.SizeRelative = Vector2.New(1, 1) 
	tabseli.PositionRelative = v2z 
	tabseli.PivotPoint = v2z 
	tabseli.Spacing = 0 
 
	local tabcon = Instance.New("UIView", base) 
	tabcon.SizeOffset = v2z 
	tabcon.SizeRelative = Vector2.New(2 / 3, 0.9) 
	tabcon.PositionRelative = Vector2.New(1 / 3, 0.1) 
	tabcon.PivotPoint = v2z 
	tabcon.Color = theme.Background 
 
	function Window:Destroy() 
		gui:Destroy() 
		self = {} 
	end 
 
	function Window:MakeTab(set) 
		local Tab = { 
			self = self, 
			settings = { 
				Title = (set and set.Title) or "None", 
			}, 
		} 
 
		local open = Instance.New("UIButton", tabseli) 
		open.SizeOffset = v2z 
		open.SizeRelative = Vector2.New(1, 0.1) 
		open.PositionRelative = v2z 
		open.PivotPoint = v2z 
		open.Color = theme.Light 
		open.TextColor = theme.Text 
		open.Text = Tab.settings.Title 
		open.FontAsset = fontass 
 
		local menu = Instance.New("UIView", tabcon) 
		menu.SizeOffset = v2z 
		menu.SizeRelative = Vector2.New(1, 1) 
		menu.PositionRelative = v2z 
		menu.PivotPoint = v2z 
		menu.Color = theme.Background 
		menu.Visible = false 
		function Tab:Destroy() 
			menu:Destroy()
			open:Destroy()
			self = {} 
		end
 
		if not self.currenttab then 
			self.currenttab = { menu, open } 
			menu.Visible = true 
			open.Color = theme.Accent 
		end 
 
		open.Clicked:Connect(function() 
			if self.currenttab then 
				self.currenttab[1].Visible = false 
				self.currenttab[2].Color = theme.Light 
			end 
 
			menu.Visible = true 
			open.Color = theme.Accent 
			self.currenttab = { menu, open } 
		end) 
 
		local rights = Instance.New("UIScrollView", menu) 
		rights.SizeOffset = v2z 
		rights.SizeRelative = Vector2.New(1 / 2, 1) 
		rights.PositionRelative = Vector2.New(1 / 2, 0) 
		rights.PivotPoint = v2z 
 
		local rightsi = Instance.New("UIVLayout", rights) 
		rightsi.SizeOffset = v2z 
		rightsi.SizeRelative = Vector2.New(1, 1) 
		rightsi.PositionRelative = v2z 
		rightsi.PivotPoint = v2z 
		rightsi.Spacing = 2
 
		local lefts = Instance.New("UIScrollView", menu) 
		lefts.SizeOffset = v2z 
		lefts.SizeRelative = Vector2.New(1 / 2, 1) 
		lefts.PositionRelative = v2z 
		lefts.PivotPoint = v2z 
 
		local leftsi = Instance.New("UIVLayout", lefts) 
		leftsi.SizeOffset = v2z 
		leftsi.SizeRelative = Vector2.New(1, 1) 
		leftsi.PositionRelative = v2z 
		leftsi.PivotPoint = v2z 
		leftsi.Spacing = 2
 
		local function maketabbox(self, par, set) 
			local TabBox = { 
				self = self, 
				settings = { 
					Title = (set and set.Title) or "None", 
				}, 
			} 
 
			local headerHeight = 30 * (Input.ScreenHeight / 1080) 
 
			local container = Instance.New("UIView", par) 
			container.SizeOffset = Vector2.New(0, headerHeight) 
			container.SizeRelative = Vector2.New(1, 0) 
			container.PositionRelative = v2z 
			container.PivotPoint = v2z 
			container.Color = cinvis 
			function TabBox:Destroy()
				container:Destroy()
				self = {}
			end
 
			local bar = Instance.New("UIView", container) 
			bar.SizeOffset = Vector2.New(0, headerHeight) 
			bar.SizeRelative = Vector2.New(1, 0) 
			bar.PositionRelative = v2z 
			bar.PivotPoint = v2z 
			bar.Color = theme.Dark 
 
			local title = Instance.New("UILabel", bar) 
			title.Text = TabBox.settings.Title 
			title.IgnoreMouse = true 
			title.SizeOffset = v2z 
			title.SizeRelative = Vector2.New(0.8, 1) 
			title.PositionRelative = Vector2.New(0.01, 0) 
			title.PivotPoint = v2z 
			title.HorizontalAlignment = Enums.HorizontalAlignment.Left 
			title.FontAsset = fontass 
			title.FontSize = 10 
			title.Color = cinvis 
			title.TextColor = theme.Text 
			
			local mark = Instance.New("UILabel", bar) 
			mark.Text = ">"
			mark.Rotation = 90
			mark.IgnoreMouse = true 
			mark.SizeOffset = v2z 
			mark.SizeRelative = Vector2.New(0.1, 1) 
			mark.PositionRelative = Vector2.New(0.98, 0) 
			mark.PivotPoint = v2z 
			mark.HorizontalAlignment = Enums.HorizontalAlignment.Right
			mark.FontAsset = fontass 
			mark.FontSize = 12
			mark.Color = cinvis 
			mark.TextColor = theme.Text 
			Instance.New("UIAspectRatioRestraint", mark).AspectRatio = 1 
 
			local barb = Instance.New("UIButton", bar) 
			barb.Text = "" 
			barb.Color = cinvis 
			barb.SizeOffset = v2z 
			barb.SizeRelative = Vector2.New(1, 1) 
			barb.PositionRelative = v2z 
			barb.PivotPoint = v2z 
 
			local back = Instance.New("UIView", container) 
			back.SizeOffset = Vector2.New(0, 0) 
			back.SizeRelative = Vector2.New(1, 0) 
			back.PositionOffset = Vector2.New(0, headerHeight) 
			back.PositionRelative = v2z 
			back.PivotPoint = v2z 
			back.Color = theme.Dark 
 
			local SIIZE = 0 
			local buttonHeight = 30 * (Input.ScreenHeight / 1080) 
			local otherHeight = 45 * (Input.ScreenHeight / 1080) 
			local opened = true 
 
			local function update() 
				back.SizeOffset = Vector2.New(0, SIIZE) 
				back.SizeRelative = Vector2.New(1, 0) 
 
				back.PositionOffset = Vector2.New(0, headerHeight) 
				back.PositionRelative = v2z 
 
				if opened then 
					container.SizeOffset = Vector2.New(0, headerHeight + SIIZE) 
					container.SizeRelative = Vector2.New(1, 0) 
				else 
					container.SizeOffset = Vector2.New(0, headerHeight) 
					container.SizeRelative = Vector2.New(1, 0) 
				end 
			end 
 
			barb.Clicked:Connect(function() 
				opened = not opened 
				back.Visible = opened 
				mark.Text = mark.Text == ">" and "<" or ">"
				update() 
			end) 
 			function TabBox:MakeLabel(set) 
				local Label = { 
					self = self, 
					settings = { 
						Content = (set and set.Content) or "None",
						MultiLine = set and set.MultiLine or false,
					}, 
				} 
 
				local lbl = Instance.New("UILabel", back) 
 
				lbl.SizeOffset = Vector2.New(0, buttonHeight) 
				lbl.SizeRelative = Vector2.New(1, 0) 
				lbl.PositionOffset = Vector2.New(0, SIIZE) 
				lbl.PositionRelative = v2z 
				lbl.PivotPoint = v2z 
 
				lbl.TextColor = theme.Text 
				lbl.Color = theme.Dark 
				lbl.Text = Label.settings.Content 
				lbl.FontAsset = fontass 
				lbl.FontSize = 12
 	
				SIIZE = SIIZE + buttonHeight 
				update() 
				function Label:Destroy()
					lbl:Destroy()
					self = {}
					SIIZE = SIIZE - buttonHeight 
					update() 
				end
 
				return Label 
			end 
			function TabBox:MakeButton(set) 
				local Button = { 
					self = self, 
					settings = { 
						Title = (set and set.Title) or "None", 
						Callback = (set and set.Callback) or function() 
							print("Callback missing") 
						end, 
						DoubleClick = set and set.DoubleClick or false,
					}, 
				} 
 
				local fra = Instance.New("UIView", back) 
				fra.SizeOffset = Vector2.New(0, buttonHeight) 
				fra.SizeRelative = Vector2.New(1, 0) 
				fra.PositionOffset = Vector2.New(0, SIIZE) 
				fra.PositionRelative = v2z 
				fra.PivotPoint = v2z 
				fra.Color = theme.Dark 
				local btn = Instance.New("UIButton", fra) 
 
				btn.SizeOffset = v2z
				btn.SizeRelative = Vector2.New(0.9,0.9) 
				btn.PositionOffset = v2z
				btn.PositionRelative = Vector2.New(0.5,0.5)
				btn.PivotPoint = Vector2.New(0.5,0.5)
				btn.BorderWidth = 1
				btn.CornerRadius = 5
 				btn.BorderColor = theme.ObjectBorder
				btn.TextColor = theme.Text 
				btn.Color = theme.Light 
				btn.Text = (Button.settings.Title == "are you sure?" and "are you sure? ") or Button.settings.Title
				btn.FontAsset = fontass 
 				local error = false
				btn.Clicked:Connect(function() 
					if Button.settings.DoubleClick and btn.Text ~= "are you sure?" then
						btn.TextColor = theme.Accent
						btn.Text = "are you sure?"
						wait(1)
						if not error then
							btn.TextColor = theme.Text 
							btn.Text = Button.settings.Title 
							btn.FontSize = 16
						else
							error = false
						end
					else
						local success, err = pcall(Button.settings.Callback) 
	 
						if not success then
							error = true
						 	warn("CALLBACK ERROR: ".. tostring(err))
							btn.TextColor = Color.FromRGB(255, 0, 0) 
							btn.Text = "CALLBACK ERROR: check console"
							btn.FontSize = 10
	 
							wait(3) 
	 
							btn.TextColor = theme.Text 
							btn.Text = Button.settings.Title 
							btn.FontSize = 16
						end 
					end
				end) 
 
				SIIZE = SIIZE + buttonHeight 
				update() 
				function Button:Destroy()
					fra:Destroy()
					self = {}
					SIIZE = SIIZE - buttonHeight 
					update() 
				end
 
				return Button 
			end 
			
			function TabBox:MakeInput(set) 
				local Input = { 
					self = self, 
					settings = { 
						Title = (set and set.Title) or "", 
						Placeholder = (set and set.Placeholder) or "",
						StartValue = (set and set.StartValue) or "",
						Callback = (set and set.Callback) or function(Value) 
							print("Callback missing") 
						end, 
						NumbersOnly = (set and set.NumbersOnly) or false,
						ClearOnFocus = not (set and set.ClearOnFocus == false),
					}, 
				} 
				function cleanNumber(str)
			    local cleaned = str:gsub("[^0-9.]", "")
			    return tonumber(cleaned)
			end
				local value = Input.StartValue
 
				local fra = Instance.New("UIView", back) 
				fra.SizeOffset = Vector2.New(0, otherHeight) 
				fra.SizeRelative = Vector2.New(1, 0) 
				fra.PositionOffset = Vector2.New(0, SIIZE) 
				fra.PositionRelative = v2z 
				fra.PivotPoint = v2z 
				fra.Color = theme.Dark 
				local lbl = Instance.New("UITextInput", fra) 
				lbl.SizeOffset = v2z
				lbl.SizeRelative = Vector2.New(0.9,0.9*buttonHeight/otherHeight) 
				lbl.PositionOffset = v2z
				lbl.PositionRelative = Vector2.New(0.5,0.95)
				lbl.PivotPoint = Vector2.New(0.5,1)
				lbl.BorderWidth = 1
				lbl.CornerRadius = 5
 
				lbl.TextColor = theme.Text 
				lbl.Color = theme.Light 
				lbl.PlaceholderColor = theme.PlaceholderText
				lbl.BorderColor = theme.ObjectBorder
				lbl.Text = Input.settings.NumbersOnly and cleanNumber(Input.settings.StartValue) or Input.settings.StartValue
				lbl.Placeholder = Input.settings.Placeholder
				lbl.FontAsset = fontass
				local title = Instance.New("UILabel", fra)
				title.SizeOffset = v2z
				title.SizeRelative = Vector2.New(0.9,0.05) 
				title.PositionOffset = v2z
				title.PositionRelative = Vector2.New(0.5,0)
				title.PivotPoint = Vector2.New(0.5,0)
				title.TextColor = theme.Text 
				title.Color = cinvis
				title.Text = Input.settings.Title
				title.FontAsset = fontass
				title.FontSize = 10
				title.HorizontalAlignment = Enums.HorizontalAlignment.Left
				title.VerticalAlignment = Enums.VerticalAlignment.Top
 				lbl.FocusEnter:Connect(function()
					if Input.settings.ClearOnFocus then
						lbl.Text = ""
					end
				end)
				--[[cant use
				lbl.Changed:Connect(function()
					if Input.settings.NumbersOnly then
						local pos = lbl.cursorpos
						lbl.Text = lbl.Text:gsub("[^0-9.]", "")
						value = lbl.Text
						lbl.cursorpos = pos + 1
					end
				end)
				]]
				lbl.Submitted:Connect(function()
					lbl.Text = lbl.Text:gsub("[^0-9.]", "")
					value = lbl.Text
					local success, err = pcall(Input.settings.Callback, value) 
	 
					if not success then
					 	warn("CALLBACK ERROR: ".. tostring(err))
					end
				end)
				SIIZE = SIIZE + otherHeight 
				update()
				function Input:Destroy()
					fra:Destroy()
					self = {}
					SIIZE = SIIZE - otherHeight 
					update() 
				end 
 
				return Input 
			end
				
			function TabBox:MakeToggle(set) 
				local Toggle = { 
					self = self, 
					settings = { 
						Title = (set and set.Title) or "None", 
						Callback = (set and set.Callback) or function(Value) 
							print("Callback missing") 
						end, 
						StartValue = (set and set.StartValue) or false,
					}, 
				} 
				local value = Toggle.StartValue
 
				local fra = Instance.New("UIView", back) 
				fra.SizeOffset = Vector2.New(0, buttonHeight) 
				fra.SizeRelative = Vector2.New(1, 0) 
				fra.PositionOffset = Vector2.New(0, SIIZE) 
				fra.PositionRelative = v2z 
				fra.PivotPoint = v2z 
				fra.Color = theme.Dark 
				local lbl = Instance.New("UILabel", fra) 
				
				lbl.SizeOffset = v2z
				lbl.SizeRelative = Vector2.New(0.8,0.9) 
				lbl.PositionOffset = v2z
				lbl.PositionRelative = Vector2.New(0.4,0.5)
				lbl.PivotPoint = Vector2.New(0.5,0.5)
				lbl.Color = theme.Dark
				lbl.Text = Toggle.settings.Title
				lbl.TextColor = theme.Text
 				local hld = Instance.New("UIView", lbl) 
				Instance.New("UIAspectRatioRestraint", hld).AspectRatio = 2 / 1 
				hld.CornerRadius = 10
				hld.SizeOffset = v2z
				hld.SizeRelative = Vector2.New(0.2,1) 
				hld.PositionOffset = v2z
				hld.PositionRelative = Vector2.New(1.025,0.5)
				hld.PivotPoint = Vector2.New(0,0.5)

				if value then
					hld.Color = theme.Accent
				else
					hld.Color = theme.Light
				end
				local cir = Instance.New("UIView", hld)
				local thing = 0.8
				cir.CornerRadius = 10
				cir.SizeOffset = v2z
				cir.SizeRelative = Vector2.New(0.5*thing,1*thing) 
				cir.PositionOffset = v2z
				cir.PositionRelative = Vector2.New(1,0.5)
				cir.PivotPoint = Vector2.New(1,0.5)
				if value then
					cir.PositionRelative = Vector2.New(1-thing/10,0.5)
					cir.PivotPoint = Vector2.New(1,0.5)
				else
					cir.PositionRelative = Vector2.New(thing/10,0.5)
					cir.PivotPoint = Vector2.New(0,0.5)
				end
				local btn = Instance.New("UIButton", hld)
				btn.SizeOffset = v2z
				btn.SizeRelative = Vector2.New(1,1) 
				btn.PositionOffset = v2z
				btn.PositionRelative = Vector2.New(0.5,0.5)
				btn.PivotPoint = Vector2.New(0.5,0.5)
				btn.CornerRadius = 5
				btn.Color = cinvis
				btn.Text = ""
 				local error = false
				btn.Clicked:Connect(function() 
					value = not value
					if value then
						hld.Color = theme.Accent
					else
						hld.Color = theme.Light
					end
					if value then
						cir.PositionRelative = Vector2.New(1-thing/10,0.5)
						cir.PivotPoint = Vector2.New(1,0.5)
					else
						cir.PositionRelative = Vector2.New(thing/10,0.5)
						cir.PivotPoint = Vector2.New(0,0.5)
					end
					local sucess, err = pcall(Toggle.settings.Callback, value)
					if not sucess then
					 	warn("CALLBACK ERROR: ".. tostring(err))
					end
				end) 
 
				SIIZE = SIIZE + otherHeight 
				update() 
				function Toggle:Destroy()
					fra:Destroy()
					self = {}
					SIIZE = SIIZE - otherHeight 
					update() 
				end
 
				return Toggle 
			end
 
			update() 
 
			return TabBox 
		end 
 
		function Tab:MakeLeftTabbox(set) 
			return maketabbox(self, leftsi, set) 
		end 
 
		function Tab:MakeRightTabbox(set) 
			return maketabbox(self, rightsi, set) 
		end 
 
		return Tab 
	end 
 
	return Window 
end 

local tabseli = Instance.New("UIVLayout", gui)
tabseli.SizeOffset = v2z 
tabseli.SizeRelative = Vector2.New(0.15, 0.9)
tabseli.PositionRelative = Vector2.New(1, 0.5)
tabseli.PivotPoint = Vector2.New(1, 0.5)
tabseli.Spacing = 8
tabseli.ChildAlignment = Enums.UILayoutAlignment.End

function PolUI:Notify(set)
    spawn(function()
				if set and set.Image then
					local fontass = BuiltInFontAsset.New() 
					fontass.FontPreset = Theme.Font 
	        local notif = Instance.New("UIView", tabseli)
	        notif.SizeRelative = Vector2.New(1, 0.15)
					notif.SizeOffset = v2z 
					notif.Color = Theme.Dark
					local title = Instance.New("UILabel", notif)
					title.Text = (set and set.Title) or "None"
					title.PositionOffset = v2z
					title.SizeOffset = v2z 
					title.FontAsset = fontass
					title.SizeRelative = Vector2.New(1-7/16, 0.3)
					title.PositionRelative = Vector2.New(7/16, 0)
					title.PivotPoint = v2z
					title.Color = cinvis
					title.TextColor = Theme.Text
					local sub = Instance.New("UILabel", notif)
					sub.Text = (set and set.SubTitle) or "None"
					sub.FontSize = 10
					sub.PositionOffset = v2z
					sub.SizeOffset = v2z 
					sub.FontAsset = fontass
					sub.SizeRelative = Vector2.New(1-7/16, 1-0.3)
					sub.PositionRelative = Vector2.New(7/16, 0.3)
					sub.PivotPoint = v2z
					sub.Color = cinvis
					sub.TextColor = Theme.Text
					local image = Instance.New("UIImage", notif)
					image.SizeOffset = v2z 
					image.SizeRelative = Vector2.New(7/16*0.95, 1*0.95)
					image.PositionRelative = Vector2.New((7/16/0.95)*0.5, 0.5)
					image.PositionOffset = v2z
					image.PivotPoint = Vector2.New(0, 0.5)
					image.Image = set.Image
					Instance.New("UIAspectRatioRestraint", notif).AspectRatio = 16/7
	        wait((set and set.Duration) or 3)
	        notif:Destroy()
				else
					local fontass = BuiltInFontAsset.New() 
					fontass.FontPreset = Theme.Font 
	        local notif = Instance.New("UIView", tabseli)
	        notif.SizeRelative = Vector2.New(1, 0.15)
					notif.SizeOffset = v2z
					notif.Color = Theme.Dark 
					local title = Instance.New("UILabel", notif)
					title.Text = (set and set.Title) or "None"
					title.SizeOffset = v2z 
					title.PositionOffset = v2z
					title.FontAsset = fontass
					title.SizeRelative = Vector2.New(1, 0.3)
					title.PositionRelative = v2z
					title.PivotPoint = v2z
					title.Color = cinvis
					title.TextColor = Theme.Text
					local sub = Instance.New("UILabel", notif)
					sub.Text = (set and set.SubTitle) or "None"
					sub.FontSize = 10
					sub.PositionOffset = v2z
					sub.SizeOffset = v2z 
					sub.FontAsset = fontass
					sub.SizeRelative = Vector2.New(1, 1-0.3)
					sub.PositionRelative = Vector2.New(0, 0.3)
					sub.PivotPoint = v2z
					sub.Color = cinvis
					sub.TextColor = Theme.Text
					Instance.New("UIAspectRatioRestraint", notif).AspectRatio = 16/7
	        wait((set and set.Duration) or 3)
	        notif:Destroy()
				end
    end)
end

return PolUI
