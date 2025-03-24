--[=[
    Eclipse
    Daybreak 2 Library

    (you won't find the script here, this just sets up the ui lmao)
]=]


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()
local saveManager, themeManager, Window, Toggles, Options = loadstring(
    game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua")
)(), loadstring(
    game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua")
)(), Library:CreateWindow({
    Title = "Eclipse",
    Footer = "Daybreak 2 - v1.0.0 - discord.gg/",
    Center = true,
    AutoShow = true
}), Library.Options, Library.Toggles 

local Tabs, Boxes = {
    Main = Window:AddTab("Main", "user"),
    Visual = Window:AddTab("Visuals", "user"),
    Misc = Window:AddTab("Miscallaenous", "user"),
    Settings = Window:AddTab("Settings", "settings")
}, {} do 
    local Boxes = {
        aimAssist = Tabs.Main:AddLeftGroupbox("Aim Assist"),
        silentAim = Tabs.Main:AddLeftGroupbox("Silent Aim"),
        player = Tabs.Main:AddRightGroupbox("Player"),
        auto = Tabs.Main:AddRightGroupbox("Automations"),
        esp = Tabs.Visual:AddLeftTabbox(),
        objectEsp = Tabs.Visual:AddRightGroupbox("Objects ESP"),
        world = Tabs.Visual:AddRightTabbox(),
        color = Tabs.Visual:AddRightGroupbox("Color Correction"),
        espSettings = Tabs.Visual:AddLeftGroupbox("ESP Settings"),
        volume = Tabs.Misc:AddLeftGroupbox("Volume"),
        stickers = Tabs.Misc:AddLeftGroupbox("Stickers"),
        quickChats = Tabs.Misc:AddRightGroupbox("Quick Chats"),
        settings = Tabs.Settings:AddRightGroupbox("Settings")
    } 

    do --// #aimAssist
        local Groupbox = Boxes.aimAssist 

        Groupbox:AddToggle("aimAssist", {
            Text = "Enabled"
        }):AddKeyPicker("aimAssistKeybind", {
            Default = "PageUp",
            Text = "Aim Assist",
            Mode = "Hold"
        })

        Groupbox:AddDropdown("aimAssistTarget", {
            Text = "Target Area",
            Multi = true,
            Default = 1,
            Values = {"Head", "Torso", "Arms", "Legs"}
        })

        Groupbox:AddDropdown("aimAssistChecks", {
            Text = "Validation Checks",
            Multi = true,
            Default = 1,
            Values = {"Team", "Visibility"}
        })

        Groupbox:AddSlider("aimAssistSmoothingX", {
            Text = "X Smoothing Factor",
            Min = 0,
            Max = 100,
            Default = 30,
            Suffix = "%",
            HideMax = true
        })

        Groupbox:AddSlider("aimAssistSmoothingY", {
            Text = "Y Smoothing Factor",
            Min = 0,
            Max = 100,
            Default = 30,
            Suffix = "%",
            HideMax = true
        })

        Groupbox:AddToggle("aimAssistFOV", {
            Text = "Show FOV"
        })

        Groupbox:AddToggle("aimAssistFill", {
            Text = "Fill"
        })

        Groupbox:AddSlider("aimAssistFOVRadius", {
            Text = "Radius",
            Min = 0,
            Max = 360,
            Default = 180,
            Suffix = " pixels",
            HideMax = true 
        })
        
    end 

    do --// #silentAim
        local Groupbox = Boxes.silentAim 
        
        Groupbox:AddToggle("silentAim", {
            Text = "Enabled"
        }):AddKeyPicker("silentAimKeybind", {
            Default = "PageUp",
            Text = "Silent Aim",
            Mode = "Hold"
        })

        Groupbox:AddDropdown("silentAimTarget", {
            Text = "Target Area",
            Multi = true,
            Default = 1,
            Values = {"Head", "Torso", "Arms", "Legs"}
        })

        Groupbox:AddDropdown("silentAimChecks", {
            Text = "Validation Checks",
            Multi = true,
            Default = 1,
            Values = {"Team", "Visibility"}
        })

        Groupbox:AddToggle("silentAimFOV", {
            Text = "Show FOV"
        })

        Groupbox:AddToggle("silentAimFill", {
            Text = "Fill"
        })

        Groupbox:AddSlider("silentAimFOVRadius", {
            Text = "Radius",
            Min = 0,
            Max = 360,
            Default = 180,
            Suffix = " pixels",
            HideMax = true 
        })
    end 

    do --// #player 
        local Groupbox = Boxes.player 

        Groupbox:AddToggle("speed", {
            Text = "Speed"
        })

        Groupbox:AddToggle("speedValue", {
            Text = "Value",
            Min = 0,
            Max = 5,
            Default = 0.1,
            Rounding = 3,
            HideMax = true,
            Compact = true,
            Tooltip = "Be careful when setting this at a high value."
        })

        Groupbox:AddDropdown("speedOnly", {
            Text = "Only during",
            Values = {"Always", "Sprinting", "Keybind"},
            Default = 1
        })

        Groupbox:AddToggle("noclip", {
            Text = "Noclip",
            Disabled = false,
            Visible = true
        }):AddKeyPicker("noclipKey", {
            Default = "PageUp",
            SyncToggleState = true,
            Mode = "Toggle",
            Text = "Noclip",
            NoUI = false,
        })
    end 

    do --// #auto
        local Groupbox = Boxes.auto 

        Groupbox:AddToggle("autoSkill", {
            Text = "Skill Checks"
        })

        Groupbox:AddSlider("autoSkillRate", {
            Text = "Success Rate",
            Min = 0,
            Max = 100,
            Default = 100,
            Suffix = "%",
            HideMax = true 
        })

        Groupbox:AddSlider("autoSkillDelay", {
            Text = "Delay",
            Min = 0,
            Max = 5,
            Default = 0,
            Suffix = " ms",
            HideMax = true 
        })
    end 

    do --// #esp
        local Groupbox = Boxes.esp
        local Enemy, Friendly = Groupbox:AddTab("Enemy"), Groupbox:AddTab("Friendly")
        for i = 1, 2 do
            local Path = i == 1 and Enemy or Friendly 
            local Flag = i == 1 and "ESP_Enemy_" or "ESP_Friendly_"
            Path:AddToggle(i == 1 and "ESP_Enemy" or "ESP_Friendly", {Text = "Enabled", Tooltip = "May impact FPS."})
            Path:AddToggle(Flag .. "Box", {Text = "Boxes"}):AddColorPicker(Flag .. "Box_Picker", {Default = Color3.fromRGB(255, 255, 255), Transparency = 0})
            Path:AddToggle(Flag .. "Box_Outline", {Text = "> Outline", Visible = false, Default = true}):AddColorPicker(Flag .. "Box_Outline_Picker", {Default = Color3.fromRGB(0, 0, 0), Transparency = 0})
            Path:AddToggle(Flag .. "3D", {Text = "3D Boxes"}):AddColorPicker(Flag .. "3D_Picker", {Default = Color3.fromRGB(255, 255, 255), Transparency = 0})
            Path:AddToggle(Flag .. "Fill", {Text = "Filled Boxes"}):AddColorPicker(Flag .. "Fill_Picker", {Default = Color3.fromRGB(255, 100, 100), Transparency = 0.5})
            Path:AddToggle(Flag .. "Name", {Text = "Names"}):AddColorPicker(Flag .. "Name_Picker", {Default = Color3.fromRGB(255, 255, 255), Transparency = 0})
            Path:AddToggle(Flag .. "Name_Outline", {Text = "> Outline", Visible = false, Default = true}):AddColorPicker(Flag .. "Name_Outline_Picker", {Default = Color3.fromRGB(0, 0, 0)})
            Path:AddToggle(Flag .. "Distance", {Text = "Distances"}):AddColorPicker(Flag .. "Distance_Picker", {Default = Color3.fromRGB(255, 255, 255), Transparency = 0})
            Path:AddToggle(Flag .. "Distance_Outline", {Text = "> Outline", Visible = false, Default = true}):AddColorPicker(Flag .. "Distance_Outline_Picker", {Default = Color3.fromRGB(0, 0, 0)})
            Path:AddToggle(Flag .. "Weapon", {Text = "Weapons"}):AddColorPicker(Flag .. "Weapon_Picker", {Default = Color3.fromRGB(255, 255, 255), Transparency = 0})
            Path:AddToggle(Flag .. "Weapon_Outline", {Text = "> Outline", Visible = false, Default = true}):AddColorPicker(Flag .. "Weapon_Outline_Picker", {Default = Color3.fromRGB(0, 0, 0)})
            Path:AddToggle(Flag .. "Tracer", {Text = "Tracers"}):AddColorPicker(Flag .. "Tracer_Picker", {Default = Color3.fromRGB(255, 255, 255), Transparency = 0})
            Path:AddToggle(Flag .. "Tracer_Outline", {Text = "> Outline", Visible = false, Default = true}):AddColorPicker(Flag .. "Tracer_Outline_Picker", {Default = Color3.fromRGB(0, 0, 0), Transparency = 0})
            Path:AddDropdown(Flag .. "Tracer_Origin", {Text = "Origin", Visible = false, Values = {"Top", "Middle", "Bottom"}, Default = 1})
            Path:AddToggle(Flag .. "Arrow", {Text = "Offscreen Arrows"}):AddColorPicker(Flag .. "Arrow_Picker", {Default = Color3.fromRGB(255, 100, 100), Transparency = 0})
            Path:AddToggle(Flag .. "Arrow_Outline", {Text = "> Outline", Visible = false, Default = true}):AddColorPicker(Flag .. "Arrow_Outline_Picker", {Default = Color3.fromRGB(0, 0, 0), Transparency = 0})
            Path:AddSlider(Flag .. "Arrow_Radius", { Text = 'Radius', Default = 150, Min = 0, Max = 450, Rounding = 0, Visible = false})
            Path:AddSlider(Flag .. "Arrow_Size", { Text = 'Size', Default = 15, Min = 0, Max = 30, Rounding = 1, Visible = false})
            Path:AddToggle(Flag .. "Chams", {Text = "Chams"}):AddColorPicker(Flag .. "Chams_Picker", {Default = Color3.fromRGB(255, 100, 100), Transparency = 0})
            Path:AddToggle(Flag .. "Chams_Outline", {Text = "> Outline", Visible = false, Default = true}):AddColorPicker(Flag .. "Chams_Outline_Picker", {Default = Color3.fromRGB(255, 255, 255), Transparency = 0})
            Path:AddToggle(Flag .. "Chams_Visible", {Text = "Visible Only", Visible = false})
        end 
    end 

    do --// #objectEsp
        local Groupbox = Boxes.objectEsp 
        Groupbox:AddToggle('objectEspEnabled', { Text = 'Enabled', Default = false}):AddKeyPicker("objects_key", {  Default = "PageUp",  SyncToggleState = true, Mode = "Toggle", Text = "Aim Assist", NoUI = true } )
        Groupbox:AddToggle('objectEspGenerators', { Text = 'Generators', Default = false})
            :AddColorPicker('objectEspGenerator_Picker1', { Default = Color3.fromRGB(255, 255, 255), Transparency = 0})
            :AddColorPicker('objectEspGenerator_Picker2', { Default = Color3.fromRGB(0, 0, 0), Transparency = 0 })
        Groupbox:AddToggle('objectEspVaults', { Text = 'Vaults', Default = false})
            :AddColorPicker('objectEspVaults_Picker1', { Default = Color3.fromRGB(255, 255, 255), Transparency = 0})
            :AddColorPicker('objectEspVaults_Picker2', { Default = Color3.fromRGB(0, 0, 0), Transparency = 0 })
        Groupbox:AddToggle('objectEspMist', { Text = 'Mist Escape', Default = false})
            :AddColorPicker('objectEspMist_Picker1', { Default = Color3.fromRGB(255, 255, 255), Transparency = 0})
            :AddColorPicker('objectEspMist_Picker2', { Default = Color3.fromRGB(0, 0, 0), Transparency = 0 })
        Groupbox:AddToggle('objectEspKiller', { Text = 'Killer Objects', Default = false})
            :AddColorPicker('objectEspKiller_Picker1', { Default = Color3.fromRGB(255, 255, 255), Transparency = 0})
            :AddColorPicker('objectEspKiller_Picker2', { Default = Color3.fromRGB(0, 0, 0), Transparency = 0 })
        Groupbox:AddToggle('objectEspSurvivor', { Text = 'Survivor Objects', Default = false})
            :AddColorPicker('objectEspSurvivor_Picker1', { Default = Color3.fromRGB(255, 255, 255), Transparency = 0})
            :AddColorPicker('objectEspSurvivor_Picker2', { Default = Color3.fromRGB(0, 0, 0), Transparency = 0 })
    end 

    do --// #espSettings 
        local Groupbox = Boxes.espSettings
        Groupbox:AddSlider('ESP_Text_Size', { Text = 'Text Size', Default = 13, Min = 0, Max = 30, Rounding = 1})
        Groupbox:AddDropdown('ESP_Text_Font', { Values = { "1", "2", "3", "4" }, Default = 2, Multi = false, Text = 'Text Font', Tooltip = 'Changes the text font'})
        Groupbox:AddToggle('ESP_Limit_Distance', {Text = "Limit Distance"})
        Groupbox:AddSlider('ESP_Distance', { Text = 'Maximum Distance', Default = 5000, Min = 0, Max = 10000, Rounding = 2})
        Groupbox:AddToggle('ESP_TeamColor', {Text = "Use Team Color"})
        Groupbox:AddDropdown("ESP_Whitelist", {
            SpecialType = "Player",
            ExcludeLocalPlayer = true,
            Text = "Whitelist",
            Multi = true,
            Searchable = true
        })
    end 

    do --// #world, #bloom
        local Groupbox = Boxes.world 
        local World, Bloom = Groupbox:AddTab("World"), Groupbox:AddTab("Bloom")
        do 
            World:AddToggle("lightingAmbient", {
                Text = "Ambience"
            }):AddColorPicker("lighting_ambient_picker", {
                Default = Color3.fromRGB(100, 100, 255),
                Title = "Ambience Color",
            })
    
            World:AddToggle("lightingGlobal", {
                Text = "Global Shadows",
                Default = game:GetService("Lighting").GlobalShadows
            })
    
            World:AddDropdown("lightingTechnology", {
                Values = { "Voxel", "ShadowMap", "Future" },
                Default = string.gsub(tostring(game:GetService("Lighting").Technology), "Enum.Technology.", ""),
                Multi = false,
                Text = "Lighting Technology"
            })
    
            World:AddSlider("lightingBrightness", {
                Text = "Brightness",
                Default = game:GetService("Lighting").Brightness,
                Min = 0, 
                Max = 10,
                HideMax = true,
                Rounding = 0
            })
    
            World:AddSlider("lightingSoftshadow", {
                Text = "Shadow Softness",
                Default = game:GetService("Lighting").ShadowSoftness,
                Min = 0, 
                Max = 10,
                HideMax = true,
                Rounding = 0
            })
        end
    
        do 
            Bloom:AddToggle("bloom", {
                Text = "Bloom"
            })
    
            Bloom:AddSlider("bloomIntensity", {
                Text = "Intensity",
                Default = 0,
                Min = 0, 
                Max = 10,
                HideMax = true,
                Rounding = 0
            })
    
            Bloom:AddSlider("bloomSize", {
                Text = "Size",
                Default = 0,
                Min = 0, 
                Max = 10,
                HideMax = true,
                Rounding = 0
            })
    
            Bloom:AddSlider("bloomThreshold", {
                Text = "Threshold",
                Default = 0,
                Min = 0, 
                Max = 10,
                HideMax = true,
                Rounding = 0
            })
    
        end 
    end 

    do --// #color
        local Groupbox = Boxes.color

        Groupbox:AddToggle("color", {
            Text = "Enabled"
        }):AddColorPicker("color_tint", {
            Default = Color3.fromRGB(100, 100, 255),
            Title = "Color Tint Color",
        })
    
        Groupbox:AddSlider("color_brightness", {
            Text = "Brightness",
            Default = 0,
            Min = 0, 
            Max = 10,
            HideMax = true,
            Rounding = 0
        })
    
        Groupbox:AddSlider("color_contrast", {
            Text = "Contrast",
            Default = 0,
            Min = 0, 
            Max = 10,
            HideMax = true,
            Rounding = 0
        })
    
        Groupbox:AddSlider("color_saturation", {
            Text = "Saturation",
            Default = 0,
            Min = 0, 
            Max = 10,
            HideMax = true,
            Rounding = 0
        })
    end 

    do --// #volume
        local Groupbox = Boxes.volume 

        Groupbox:AddSlider("volume_gen", {
            Text = "Generator Volume",
            Default = 0.5,
            Min = 0,
            Max = 10,
            Rounding = 1
        })

        Groupbox:AddSlider("volume_footstep", {
            Text = "Footstep Volume",
            Default = 0,
            Min = 0,
            Max = 10,
            Rounding = 1
        })

        Groupbox:AddSlider("volume_chase", {
            Text = "Chase Theme Volume",

            Default = 0,
            Min = 0,
            Max = 10,
            Rounding = 1
        })

        Groupbox:AddSlider("volume_ambient", {
            Text = "Ambience Volume",
            Default = 0,
            Min = 0,
            Max = 10,
            Rounding = 1
        })
    end 

    do --// #stickers
        local Groupbox = Boxes.stickers

        Groupbox:AddDropdown("stickersType", {
            Text = "Sticker",
            Values = {"sc_iris", "sc_eiji", "sc_nami"},
            Default = 1
        })

        Groupbox:AddLabel("Keybind"):AddKeyPicker("stickersKey", {
            Default = "PageUp",
            Text = "Send Sticker",
            Mode = "Toggle"
        })

        Groupbox:AddButton({
            Text = "Send Sticker"
        })

    end 

    do --// #quickChats 
        local Groupbox = Boxes.quickChats

        Groupbox:AddDropdown("quickChatType", {
            Text = "Quick Chat",
            Values = {"gen got kicked idk", "rescue me!!", "HELP ME IT HURTS IT FUCKING HURTS "},
            Default = 3
        })

        Groupbox:AddLabel("Keybind"):AddKeyPicker("stickersKey", {
            Default = "PageUp",
            Text = "Send Quick Chat",
            Mode = "Toggle"
        })

        Groupbox:AddButton({
            Text = "Send Quick Chat"
        })
    end 

    do --// #settings
        local Groupbox = Boxes.settings 

        Groupbox:AddToggle("KeybindMenuOpen", {
            Default = Library.KeybindFrame.Visible,
            Text = "Open Keybind Menu",
            Callback = function(value)
                Library.KeybindFrame.Visible = value
            end,
        })
        Groupbox:AddToggle("ShowCustomCursor", {
            Text = "Custom Cursor",
            Default = true,
            Callback = function(Value)
                Library.ShowCustomCursor = Value
            end,
        })
        Groupbox:AddDropdown("NotificationSide", {
            Values = { "Left", "Right" },
            Default = "Right",

            Text = "Notification Side",

            Callback = function(Value)
                Library:SetNotifySide(Value)
            end,
        })
        Groupbox:AddDropdown("DPIDropdown", {
            Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
            Default = "100%",

            Text = "DPI Scale",

            Callback = function(Value)
                Value = Value:gsub("%%", "")
                local DPI = tonumber(Value)

                Library:SetDPIScale(DPI)
            end,
        })
        Groupbox:AddDivider()
        Groupbox:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })

        Groupbox:AddButton("Unload", function()
            Library:Unload()
        end)
    end 

    themeManager:SetLibrary(Library)
    saveManager:SetLibrary(Library)
    saveManager:IgnoreThemeSettings()
    saveManager:SetIgnoreIndexes({ "MenuKeybind" })
    themeManager:SetFolder("Eclipse/Daybreak2/themes")
    saveManager:SetFolder("Eclipse/Daybreak2/configs")
    saveManager:BuildConfigSection(Tabs.Settings)
    themeManager:ApplyToTab(Tabs.Settings)
    saveManager:LoadAutoloadConfig()
end 

Library.ToggleKeybind = Options.MenuKeybind

return Library, Window, Tabs, Toggles, Options 