local Library = {
    EasingStyles = {
        ["Enum.EasingStyle.Linear"] = {
            ["In"] = function(Delta) return Delta end,
    
            ["Out"] = function(Delta) return Delta end,
    
            ["InOut"] = function(Delta) return Delta end
        },
        ["Enum.EasingStyle.Cubic"] = {
            ["In"] = function(Delta)
                return Delta^3
            end,
    
            ["Out"] = function(Delta)
                return (Delta - 1)^3 + 1
            end,
    
            ["InOut"] = function(Delta)
                if Delta <= 0.5 then
                    return (4 * Delta)^3
                else
                    return (4 * (Delta - 1))^3 + 1
                end
            end
        },
        ["Enum.EasingStyle.Quad"] = {
            ["In"] = function(Delta)
                return Delta^2
            end,
    
            ["Out"] = function(Delta)
                return -(Delta - 1)^2 + 1
            end,
    
            ["InOut"] = function(Delta)
                if Delta <= 0.5 then
                    return (2 * Delta)^2
                else
                    return (-2 * (Delta - 1))^2 + 1
                end
            end
        },
        ["Enum.EasingStyle.Quart"] = {
            ["In"] = function(Delta)
                return Delta^4
            end,
    
            ["Out"] = function(Delta)
                return -(Delta - 1)^4 + 1
            end,
    
            ["InOut"] = function(Delta)
                if Delta <= 0.5 then
                    return (8 * Delta)^4
                else
                    return (-8 * (Delta - 1))^4 + 1
                end
            end
        },
        ["Enum.EasingStyle.Quint"] = {
            ["In"] = function(Delta)
                return Delta^5
            end,
            ["Out"] = function(Delta)
                return (Delta - 1)^5 + 1
            end,
            ["InOut"] = function(Delta)
                if Delta <= 0.5 then
                    return (16 * Delta)^5
                else
                    return (16 * (Delta - 1))^5 + 1
                end
            end
        },
        ["Enum.EasingStyle.Sine"] = {
            ["In"] = function(Delta)
                return Sin(Halfpi * Delta - Halfpi)
            end,
    
            ["Out"] = function(Delta)
                return Sin(Halfpi * Delta)
            end,
    
            ["InOut"] = function(Delta)
                return 0.5 * Sin(Pi * Delta - Halfpi) + 0.5
            end
        },
        ["Enum.EasingStyle.Exponential"] = {
            ["In"] = function(Delta)
                return 2^(10 * Delta - 10) - 0.001
            end,
            ["Out"] = function(Delta)
                return 1.001 * -2^(-10 * Delta) + 1
            end,
            ["InOut"] = function(Delta)
                if Delta <= 0.5 then
                    return 0.5 * 2^(20 * Delta - 10) - 0.0005
                else
                    return 0.50025 * -2^(-20 * Delta + 10) + 1
                end
            end
        },
        ["Enum.EasingStyle.Back"] = {
            ["In"] = function(Delta)
                return Delta^2 * (Delta * (1.70158 + 1) - 1.70158)
            end,
            ["Out"] = function(Delta)
                return (Delta - 1)^2 * ((Delta - 1) * (1.70158 + 1) + 1.70158) + 1
            end,
            ["InOut"] = function(Delta)
                if Delta <= 0.5 then
                    return (2 * Delta * Delta) * ((2 * Delta) * (2.5949095 + 1) - 2.5949095)
                else
                    return 0.5 * ((Delta * 2) - 2)^2 * ((Delta * 2 - 2) * (2.5949095 + 1) + 2.5949095) + 1
                end
            end
        },
        ["Enum.EasingStyle.Bounce"] = {
            ["In"] = function(Delta)
                if Delta <= 0.25 / 2.75 then
                    return -7.5625 * (1 - Delta - 2.625 / 2.75)^2 + 0.015625
                elseif Delta <= 0.75 / 2.75 then
                    return -7.5625 * (1 - Delta - 2.25 / 2.75)^2 + 0.0625
                elseif Delta <= 1.75 / 2.75 then
                    return -7.5625 * (1 - Delta - 1.5 / 2.75)^2 + 0.25
                else
                    return 1 - 7.5625 * (1 - Delta)^2
                end
            end,
            ["Out"] = function(Delta)
                if Delta <= 1 / 2.75 then
                    return 7.5625 * (Delta * Delta)
                elseif Delta <= 2 / 2.75 then
                    return 7.5625 * (Delta - 1.5 / 2.75)^2 + 0.75
                elseif Delta <= 2.5 / 2.75 then
                    return 7.5625 * (Delta - 2.25 / 2.75)^2 + 0.9375
                else
                    return 7.5625 * (Delta - 2.625 / 2.75)^2 + 0.984375
                end
            end,
            ["InOut"] = function(Delta)
                if Delta <= 0.125 / 2.75 then
                    return 0.5 * (-7.5625 * (1 - Delta * 2 - 2.625 / 2.75)^2 + 0.015625)
                elseif Delta <= 0.375 / 2.75 then
                    return 0.5 * (-7.5625 * (1 - Delta * 2 - 2.25 / 2.75)^2 + 0.0625)
                elseif Delta <= 0.875 / 2.75 then
                    return 0.5 * (-7.5625 * (1 - Delta * 2 - 1.5 / 2.75)^2 + 0.25)
                elseif Delta <= 0.5 then
                    return 0.5 * (1 - 7.5625 * (1 - Delta * 2)^2)
                elseif Delta <= 1.875 / 2.75 then
                    return 0.5 + 3.78125 * (2 * Delta - 1)^2
                elseif Delta <= 2.375 / 2.75 then
                    return 3.78125 * (2 * Delta - 4.25 / 2.75)^2 + 0.875
                elseif Delta <= 2.625 / 2.75 then
                    return 3.78125 * (2 * Delta - 5 / 2.75)^2 + 0.96875
                else
                    return 3.78125 * (2 * Delta - 5.375 / 2.75)^2 + 0.9921875
                end
            end
        },
        ["Enum.EasingStyle.Elastic"] = {
            ["In"] = function(Delta)
                return -2^(10 * (Delta - 1)) * Sin(Pi * 2 * (Delta - 1 - 0.3 / 4) / 0.3)
            end,
    
            ["Out"] = function(Delta)
                return 2^(-10 * Delta) * Sin(Pi * 2 * (Delta - 0.3 / 4) / 0.3) + 1
            end,
    
            ["InOut"] = function(Delta)
                if Delta <= 0.5 then
                    return -0.5 * 2^(20 * Delta - 10) * Sin(Pi * 2 * (Delta * 2 - 1.1125) / 0.45)
                else
                    return 0.5 * 2^(-20 * Delta + 10) * Sin(Pi * 2 * (Delta * 2 - 1.1125) / 0.45) + 1
                end
            end
        },
        ["Enum.EasingStyle.Circular"] = {
            ["In"] = function(Delta)
                return -Sqrt(1 - Delta^2) + 1
            end,
    
            ["Out"] = function(Delta)
                return Sqrt(-(Delta - 1)^2 + 1)
            end,
    
            ["InOut"] = function(Delta)
                if Delta <= 0.5 then
                    return -Sqrt(-Delta^2 + 0.25) + 0.5
                else
                    return Sqrt(-(Delta - 1)^2 + 0.25) + 0.5
                end
            end
        }
    }
}, 

