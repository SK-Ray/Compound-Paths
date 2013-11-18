--[[
            imageSplitter.lua
            (c)2013 S.K. Studios, LLC
            R.Delia
            
            This module takes an image and a row, column count to create sprites
--]]
local imageSplitter = {}
local nodeController = require("nodeController")

local function createSpriteSheetData(myImage, xSplits,ySplits)
    
    --set up variables to help us remember where we are in the sprite sheet
    local helper = {}
    helper.sheetX =0
    helper.sheetY = 0
    helper.chunkWidth = math.floor(myImage.width / xSplits)
    helper.chunkHeight = math.floor(myImage.height / ySplits)
    helper.chunkNumber = 1
    
    
    local SheetInfo = {}
    SheetInfo.sheet ={}
    SheetInfo.sheet.frames = {}
    
    for myChunksDown = 1 , ySplits do
        for myChunksAcross = 1 ,xSplits do
            
            SheetInfo.sheet.frames[helper.chunkNumber] =  { x= helper.sheetX, y= helper.sheetY,width = helper.chunkWidth, height = helper.chunkHeight }
            helper.sheetX = helper.sheetX + helper.chunkWidth
            helper.chunkNumber = helper.chunkNumber + 1
            
        end
        helper.sheetX = 0
        helper.sheetY = helper.sheetY + helper.chunkHeight
        
    end
    
    return SheetInfo.sheet
    
end

-- takes filename and image... destroys image 
imageSplitter.splitImage = function(myFilename,mainGroup, myImage,xSplits,ySplits,spriteMesh,nodeHandleRadius)
    
    --grab region of screen , and hold as a temporary image
    local chunkWidth =  math.floor(myImage.width / xSplits)   
    local chunkHeight = math.floor(myImage.height / ySplits)

    
    --[[    
    print("width:", chunkWidth,"height:" , chunkHeight)
    print("xSplits:", xSplits, "ySplits", ySplits)
    --]]
    
    --we need a  function to split this image into multiple sprites
    local getSheetInfo ={}
    getSheetInfo = createSpriteSheetData(myImage,xSplits,ySplits)
    
    local myImageSheet = graphics.newImageSheet(myFilename, getSheetInfo )
    local frame = 0
    for row = 1, ySplits do
        
        for column = 1, xSplits do
            frame = frame + 1
            local myImagePiece = display.newImage( myImageSheet , frame)
            
            mainGroup:insert(myImagePiece)
            local myStartX = myImage.x 
            local  myStartY = myImage.y
            if column <= math.floor(xSplits / 2) then
                myImagePiece.x = myStartX - myImage.width/2 + myImagePiece.width *   column  -- ( myImage1.width/2)
            end
            
            if column > xSplits / 2 then
                myImagePiece.x = myStartX  - myImage.width/2 + myImagePiece.width * column
            end
            
            
            --center x piece
            local z = (xSplits %2)
            if  (column ==math.floor( xSplits / 2) + 1) and (xSplits % 2 == 1) then
                myImagePiece.x = myStartX   
            end
            
            --  
            --    myImage1.x = myStartX -- myImage1.width * i
            myImagePiece.y = myStartY - myImage.height /2   + row * myImagePiece.height
            nodeController.createNodes(spriteMesh,myImagePiece,column,row,nodeHandleRadius,mainGroup)
        end
        
    end
    
    
    nodeController.parentNodeCollection(spriteMesh.nodeCollection)
   nodeController.hideNodes(spriteMesh.nodeCollection)
    myImage:removeSelf()
end


return imageSplitter