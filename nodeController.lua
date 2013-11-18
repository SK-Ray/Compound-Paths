--[[
        nodes.lua
        (c) 2013 S.K. Studios, LLC
        R.Delia
        
        
--]]
local nodeController = {}

nodeController.new = function()
    local nodes = {}
    
    return nodes
end





nodeController.createOneNode= function(mySpriteMesh, myImage,myNodeNumber,row,column,nodeHandleRadius,mainGroup)
    -----------------NodeG
local mainGroup = mySpriteMesh.mainGroup

    local nodeG
   
    if myNodeNumber == 1 then
        nodeG = display.newCircle(myImage.x - myImage.width /2, myImage.y - myImage.height/2,  nodeHandleRadius)
        myImage.node1 = nodeG
    elseif myNodeNumber ==2 then
        nodeG = display.newCircle(myImage.x - myImage.width /2, myImage.y  + myImage.height/2,  nodeHandleRadius)
        myImage.node2 = nodeG
    elseif myNodeNumber ==3 then
        nodeG = display.newCircle(myImage.x + myImage.width /2, myImage.y + myImage.height/2,  nodeHandleRadius)
        myImage.node3 = nodeG
        ---@livecode myImage.x = number
    elseif myNodeNumber ==4 then
        nodeG = display.newCircle(myImage.x + myImage.width/2, myImage.y- myImage.height/2,  nodeHandleRadius)
        myImage.node4 = nodeG
        
    end
    
     nodeG.nodeTouched = nil
    nodeG.daddys = {}
    nodeG:setFillColor(0,77,120, 255)
    
    mainGroup:insert(nodeG)
    nodeG.row = row
    nodeG.column = column
    
    --keep a  ref to your image 
    nodeG.image = myImage
    nodeG.DO = nodeG
    nodeG.myNodeNumber = myNodeNumber
    
    local myNode = {}
    if myNodeNumber == 1 then
        myNode = myImage.node1
        myNode.x = myImage.path.x1
        myNode.y = myImage.path.y1
        
    elseif myNodeNumber ==2 then
                myNode = myImage.node2

        myNode.x = myImage.path.x2
        myNode.y = myImage.path.y2
    elseif myNodeNumber ==3 then
                myNode = myImage.node3
        myNode.x = myImage.path.x3
        myNode.y = myImage.path.y3
    elseif myNodeNumber ==4 then
                myNode = myImage.node4

        myNode.x = myImage.path.x4
        myNode.y = myImage.path.y4
    end
    
    nodeG.myNodeNumber = myNodeNumber
    nodeG.myNode = myNode
    
    local chunkMap = mySpriteMesh.chunkMap
    --we have our node positions now, so we can loop through the collection and see if ther are any that already match up.. if so, we subscibe to it....
    --we may have to bring all the nodes to the fron again too though ....
    
    print(nodeG.column,nodeG.row,"**")
    