Library.__index = Library

function Library.new(instance, properties, duration, easingStyle, easingDirection)
    local self = setmetatable({}, Library)
    self.instance = instance
    self.properties = properties
    self.duration = duration or 1
    self.easingStyle = easingStyle or Enum.EasingStyle.Linear
    self.easingDirection = easingDirection or Enum.EasingDirection.InOut
    self.tween = nil
    self.onPlay = nil
    self.onPause = nil
    self.onCancel = nil
    self.onDestroy = nil
    return self
end

function Library:Initalize()
    local tweenInfo = TweenInfo.new(
        self.duration,
        self.easingStyle,
        self.easingDirection
    )
    self.tween = tweenService:Create(self.instance, tweenInfo, self.properties)
end

function Library:Play()
    if self.tween then
        self.tween:Play()
        if self.onPlay then
            self.onPlay(self)
        end
    end
end

function Library:Pause()
    if self.tween then
        self.tween:Pause()
        if self.onPause then
            self.onPause(self)
        end
    end
end

function Library:Cancel()
    if self.tween then
        self.tween:Cancel()
        if self.onCancel then
            self.onCancel(self)
        end
    end
end

function Library:Destroy()
    if self.tween then
        self.tween:Destroy()
        if self.onDestroy then
            self.onDestroy(self)
        end
        self.tween = nil
    end
end

function Library:setCallback(event, callback)
    if event == "Play" then
        self.onPlay = callback
    elseif event == "Pause" then
        self.onPause = callback
    elseif event == "Cancel" then
        self.onCancel = callback
    elseif event == "Destroy" then
        self.onDestroy = callback
    end
end

function Library:Create(instance, properties, duration, easingStyle, easingDirection)
    local Tween = Library.new(instance, properties, duration, easingStyle, easingDirection)
    Tween:Initalize()
    Tween:Play()
    return Tween
end

return Library 