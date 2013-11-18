--[[
        Transition Chain
        (c) 2013 S.K. Studios, LLC
        
        This module will allow you to add transitions to an object, so that they will play one after each other
        
--]]

local meshTransitions = require("meshTransitions")

local transitionChainController = {}

transitionChainController.new = function()
    
    local transitionChain = {}
    transitionChain.delayTime = 0
    
    transitionChain.add = function(myDelay, myTime,myMesh, myTransitionFunction, myTransitionFunctionParamaters)
        --we need to figure out a way to 'get' the total time a transition function will wind up taking in total
        transitionChain.delayTime = transitionChain.delayTime + myDelay 
        
        --we need some sort of function to calculate what the time 'will' wind up being for the transition:
        local myTime = myTransitionFunction(myMesh,myTransitionFunctionParamaters, true)
        print("Timer:",myTime)
        transitionChain[#transitionChain+1]= timer.performWithDelay(transitionChain.delayTime, 
        function() 
            myTransitionFunction(myMesh, myTransitionFunctionParamaters)
        end
        , 1)
        
        transitionChain.delayTime = transitionChain.delayTime + myTime
        
        
        
    end
    
    return transitionChain
end





return transitionChainController