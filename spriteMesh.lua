--[[
        spriteMesh.lua
        (c)2013 S.K. Studios, LLC
        www.stinkykitties.com
        R.Delia
        
        
        -Input:  File with path, cols, rows
        -Output: table with notable objects:  .chunkMap  .group .effectFunctions effectQue
        
--]]

local sd = require("screenDimensions") 
local nodeController = require("nodeController")
local imageSplitter = require("imageSplitter")
local spriteMeshController = {}
local transitionController = require("transitionController")

spriteMeshController.new = function(params)
    
    local spriteMesh = {}    --This is the thing we need to populate and send back
    local useEnterframe = params.useEnterframe or false
    spriteMesh.useEnterframe = useEnterframe
    spriteMesh.animationChain = transitionController.new()
    local mesh = {}
    local nodeCollection = {}
    spriteMesh.nodeCollection = nodeCollection
    --Create initial image
    local myFilename = params.fileName
    local myGroup  = params.group or  display.newGroup()
    myGroup.anchorChildren = true 
    spriteMesh.mainGroup = myGroup
    myGroup.anchorX = 0.5
    myGroup.anchorY = 0.5
    
    
    
    local  myImage = display.newImage(myFilename,0,0)
    spriteMesh.image = {}
    spriteMesh.image.width = myImage.width
    spriteMesh.image.height = myImage.height
    
    
    
    --TODO Remove myGroup if I don't need it
    myGroup:insert(myImage)
    
    local splitColumns = params.columns or  1
    spriteMesh.columns = splitColumns
    local splitRows = params.rows or 1
    spriteMesh.rows = splitRows
    
    local chunkWidth =  math.floor(myImage.width / splitColumns)   
    local chunkHeight = math.floor(myImage.height / splitRows)
    spriteMesh.chunkWidth = chunkWidth
    spriteMesh.chunkHeight = chunkHeight
    
    local nodeHandleRadius = params.nodeHandleRadius or  25
    
    
    
    local chunkMap = {}
    for j = 1 ,splitRows  do
        chunkMap[j.."x"] = {}  
        for i = 1,splitColumns  do
            chunkMap[j.."x"][i.."x"] = {}
        end
        
        
    end
    spriteMesh.chunkMap = chunkMap
    
    
    local nodeTouched = nil
    
    
    spriteMesh.mainGroup = myGroup
    
    
    spriteMesh.splitImages = imageSplitter.splitImage(myFilename,spriteMesh.mainGroup, myImage, splitColumns, splitRows,spriteMesh, nodeHandleRadius)
    
    spriteMesh.center = function()
        spriteMesh.mainGroup.anchorX = .5
        spriteMesh.mainGroup.anchorY = .5
        
        --[
        spriteMesh.mainGroup.x = display.contentCenterX - spriteMesh.mainGroup.width /2  - spriteMesh.chunkWidth / 1.5  +48 -- - spriteMesh.columns   * spriteMesh.chunkWidth /2  --- spriteMesh.mainGroup.width /2 
        spriteMesh.mainGroup.y = display.contentCenterY - spriteMesh.mainGroup.height /2 - spriteMesh.chunkHeight / 1.5 + 48-- + 50-- - spriteMesh.mainGroup.height /2 
        --]]
        
        --[[]
        spriteMesh.mainGroup.x = sd.centerX - myGroup.width /2
        spriteMesh.mainGroup.y = sd.centerY - myGroup.height /2
        
        
        --]]
    end
    
    spriteMesh.lastTime = 0
    
    spriteMesh.myEnterFrame = function(self,event)
        
        print("You probably want to override me!")
        
    end
    

    
    spriteMesh.enterFrame = function(self, event)
        
        if spriteMesh.useEnterframe == true then
            spriteMesh.myEnterFrame(self,event)
        else
            return
        end
        
    end
    
    
    
    Runtime:addEventListener( "enterFrame", spriteMesh )
    
    
    return spriteMesh   --sprite mesh object coming back at you
    
end




-- finally return the controller, so that we may use it
return spriteMeshController