--        chunkMap[nodeG.column.." "][nodeG.row.." "] = nodeG 
chunkMap[nodeG.column.."x"][nodeG.row.."x"] = nodeG 
    
    local nodeCollection = mySpriteMesh.nodeCollection
    table.insert(nodeCollection, nodeG)
    
    nodeG.touch = function(self,event)
        
        if event.phase == "began" then
            
            if nodeG.nodeTouched == nil then
                nodeG.nodeTouched = self
                display.currentStage:setFocus(nodeG)
            end
            
            if nodeG.nodeTouched == self then
            else
                return true
            end
            
            nodeG.rememberX = self.x
            nodeG.rememberY = self.y
            nodeG.rememberPathX = myNode.x
            nodeG.rememberPathY = myNode.y
            
            nodeG.diffX = event.x - self.x
            nodeG.diffY = event.y - self.y
        end
        
        if event.phase == "moved" then
            
            if nodeG.nodeTouched ~= self then
                return true
            end
            
            -- dont let the node go past screen boundaries for now
            if event.x < 0 or event.x > display.contentWidth then
                return true
            end
            
            if event.y < 0 or event.y > display.contentHeight then
                return true
            end
            
            nodeG.x= event.x - nodeG.diffX
            nodeG.y =event.y - nodeG.diffY
            myNode.x = nodeG.rememberPathX + nodeG.x - nodeG.rememberX 
            myNode.y = nodeG.rememberPathY + nodeG.y - nodeG.rememberY  
            
            if myNodeNumber == 1 then
                myImage.path.x1 =myNode.x 
                myImage.path.y1 =myNode.y 
            elseif myNodeNumber ==2 then
                myImage.path.x2 = myNode.x 
                myImage.path.y2 = myNode.y 
            elseif myNodeNumber ==3 then
                myImage.path.x3 = myNode.x 
                myImage.path.y3 = myNode.y 
            elseif myNodeNumber ==4 then
                myImage.path.x4 = myNode.x 
                myImage.path.y4 = myNode.y 
            end
            
            nodeG.x = (myNode.x + nodeG.rememberX - nodeG.rememberPathX )
            nodeG.y =  ( myNode.y + nodeG.rememberY - nodeG.rememberPathY )
            
            
            --broadcast our message to followers
            
            if ( nil ) then
                local k
            end
            local myMessageX = (  nodeG.x - nodeG.rememberX  )
            local myMessageY = ( nodeG.y - nodeG.rememberY )
            
            
            local myEvent = { name = "broadcast" , target = Runtime, broadcaster = nodeG, messageX =myMessageX , messageY = myMessageY}
            Runtime:dispatchEvent(myEvent)
            --  print(myEvent.name,myEvent.broadcaster)
            
        end
        
        if event.phase == "ended" then
            display.currentStage:setFocus(nil)
            
            if (nodeG.rememberX == nil) then
                return 
                -- :)
            end
            nodeG.x = myNode.x + nodeG.rememberX- nodeG.rememberPathX
            nodeG.y = myNode.y + nodeG.rememberY- nodeG.rememberPathY
            
            if myNodeNumber == 1 then
                myImage.path.x1 =myNode.x 
                myImage.path.y1 =myNode.y 
            elseif myNodeNumber ==2 then
                myImage.path.x2 = myNode.x 
                myImage.path.y2 = myNode.y 
            elseif myNodeNumber ==3 then
                myImage.path.x3 = myNode.x 
                myImage.path.y3 = myNode.y 
            elseif myNodeNumber ==4 then
                myImage.path.x4 = myNode.x 
                myImage.path.y4 = myNode.y 
            end
            
            --now broadcast to children:
            local myEvent = { name = "broadcast" , target = Runtime, broadcaster = nodeG, messageX =0 , messageY = 0, isFinal = true}
            Runtime:dispatchEvent(myEvent)
            
            nodeG.nodeTouched = nil
        end
        
        return true
    end
    
    nodeG.broadCastListener = function(event)
        
        if event.broadcaster == nodeG then
            return
        end
        
        -- go through all the daddy records
        for i = 1 , #nodeG.daddys do
            --if we have the same x,y coords, lets move!
            if (nodeG.daddys[i] == event.broadcaster ) then  
                
                if nodeG.rememberPathX == nil then
                    nodeG.rememberPathX = nodeG.myNode.x
                    nodeG.rememberPathY = nodeG.myNode.y  
                end
                
                if nodeG.diffX == nil then
                    nodeG.diffX = nodeG.daddys[i].x - nodeG.x
                    nodeG.diffY = nodeG.daddys[i].y - nodeG.y
                end
                
                if event.isFinal == true then
                    --nothing here
                else
                    
                    if nodeG.myNodeNumber == 1 then
                        nodeG.image.path.x1 =nodeG.rememberPathX + event.messageX --nodeG.image.path.x1 + 
                        nodeG.image.path.y1 =nodeG.rememberPathY + event.messageY --nodeG.image.path.y1 + 
                    elseif nodeG.myNodeNumber ==2 then
                        nodeG.image.path.x2 = nodeG.rememberPathX + event.messageX
                        nodeG.image.path.y2 = nodeG.rememberPathY + event.messageY 
                    elseif nodeG.myNodeNumber ==3 then
                        nodeG.image.path.x3 = nodeG.rememberPathX + event.messageX
                        nodeG.image.path.y3 = nodeG.rememberPathY + event.messageY 
                    elseif nodeG.myNodeNumber ==4 then
                        nodeG.image.path.x4 = nodeG.rememberPathX + event.messageX
                        nodeG.image.path.y4 = nodeG.rememberPathY + event.messageY 
                    end
                end
                
                
                if event.isFinal == true then
                    
                    if nodeG.myNodeNumber ==1 then
                        nodeG.rememberPathX = nodeG.image.path.x1 
                        nodeG.rememberPathY = nodeG.image.path.y1 
                    elseif nodeG.myNodeNumber ==2 then
                        nodeG.rememberPathX = nodeG.image.path.x2 
                        nodeG.rememberPathY = nodeG.image.path.y2 
                    elseif nodeG.myNodeNumber ==3 then
                        nodeG.rememberPathX = nodeG.image.path.x3 
                        nodeG.rememberPathY = nodeG.image.path.y3 
                    elseif nodeG.myNodeNumber ==4 then
                        nodeG.rememberPathX = nodeG.image.path.x4 
                        nodeG.rememberPathY = nodeG.image.path.y4 
                    end
                end
                
                --move the node
                nodeG:toFront()
                nodeG:setFillColor(255, 255)
                nodeG.x =    event.broadcaster.DO.x -nodeG.diffX 
                nodeG.y =   event.broadcaster.DO.y - nodeG.diffY 
                
                if event.isFinal == true then
                    nodeG.diffX =nil
                    nodeG.diffY =nil
                end
                
            end
        end --do
        
    end
    
    nodeG:addEventListener("touch", nodeG)
    Runtime:addEventListener("broadcast", nodeG.broadCastListener)
    
    mainGroup:insert(nodeG.DO)
    
