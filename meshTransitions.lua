--[[
        Mesh Transitions
        (c) 2013 Stinky Kitty Studios
        
--]]

local math = math
local meshTransitions = {}


-- Initial standard transisions
meshTransitions.transition1 =function(spriteMesh, params,calcOnly)
    local params = params or {}
    local  splitColumns = spriteMesh.columns 
    local  splitRows = spriteMesh.rows or 1
    
    local chunkMap = spriteMesh.chunkMap
    local delayShift = params.delayShift or 1000
    local timeShift = params.timeShift or 3000
    local pixelShiftX = params.pixelShiftX or 1000
    local pixelShiftY = params.pixelShiftY or 1000
    local myTransition1 = params.myTransition1 or easing.linear   
    local myTransition2 = params.myTransition2 or easing.linear   
    
    if calcOnly == true then
        return splitColumns * delayShift + delayShift  + timeShift --+1
    end
    
    for myRows = splitRows,1,-1 do
        for  myCols = splitColumns ,1 , -1 do
            local chunk
            
            chunk =  chunkMap[myRows.."x"][myCols.."x"].DO
            --lets do a transition
            transition.to(chunk.image.path, {delay = (splitColumns - myCols )* delayShift, time = timeShift, x3 = math.floor(chunk.image.path.x3 + pixelShiftX), x4 =math.floor( chunk.image.path.x4 + pixelShiftX),y3 = math.floor(chunk.image.path.y3 + pixelShiftY), y4 = math.floor(chunk.image.path.y4 + pixelShiftY) , transition = myTransition1 })
            transition.to(chunk.image.path, {delay = (splitColumns - myCols )* delayShift + delayShift +1, time = timeShift, x1 = math.floor(chunk.image.path.x1 + pixelShiftX),x2 = math.floor(chunk.image.path.x2 + pixelShiftX), y1 = math.floor(chunk.image.path.y1 + pixelShiftY), y2 = math.floor(chunk.image.path.y2 + pixelShiftY), transition = myTransition2})
            
        end
    end
end
meshTransitions.transition3 =function(spriteMesh, params,calcOnly)
    
    local params = params or {}
    local  splitColumns = spriteMesh.columns 
    local  splitRows = spriteMesh.rows 
    
    local chunkMap = spriteMesh.chunkMap
    local delayShift = params.delayShift or 1000
    local timeShift = params.timeShift or 3000
    local pixelShiftX = params.pixelShiftX or 1000
    local pixelShiftY = params.pixelShiftY or 1000
    local myTransition1 = params.myTransition1 or easing.linear
    local myTransition2 = params.myTransition2 or easing.linear   
    
    
    if calcOnly == true then
        return splitColumns * delayShift + delayShift  + timeShift --+1
    end
    
    --looks like we have some conditions to look at.....
    
    for myRows = 1 , splitRows do
        
        
        for myShifts = 1, splitColumns  do
            local chunk
            print("Col,row:",myShifts,myRows)
            chunk =  chunkMap[myRows.."x"][myShifts.."x"].DO
            --lets do a transition
            transition.to(chunk.image.path, {delay = myShifts * delayShift, time = timeShift, x1 = math.floor(chunk.image.path.x1 + pixelShiftX), x2 = math.floor(chunk.image.path.x2 + pixelShiftX), y1 = math.floor(chunk.image.path.y1 + pixelShiftY), y2 = math.floor(chunk.image.path.y2 + pixelShiftY), transition = myTransition1 })
            transition.to(chunk.image.path, {delay = myShifts * delayShift + delayShift +1, time = timeShift, x3 = math.floor(chunk.image.path.x3 + pixelShiftX), x4 =math.floor( chunk.image.path.x4 + pixelShiftX),y3 = math.floor(chunk.image.path.y3 + pixelShiftY), y4 = math.floor(chunk.image.path.y4 + pixelShiftY) , transition = myTransition2 }) -- })
            
        end
    end
end





--Test transitions


