local developer, name, game = "1x1ry", "Eclipse", "Universal"

for _, v in pairs({6870736769}) do 
    if game.PlaceId == v then 
        game = tostring(v) 
    end 
end 

local moduleUrls = {
    `https://rawgithubusercontent.com/{developer}/{name}/modules/functions.lua`,
    `https://rawgithubusercontent.com/{developer}/{name}/modules/esp.lua`,
    `https://rawgithubusercontent.com/{developer}/{name}/modules/color.lua`,
    `https://rawgithubusercontent.com/{developer}/{name}/modules/tween.lua`
}

local gameUrl = `https://rawgithubusercontent.com/{developer}/{name}/modules/games/{game}.lua`

getgenv().Modules = {

}