end
--createOneNode= function(mySpriteMesh, myImage,myNodeNumber,row,column,nodeHandleRadius)
nodeController.createNodes = function(mySpriteMesh,myImage,row,column,nodeHandleRadius,mainGroup)
    nodeController.createOneNode(mySpriteMesh,myImage, 1,row,column,nodeHandleRadius,mainGroup)
    nodeController.createOneNode(mySpriteMesh,myImage, 2,row,column,nodeHandleRadius,mainGroup)
    nodeController.createOneNode(mySpriteMesh,myImage, 3,row,column,nodeHandleRadius,mainGroup)
    nodeController.createOneNode(mySpriteMesh,myImage, 4,row,column,nodeHandleRadius,mainGroup)
 --   myImage:removeSelf()
end
--Finally remove existing image




--here we assign parents to those nodes who are on the same x,y coordinate.
--we can extend this idea by parenting an entire row or column of nodes together
nodeController.parentNodeCollection=function(nodeCollection)
    
    for i = #nodeCollection, 1 , -1 do
        local  myNode = nodeCollection[i]
        for j = #nodeCollection, 1 , -1 do
            
            if i == j then
                -- do nothing
            else
                --check for a match to an existing...
                if (nodeCollection[j].x == myNode.x)  then --and (nodeCollection[j].y == myNode.y) then
                    myNode:setFillColor(255,0,0,255)
                    --we have all the overlaps colored in red
                    
                    if myNode.isDupe == true then
                        
                    else
                        myNode.daddys[#myNode.daddys + 1] = nodeCollection[j]
                    end
                    
                    -- myNode.isDupe =true
                    
                else
                    --do nothing
                end
                
                -- if we are in the same row, lets parent the node:
                if (nodeCollection[j].row == myNode.row) and ( nodeCollection[j] ~= myNode) then
                    if myNode.nodeNumber == 1 then
                        --    myNode.daddy = nodeCollection[j]
                    elseif myNode.nodeNumber ==2 then
                    elseif myNode.nodeNumber ==3 then
                    elseif myNode.nodeNumber ==4 then
                        
                    end
                    
                    
                end
            end
            
            
        end
    end
    
end

nodeController.hideNodes =function(nodeCollection)
    for i = 1, #nodeCollection  do
     nodeCollection[i].DO.isVisible = false
        nodeCollection[i].DO.isHitTestable = true
        
    end
end




nodeController.showNodes=  function(nodeCollection)
    for i = 1, #nodeCollection  do
        nodeCollection[i].DO.isVisible = true
        nodeCollection[i].DO.isHitTestable = true
        
    end
end

--remove all broadcast parent id's from nodes
nodeController.clearNodeDaddys=  function (nodeCollection) 
    for i =1, #nodeCollection do
        nodeCollection[i].daddy = nil
    end
end


--nodeController.showNodes()
--nodeController.hideNodes()

return nodeController