meshTransitions.slimeRight = function(spriteMesh, params,calcOnly)
    
    local params = params or {}
    local  splitColumns = spriteMesh.columns 
    local  splitRows = spriteMesh.rows 
    
    local chunkMap = spriteMesh.chunkMap
    local delayShift = params.delayShift or 1000
    local timeShift = params.timeShift or 3000
    local pixelShiftX = params.pixelShiftX or 1000
    local pixelShiftY = params.pixelShiftY or 1000
    
    
    if calcOnly == true then
        return (splitColumns * delayShift + delayShift  + timeShift ) / splitColumns--+1
    end
    
    --looks like we have some conditions to look at.....
    
    for myRows =  splitRows,1,-1 do
        
        
        for myShifts = splitColumns ,1,-1 do
            
            --here we want to look at the column, if it is the very right, move just paths 3,4
            -- if the first, just move 1,2
            --if the middle, move 1,2 on one piece, and 3,4 on the piece to the left
            
            
            --rightmost piece
            if myShifts == splitColumns then
                local chunk
                
                chunk =  chunkMap[myRows.."x"][myShifts.."x"].DO
                transition.to(chunk.image.path, {delay = (splitColumns - myShifts + 1  ) * delayShift/splitColumns , time = timeShift/splitColumns, x3 = chunk.image.path.x3 - pixelShiftX, x4 = chunk.image.path.x4 - pixelShiftX,y3 = chunk.image.path.y3 - pixelShiftY, y4 = chunk.image.path.y4 - pixelShiftY }) --, transition = easing.bounce })
                
                --left most piece
            elseif myShifts == 1 then
                local chunk,chunkRight
                
                chunk =  chunkMap[myRows.."x"][myShifts.."x"].DO
                chunkRight =  chunkMap[myRows.."x"][(myShifts + 1) .."x"].DO
                
                --lets do a transition
                transition.to(chunkRight.image.path, {delay = (splitColumns - myShifts +1   ) * delayShift /splitColumns, time = timeShift/splitColumns, x1 = chunk.image.path.x1 - pixelShiftX, x2 = chunk.image.path.x2 - pixelShiftX, y1 = chunk.image.path.y1 - pixelShiftY, y2 = chunk.image.path.y2 - pixelShiftY })
                
                --lets do a transition
                transition.to(chunk.image.path, {delay =  (splitColumns - myShifts  +1 ) * delayShift/splitColumns , time = timeShift/splitColumns , x3 = chunk.image.path.x3 - pixelShiftX, x4 = chunk.image.path.x4 - pixelShiftX,y3 = chunk.image.path.y3 - pixelShiftY, y4 = chunk.image.path.y4 - pixelShiftY }) --, transition = easing.bounce })
                
                transition.to(chunk.image.path, {delay = (splitColumns - myShifts + 2  ) * delayShift/splitColumns , time = timeShift/splitColumns, x1 = chunk.image.path.x1 - pixelShiftX, x2 = chunk.image.path.x2 - pixelShiftX, y1 = chunk.image.path.y1 - pixelShiftY, y2 = chunk.image.path.y2 - pixelShiftY })
            else
                local chunk,chunkRight
                
                chunk =  chunkMap[myRows.."x"][myShifts.."x"].DO
                chunkRight =  chunkMap[myRows.."x"][(myShifts + 1) .."x"].DO
                
                --lets do a transition
                transition.to(chunkRight.image.path, {delay = (splitColumns - myShifts +1 ) * delayShift /splitColumns+ 1, time = timeShift/splitColumns, x1 = chunk.image.path.x1 - pixelShiftX, x2 = chunk.image.path.x2 - pixelShiftX, y1 = chunk.image.path.y1 - pixelShiftY, y2 = chunk.image.path.y2 - pixelShiftY })
                transition.to(chunk.image.path, {delay = (splitColumns -myShifts   + 1 )* delayShift /splitColumns, time = timeShift/splitColumns, x3 = chunk.image.path.x3 - pixelShiftX, x4 = chunk.image.path.x4 - pixelShiftX,y3 = chunk.image.path.y3 - pixelShiftY, y4 = chunk.image.path.y4 - pixelShiftY }) --, transition = easing.bounce })
                
            end
            
        end
    end
end

