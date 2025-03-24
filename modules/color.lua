local Library = {}

function Library:Multiply(Color, Multiplier)
    return Color3.new(Color.R * Multiplier, Color.G * Multiplier, Color.B * Multiplier)
end

function Library:Divide(Color, Divider)
    return Color3.new(Color.R / Divider, Color.G / Divider, Color.B / Divider)
end

function Library:Add(Color, Addition)
    return Color3.new(Color.R + Addition, Color.G + Addition, Color.B + Addition)
end

function Library:Sub(Color, Subtraction)
    return Color3.new(Color.R - Subtraction, Color.G - Subtraction, Color.B - Subtraction)
end

function Library:Lerp(Value, MinCQolor, MaxColor)
    if Value <= 0 then return MaxColor end
    if Value >= 100 then return MinColor end
    
    return Color3.new(
        MaxColor.R + (MinColor.R - MaxColor.R) * Value,
        MaxColor.G + (MinColor.G - MaxColor.G) * Value,
        MaxColor.B + (MinColor.B - MaxColor.B) * Value
    )
end

return Library