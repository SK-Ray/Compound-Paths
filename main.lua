--[[
        Corona SDK Graphics 2.0 Mesh Test
        (c) 2013 S.K. Studios, LLC
        
        
        
--]]

--[]
display.setDefault( "minTextureFilter", "linear" )
display.setDefault( "magTextureFilter", "linear" )
--]]

local sd = require("screenDimensions")
local mt = require("meshTransitions")
local spriteMeshController = require("spriteMesh")



local myFilename = "coronaicon.png"
local myFilename2 = "CoronaGeek_side.png"

local splitColumns, splitRows  = 10,1
local delayShift = 610
local timeShift =400
local pixelShift = -180


local spriteMesh = spriteMeshController.new({fileName = myFilename , columns = splitColumns,rows = splitRows, useEnterframe = true})


spriteMesh.myEnterFrame = function(self,event)
    
    if spriteMesh.useEnterframe == true then
        
    else
        return
    end
    spriteMesh.deltaTime = event.time  - spriteMesh.lastTime
    spriteMesh.lastTime = event.time
    --we can manipulate the chunkmap my pulling the image's row and column'
    
    for myRows =  self.rows,1,-1 do
        
        
        for myShifts = self.columns ,1,-1 do
            
            
            local   chunk =  spriteMesh.chunkMap[myRows.."x"][myShifts.."x"].DO
            local   chunkRight =  chunk --chunkMap[myRows.."x"][(myShifts + 1) .."x"].DO
            
            
            --factor for exact width of columns
            local pixelFactor = spriteMesh.image.width / spriteMesh.columns
            
            local pixelFactorX = 60
            local pixelFactorY = 50
            local addToX =- math.sin(event.time / timeShift) * pixelFactorX
            local addToY = math.cos(event.time / timeShift) * pixelFactorY
            
            
            chunk.image.path.x1 = addToX
            --         chunk.image.path.x2 = addToX
            --           chunk.image.path.x3 = addToX
            chunk.image.path.x4=  addToX
            
            chunk.image.path.y1 = addToY
            --   chunk.image.path.y2 = addToY
            --   chunk.image.path.y3 = addToY
            chunk.image.path.y4=  addToY
            
            
        end
    end
end

--stop enterframe animation after 5 seconds
timer.performWithDelay(3000, function() spriteMesh.useEnterframe  = false end, 1)

timer.performWithDelay(8000, function() spriteMesh.useEnterframe  = true end, 1)



--shorten up the animation chain addition
local addAnim = spriteMesh.animationChain.add

--[ -- working set]

addAnim(3035,3000,spriteMesh, mt.transition3, {pixelShiftX = 400, pixelShiftY = -0, delayShift = 125, timeShift = 350})  -- fold right
addAnim(35,3000,spriteMesh, mt.transition3, {pixelShiftX = -400, pixelShiftY =-0, delayShift = 125, timeShift= 260})       --slime left
                                
addAnim(35,3000,spriteMesh, mt.transition1, {pixelShiftX = -300, pixelShiftY = 0, delayShift = 125, timeShift = 250})               
addAnim(35,3000,spriteMesh, mt.transition1, {pixelShiftX = 300, pixelShiftY = -100, delayShift = 125, timeShift =250})   
--]]



addAnim(15,30,spriteMesh, mt.RayTest, {pixelShiftX = 400, pixelShiftY =-00, delayShift = 1000, timeShift = 200})    --magic mirror


--[

addAnim(15,30,spriteMesh, mt.slimeRight, {pixelShiftX = -400, pixelShiftY =-100, delayShift = 500, timeShift = 1900})    --compressed slime?
addAnim(15,30,spriteMesh, mt.slimeRight, {pixelShiftX = 400, pixelShiftY =20, delayShift = 500, timeShift = 1000})    --melt down
--]]


--[

--[--test                 
addAnim(211,2000,spriteMesh, mt.sliceLeft, {pixelShiftX = 100, pixelShiftY =100, delayShift = 50, timeShift = 1000})    
addAnim(211,2000,spriteMesh, mt.sliceLeft, {pixelShiftX = -100, pixelShiftY =30, delayShift = 500, timeShift = 1000})    

addAnim(15,30,spriteMesh, mt.slimeRight, {pixelShiftX = 00, pixelShiftY =-100, delayShift = 800, timeShift = 19000})    --compressed slime?

--]]





spriteMesh.center()
local mainGroup = spriteMesh.mainGroup
mainGroup.x, mainGroup.y = display.contentCenterX - mainGroup.width /2,display.contentCenterY -(mainGroup.height  )/2
--transition.to(mainGroup,{delay = 1003, time = 60000, rotation = 3600})