meshTransitions.transition3a =function(spriteMesh, params,calcOnly)
    
    local params = params or {}
    local  splitColumns = spriteMesh.columns 
    local  splitRows = spriteMesh.rows 
    
    local chunkMap = spriteMesh.chunkMap
    local delayShift = params.delayShift or 1000
    local timeShift = params.timeShift or 3000
    local pixelShiftX = params.pixelShiftX or 1000
    local pixelShiftY = params.pixelShiftY or 1000
    
    
    if calcOnly == true then
        return splitColumns * delayShift + delayShift  + timeShift --+1
    end
    
    --looks like we have some conditions to look at.....
    
    for myRows =  splitRows,1,-1 do
        
        
        for myShifts = splitColumns ,1,-1 do
            local chunk
            print("Col,row:",myShifts,myRows)
            chunk =  chunkMap[myShifts..""][myRows..""].DO
            
            --lets do a transition
            --  transition.to(chunk.image.path, {delay = myShifts - splitColumns +1  * delayShift, time = timeShift, x1 = chunk.image.path.x1 - pixelShiftX, x2 = chunk.image.path.x2 - pixelShiftX, y1 = chunk.image.path.y1 - pixelShiftY, y2 = chunk.image.path.y2 - pixelShiftY })
            --  transition.to(chunk.image.path, {delay = myShifts - splitColumns + 1 * delayShift + delayShift +1, time = timeShift, x3 = chunk.image.path.x3 - pixelShiftX, x4 = chunk.image.path.x4 - pixelShiftX,y3 = chunk.image.path.y3 - pixelShiftY, y4 = chunk.image.path.y4 - pixelShiftY }) --, transition = easing.bounce })
            
            transition.to(chunk.image.path, {delay = myShifts * delayShift, time = timeShift, x1 = math.floor(chunk.image.path.x1 + pixelShiftX), x2 = math.floor(chunk.image.path.x2 + pixelShiftX), y1 = math.floor(chunk.image.path.y1 + pixelShiftY), y2 = math.floor(chunk.image.path.y2 + pixelShiftY) })
            transition.to(chunk.image.path, {delay = myShifts * delayShift + delayShift +1, time = timeShift, x3 = math.floor(chunk.image.path.x3 + pixelShiftX), x4 =math.floor( chunk.image.path.x4 + pixelShiftX),y3 = math.floor(chunk.image.path.y3 + pixelShiftY), y4 = math.floor(chunk.image.path.y4 + pixelShiftY) }) --, transition = easing.bounce })
            
        end
    end
end




