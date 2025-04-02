local Services, Library = {}, {
    Directory = "Eclipse",
    Connections = {},
    Drawings = {},
    Instances = {},
    unloadFunctions = {}
}; setmetatable(Services, {
    __index = function(self, key)
        return cloneref and cloneref(game:GetService(Key)) or game:GetService(Key)
    end 
})

function Library:Instance(Type : string, Properties : table, Index : string)
    local newInstance = Instance.new(Type)

    for key, value in next Properties do 
        newInstance[key] = value 
    end; self.Instances[Index and Index or #self.Instances] = newInstance

    return newInstance 
end 

function Library:Drawing(Type : string, Properties : table, Index : string)
    local newDrawing = Drawing.new(Type)

    for key, value in next Properties do 
        newDrawing[key] = value 
    end; self.Drawings[Index and Index or #self.Drawings] = newDrawing 

    return newDrawing 
end 

function Library:Connection(Signal, Callback, Index)
    self.Connections
end

function Library:buildFolderTree(Config : table)
    assert(makefolder, "Executor doesn't support makefolder")
    assert(writefile, "Executor doesn't support writefile")

    for _, folderName in next Config.Folders do 
        if not isfolder(folderName) then
            makefolder(folderName)
        end 
    end 

    for _, file in next Config.Files do 
        local name = file.Name or file.name or file[1]
        local content = file.Content or file.content or file[2]

        if isfile(name) then
            appendfile(name, content)
        else
            writefile(name, content)
        end 
    end 
end 

function Library:getMouseLocation()
    return Mouse 
end 

function Library:worldToViewportPoint(Object : instance)
    return Camera:WorldToViewportPoint(Object)
end 

function Library:worldToScreenPoint(Object : instance)
    return Camera:WorldToScreenPoint(Object)
end 

function Library:Unload()
    for _, v in next self.Connections do 
        v:Disconnect()
    end 

    for _, v in next, self.Instances do 
        v:Destroy()
    end 

    for _, v in next, self.unloadFunctions do 
        v()
    end
    
    cleardrawingcache()

    Library = nil 
end 

function Library:setUnload(Function : function)
    table.insert(self.unloadFunctions, Function)
end 