meshTransitions.sliceLeft = function(spriteMesh, params,calcOnly)
    
    local params = params or {}
    local  splitColumns = spriteMesh.columns 
    local  splitRows = spriteMesh.rows 
    
    local chunkMap = spriteMesh.chunkMap
    local delayShift = params.delayShift or 1000
    local timeShift = params.timeShift or 3000
    local pixelShiftX = params.pixelShiftX or 1000
    local pixelShiftY = params.pixelShiftY or 1000
    
    
    if calcOnly == true then
        return splitColumns * delayShift + delayShift  + timeShift --+1
    end
    
    --looks like we have some conditions to look at.....
    
    for myRows =  splitRows,1,-1 do
        
        
        for myShifts = splitColumns ,1,-1 do
            
            --here we want to look at the column, if it is the very right, move just paths 3,4
            -- if the first, just move 1,2
            --if the middle, move 1,2 on one piece, and 3,4 on the piece to the left
            
            
            --rightmost piece
            if myShifts == splitColumns then
                local chunk
                
                chunk =  chunkMap[myRows.."x"][myShifts.."x"].DO
                transition.to(chunk.image.path, {delay = (splitColumns - myShifts + 1 ) * delayShift , time = timeShift, x3 = chunk.image.path.x3 - pixelShiftX, x4 = chunk.image.path.x4 - pixelShiftX,y3 = chunk.image.path.y3 - pixelShiftY, y4 = chunk.image.path.y4 - pixelShiftY }) --, transition = easing.bounce })
                
                --left most piece
            elseif myShifts == 1 then
                local chunk,chunkRight
                
                chunk =  chunkMap[myRows.."x"][myShifts.."x"].DO
                chunkRight =  chunkMap[myRows.."x"][(myShifts + 1) .."x"].DO
                
                --lets do a transition
                transition.to(chunkRight.image.path, {delay = (splitColumns - myShifts  ) * delayShift, time = timeShift, x1 = chunk.image.path.x1 - pixelShiftX, x2 = chunk.image.path.x2 - pixelShiftX, y1 = chunk.image.path.y1 - pixelShiftY, y2 = chunk.image.path.y2 - pixelShiftY })
                
                --lets do a transition
                transition.to(chunk.image.path, {delay =  (splitColumns - myShifts  ) * delayShift , time = timeShift , x3 = chunk.image.path.x3 - pixelShiftX, x4 = chunk.image.path.x4 - pixelShiftX,y3 = chunk.image.path.y3 - pixelShiftY, y4 = chunk.image.path.y4 - pixelShiftY }) --, transition = easing.bounce })
                
                transition.to(chunk.image.path, {delay = (splitColumns - myShifts+1  ) * delayShift, time = timeShift, x1 = chunk.image.path.x1 - pixelShiftX, x2 = chunk.image.path.x2 - pixelShiftX, y1 = chunk.image.path.y1 - pixelShiftY, y2 = chunk.image.path.y2 - pixelShiftY })
            else
                local chunk,chunkRight
                
                chunk =  chunkMap[myRows.."x"][myShifts.."x"].DO
                chunkRight =  chunkMap[myRows.."x"][(myShifts + 1) .."x"].DO
                
                --lets do a transition
                transition.to(chunkRight.image.path, {delay = (splitColumns - myShifts  ) * delayShift, time = timeShift, x1 = chunk.image.path.x1 - pixelShiftX, x2 = chunk.image.path.x2 - pixelShiftX, y1 = chunk.image.path.y1 - pixelShiftY, y2 = chunk.image.path.y2 - pixelShiftY })
                transition.to(chunk.image.path, {delay = (splitColumns -myShifts   + 1 )* delayShift , time = timeShift, x3 = chunk.image.path.x3 - pixelShiftX, x4 = chunk.image.path.x4 - pixelShiftX,y3 = chunk.image.path.y3 - pixelShiftY, y4 = chunk.image.path.y4 - pixelShiftY }) --, transition = easing.bounce })
                
            end
            
        end
    end
end





meshTransitions.RayTest = function(spriteMesh, params,calcOnly)
    
    local params = params or {}
    local  splitColumns = spriteMesh.columns 
    local  splitRows = spriteMesh.rows 
    
    local chunkMap = spriteMesh.chunkMap
    local delayShift = params.delayShift or 1000
    local timeShift = params.timeShift or 3000
    local pixelShiftX = params.pixelShiftX or 1000
    local pixelShiftY = params.pixelShiftY or 1000
    
    
    if calcOnly == true then
        return (splitColumns * delayShift + delayShift  + timeShift ) / splitColumns--+1
    end
    
    
    
    for myRows =  splitRows,1,-1 do
        
        
        for myShifts = splitColumns ,1,-1 do
            
            
            local   chunk =  chunkMap[myRows.."x"][myShifts.."x"].DO
            local   chunkRight =  chunk --chunkMap[myRows.."x"][(myShifts + 1) .."x"].DO
            
            --lets do a transition on some variables instead?
            
            local myThing = {}
            myThing.x , myThing.y = 0,0
            
            transition.to(myThing, {delay =delayShift , time  = timeShift, x = pixelShiftX, y = pixelShiftY} )
            
            --transition.to(chunkRight.image.path, {delay = (splitColumns - myShifts +1 ) * delayShift /splitColumns+ 1, time = timeShift/splitColumns, x1 = chunk.image.path.x1 - pixelShiftX, x2 = chunk.image.path.x2 - pixelShiftX, y1 = chunk.image.path.y1 - pixelShiftY, y2 = chunk.image.path.y2 - pixelShiftY })
            --transition.to(chunk.image.path, {delay = (splitColumns -myShifts   + 1 )* delayShift /splitColumns, time = timeShift/splitColumns, x3 = chunk.image.path.x3 - pixelShiftX, x4 = chunk.image.path.x4 - pixelShiftX,y3 = chunk.image.path.y3 - pixelShiftY, y4 = chunk.image.path.y4 - pixelShiftY }) --, transition = easing.bounce })
            
            
            
        end
    end
end







return meshTransitions
